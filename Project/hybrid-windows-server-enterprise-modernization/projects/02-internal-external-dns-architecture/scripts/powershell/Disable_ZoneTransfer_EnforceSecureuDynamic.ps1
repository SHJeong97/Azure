$DnsServer = "DC01"

$Zones = Get-DnsServerZone -ComputerName $DnsServer |
Where-Object {
    $_.ZoneName -eq "corp.democompany1016.local" -or
    $_.ZoneName -eq "_msdcs.corp.democompany1016.local" -or
    $_.IsReverseLookupZone -eq $true
}

foreach ($Zone in $Zones) {
    Set-DnsServerPrimaryZone `
        -ComputerName $DnsServer `
        -Name $Zone.ZoneName `
        -SecureSecondaries NoTransfer `
        -DynamicUpdate Secure

    Write-Host "Hardened zone: $($Zone.ZoneName)"
}