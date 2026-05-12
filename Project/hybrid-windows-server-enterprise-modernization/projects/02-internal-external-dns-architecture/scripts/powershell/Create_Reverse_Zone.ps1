$DnsServer = "DC01"

$ReverseZones = @(
    "10.10.1.0/24",
    "10.10.2.0/24",
    "10.10.3.0/24",
    "10.10.4.0/24"
)

foreach ($Zone in $ReverseZones) {
    try {
        Add-DnsServerPrimaryZone `
            -ComputerName $DnsServer `
            -NetworkId $Zone `
            -ReplicationScope "Domain" `
            -DynamicUpdate Secure `
            -ErrorAction Stop

        Write-Host "Created reverse lookup zone for $Zone"
    }
    catch {
        Write-Host "Reverse lookup zone may already exist for $Zone or creation failed: $($_.Exception.Message)"
    }
}