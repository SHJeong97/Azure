param(
    [string]$CsvPath = ".\data\users\leaver-users.csv"
)

$leavers = Import-Csv $CsvPath
$results = @()

$leaverPilot = Get-MgGroup -Filter "displayName eq 'SG-LEAVER-PILOT'" -ConsistencyLevel eventual

foreach ($l in $leavers) {
    try {
        $user = Get-MgUser -UserId $l.UserPrincipalName -ErrorAction Stop
        $memberOf = Get-MgUserMemberOf -UserId $user.Id -All

        foreach ($obj in $memberOf) {
            $groupName = $obj.AdditionalProperties["displayName"]

            if ($groupName -and $groupName -like "SG-*" -and $groupName -ne "SG-LEAVER-PILOT") {
                Remove-MgGroupMemberByRef -GroupId $obj.Id -DirectoryObjectId $user.Id

                $results += [pscustomobject]@{
                    UserPrincipalName = $l.UserPrincipalName
                    GroupName         = $groupName
                    Action            = "Removed"
                    Status            = "Success"
                    Notes             = "Removed from access group"
                }
            }
        }

        if ($leaverPilot) {
            $pilotMembers = Get-MgGroupMember -GroupId $leaverPilot.Id -All
            $alreadyInPilot = $pilotMembers | Where-Object { $_.Id -eq $user.Id }

            if (-not $alreadyInPilot) {
                New-MgGroupMemberByRef -GroupId $leaverPilot.Id -BodyParameter @{
                    "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$($user.Id)"
                }

                $results += [pscustomobject]@{
                    UserPrincipalName = $l.UserPrincipalName
                    GroupName         = "SG-LEAVER-PILOT"
                    Action            = "Added"
                    Status            = "Success"
                    Notes             = "Added to leaver pilot tracking group"
                }
            }
        }
    }
    catch {
        $results += [pscustomobject]@{
            UserPrincipalName = $l.UserPrincipalName
            GroupName         = ""
            Action            = "AccessRemoval"
            Status            = "Failed"
            Notes             = $_.Exception.Message
        }
    }
}

$results | Export-Csv ".\evidence\cli-output\leaver-access-removal-results.csv" -NoTypeInformation
$results
