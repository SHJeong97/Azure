param(
    [string]$UserCsvPath = "C:\Users\vm1\Desktop\planned-users.csv"
)

function Get-DepartmentGroup {
    param([string]$Department)

    switch ($Department.ToUpper()) {
        "HR"         { return "SG-DEPT-HR" }
        "FINANCE"    { return "SG-DEPT-FINANCE" }
        "SALES"      { return "SG-DEPT-SALES" }
        "OPERATIONS" { return "SG-DEPT-OPERATIONS" }
        "IT"         { return "SG-DEPT-IT" }
        "EXECUTIVE"  { return "SG-DEPT-EXEC" }
        default      { throw "No department group mapping for $Department" }
    }
}

$users = Import-Csv $UserCsvPath
$results = @()

foreach ($u in $users) {
    try {
        $user = Get-MgUser -UserId $u.UserPrincipalName -ErrorAction Stop

        $targetGroups = @()
        $targetGroups += (Get-DepartmentGroup -Department $u.Department)

        if ($u.LicenseGroup) {
            $targetGroups += $u.LicenseGroup
        }

        if ($u.AdminRole -eq "Helpdesk Administrator") {
            $targetGroups += "SG-ADMIN-HELPDESK"
        }

        if ($u.AdminRole -eq "Identity Administrator") {
            $targetGroups += "SG-ADMIN-IDENTITY"
        }

        $targetGroups = $targetGroups | Select-Object -Unique

        foreach ($groupName in $targetGroups) {
            $group = Get-MgGroup -Filter "displayName eq '$groupName'" -ConsistencyLevel eventual

            if (-not $group) {
                $results += [pscustomobject]@{
                    UserPrincipalName = $u.UserPrincipalName
                    GroupName         = $groupName
                    Status            = "Failed"
                    Notes             = "Group not found"
                }
                continue
            }

            $members = Get-MgGroupMember -GroupId $group.Id -All
            $alreadyMember = $members | Where-Object { $_.Id -eq $user.Id }

            if ($alreadyMember) {
                $results += [pscustomobject]@{
                    UserPrincipalName = $u.UserPrincipalName
                    GroupName         = $groupName
                    Status            = "AlreadyMember"
                    Notes             = "User already in group"
                }
                continue
            }

            New-MgGroupMemberByRef -GroupId $group.Id -BodyParameter @{
                "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$($user.Id)"
            }

            $results += [pscustomobject]@{
                UserPrincipalName = $u.UserPrincipalName
                GroupName         = $groupName
                Status            = "Added"
                Notes             = "Membership assigned"
            }
        }
    }
    catch {
        $results += [pscustomobject]@{
            UserPrincipalName = $u.UserPrincipalName
            GroupName         = ""
            Status            = "Failed"
            Notes             = $_.Exception.Message
        }
    }
}

$results | Export-Csv "C:\Users\vm1\Desktop\group-membership-results.csv" -NoTypeInformation
$results
