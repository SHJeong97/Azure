param(
    [string]$CsvPath = ".\data\users\leaver-users.csv"
)

$leavers = Import-Csv $CsvPath
$results = @()

foreach ($l in $leavers) {
    try {
        $user = Get-MgUser -UserId $l.UserPrincipalName -ErrorAction Stop

        Update-MgUser -UserId $user.Id -AccountEnabled:$false
        Revoke-MgUserSignInSession -UserId $user.Id | Out-Null

        $results += [pscustomobject]@{
            UserPrincipalName = $l.UserPrincipalName
            Action            = "DisableAndRevoke"
            Status            = "Success"
            Notes             = "Account disabled and sign-in sessions revoked"
        }
    }
    catch {
        $results += [pscustomobject]@{
            UserPrincipalName = $l.UserPrincipalName
            Action            = "DisableAndRevoke"
            Status            = "Failed"
            Notes             = $_.Exception.Message
        }
    }
}

$results | Export-Csv ".\evidence\cli-output\leaver-disable-results.csv" -NoTypeInformation
$results
