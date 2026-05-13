$ADTargetAddressConflictCheck = foreach ($Address in $TargetAddresses) {
    $Matches = Get-ADUser -Filter * -Properties mail,proxyAddresses,UserPrincipalName |
    Where-Object {
        $_.mail -eq $Address -or
        $_.UserPrincipalName -eq $Address -or
        $_.proxyAddresses -contains "SMTP:$Address" -or
        $_.proxyAddresses -contains "smtp:$Address"
    }

    foreach ($Match in $Matches) {
        [PSCustomObject]@{
            TargetAddress = $Address
            MatchFound = "Yes"
            SamAccountName = $Match.SamAccountName
            Name = $Match.Name
            UserPrincipalName = $Match.UserPrincipalName
            Mail = $Match.mail
            ProxyAddresses = ($Match.proxyAddresses -join ";")
        }
    }

    if (-not $Matches) {
        [PSCustomObject]@{
            TargetAddress = $Address
            MatchFound = "No"
            SamAccountName = ""
            Name = ""
            UserPrincipalName = ""
            Mail = ""
            ProxyAddresses = ""
        }
    }
}

$ADTargetAddressConflictCheck