param(
    [string]$CsvPath = "C:\Users\vm1\Desktop\pilot-users.csv"
)

$users = Import-Csv $CsvPath
$results = @()

foreach ($u in $users) {
    try {
        $user = Get-MgUser -UserId $u.UserPrincipalName -ErrorAction Stop
        $targetGroups = @()

        if ($u.LicenseGroup) {
            $targetGroups += $u.LicenseGroup
        }

        switch ($u.Department.ToUpper()) {
            "FINANCE"    { $targetGroups += "SG-DEPT-FINANCE-COLLAB" }
            "OPERATIONS" { $targetGroups += "SG-DEPT-OPERATIONS-COLLAB" }
            "HR"         { $targetGroups += "SG-DEPT-HR-COLLAB" }
            "SALES"      { $targetGroups += "SG-DEPT-SALES-COLLAB" }
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
                Notes             = "Pilot membership assigned"
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

$results | Export-Csv C:\Users\vm1\Desktop\pilot-membership-results-project4.csv" -NoTypeInformation
$results
