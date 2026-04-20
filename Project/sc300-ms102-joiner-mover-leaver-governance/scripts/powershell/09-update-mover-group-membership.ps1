param(
    [string]$CsvPath = "C:\Users\vm1\Desktop\mover-users.csv"
)

$movers = Import-Csv $CsvPath
$results = @()

foreach ($m in $movers) {
    try {
        $user = Get-MgUser -UserId $m.CurrentUserPrincipalName -ErrorAction Stop

        $oldGroup = Get-MgGroup -Filter "displayName eq '$($m.OldDepartmentGroup)'" -ConsistencyLevel eventual
        $newGroup = Get-MgGroup -Filter "displayName eq '$($m.NewDepartmentGroup)'" -ConsistencyLevel eventual
        $moverPilot = Get-MgGroup -Filter "displayName eq 'SG-MOVER-PILOT'" -ConsistencyLevel eventual

        if ($oldGroup) {
            $oldMembers = Get-MgGroupMember -GroupId $oldGroup.Id -All
            $oldMembership = $oldMembers | Where-Object { $_.Id -eq $user.Id }

            if ($oldMembership) {
                Remove-MgGroupMemberByRef -GroupId $oldGroup.Id -DirectoryObjectId $user.Id
                $results += [pscustomobject]@{
                    UserPrincipalName = $m.CurrentUserPrincipalName
                    GroupName         = $m.OldDepartmentGroup
                    Action            = "Removed"
                    Status            = "Success"
                    Notes             = "Removed from old department group"
                }
            }
        }

        if ($newGroup) {
            $newMembers = Get-MgGroupMember -GroupId $newGroup.Id -All
            $newMembership = $newMembers | Where-Object { $_.Id -eq $user.Id }

            if (-not $newMembership) {
                New-MgGroupMemberByRef -GroupId $newGroup.Id -BodyParameter @{
                    "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$($user.Id)"
                }

                $results += [pscustomobject]@{
                    UserPrincipalName = $m.CurrentUserPrincipalName
                    GroupName         = $m.NewDepartmentGroup
                    Action            = "Added"
                    Status            = "Success"
                    Notes             = "Added to new department group"
                }
            }
        }

        if ($moverPilot) {
            $pilotMembers = Get-MgGroupMember -GroupId $moverPilot.Id -All
            $pilotMembership = $pilotMembers | Where-Object { $_.Id -eq $user.Id }

            if (-not $pilotMembership) {
                New-MgGroupMemberByRef -GroupId $moverPilot.Id -BodyParameter @{
                    "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$($user.Id)"
                }

                $results += [pscustomobject]@{
                    UserPrincipalName = $m.CurrentUserPrincipalName
                    GroupName         = "SG-MOVER-PILOT"
                    Action            = "Added"
                    Status            = "Success"
                    Notes             = "Added to mover pilot group"
                }
            }
        }
    }
    catch {
        $results += [pscustomobject]@{
            UserPrincipalName = $m.CurrentUserPrincipalName
            GroupName         = ""
            Action            = "MembershipUpdate"
            Status            = "Failed"
            Notes             = $_.Exception.Message
        }
    }
}

$results | Export-Csv "C:\Users\vm1\Desktop\mover-group-update-results.csv" -NoTypeInformation
$results
