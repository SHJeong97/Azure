$DnsServer = "DC01"
$ZoneName = "corp.democompany1016.local"

$ExistingRecord = Get-DnsServerResourceRecord `
    -ComputerName $DnsServer `
    -ZoneName $ZoneName `
    -Name "files" `
    -ErrorAction SilentlyContinue

if (-not $ExistingRecord) {
    Add-DnsServerResourceRecordCName `
        -ComputerName $DnsServer `
        -ZoneName $ZoneName `
        -Name "files" `
        -HostNameAlias "fs01.corp.democompany1016.local"

    Write-Host "Created CNAME: files.$ZoneName → fs01.$ZoneName"
}
else {
    Write-Host "CNAME already exists: files.$ZoneName"
}