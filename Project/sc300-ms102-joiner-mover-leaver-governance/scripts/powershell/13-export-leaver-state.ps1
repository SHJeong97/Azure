param(
    [string]$CsvPath = "C:\Users\vm1\Desktop\leaver-users.csv"
)

$leavers = Import-Csv $CsvPath
$results = @()

foreach ($l in $leavers) {
    try {
        $user = Get-MgUser -UserId $l.UserPrincipalName -Property "displayName,userPrincipalName,department,accountEnabled" -ErrorAction Stop
        $memberOf = Get-MgUserMemberOf -UserId $user.Id -All

        $groupNames = @()
        foreach ($obj in $memberOf) {
            $groupName = $obj.AdditionalProperties["displayName"]
            if ($groupName) {
                $groupNames += $groupName
            }
        }

        $results += [pscustomobject]@{
            DisplayName       = $user.DisplayName
            UserPrincipalName = $user.UserPrincipalName
            Department        = $user.Department
            AccountEnabled    = $user.AccountEnabled
            RemainingGroups   = ($groupNames | Sort-Object) -join "; "
        }
    }
    catch {
        $results += [pscustomobject]@{
            DisplayName       = ""
            UserPrincipalName = $l.UserPrincipalName
            Department        = ""
            AccountEnabled    = "ERROR"
            RemainingGroups   = $_.Exception.Message
        }
    }
}

$results | Export-Csv "C:\Users\vm1\Desktop\leaver-state-export.csv" -NoTypeInformation
$results
