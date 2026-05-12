$DnsServer = "DC01"
$ZoneName = "corp.democompany1016.local"

$ARecords = @(
    @{Name="fs01"; IPv4Address="10.10.3.10"},
    @{Name="app01"; IPv4Address="10.10.3.20"}
)

foreach ($Record in $ARecords) {
    $ExistingRecord = Get-DnsServerResourceRecord `
        -ComputerName $DnsServer `
        -ZoneName $ZoneName `
        -Name $Record.Name `
        -ErrorAction SilentlyContinue

    if (-not $ExistingRecord) {
        Add-DnsServerResourceRecordA `
            -ComputerName $DnsServer `
            -ZoneName $ZoneName `
            -Name $Record.Name `
            -IPv4Address $Record.IPv4Address `
            -CreatePtr

        Write-Host "Created A record: $($Record.Name).$ZoneName → $($Record.IPv4Address)"
    }
    else {
        Write-Host "A record already exists: $($Record.Name).$ZoneName"
    }
}