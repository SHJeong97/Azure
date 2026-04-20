param(
    [string]$CsvPath = "C:\Users\vm1\Desktop\baseline-users.csv"
)

$users = Import-Csv $CsvPath
$results = @()

foreach ($u in $users) {
    try {
        $user = Get-MgUser -UserId $u.UserPrincipalName -ErrorAction Stop
        $targetGroups = @($u.LicenseGroup, $u.DepartmentGroup) | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Unique

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

$results | Export-Csv ".\evidence\cli-output\baseline-membership-results.csv" -NoTypeInformation
$results
