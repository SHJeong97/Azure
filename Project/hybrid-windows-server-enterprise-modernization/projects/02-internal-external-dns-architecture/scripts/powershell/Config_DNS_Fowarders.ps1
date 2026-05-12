$Forwarder = "168.63.129.16"
$DnsServers = "DC01","DC02"

foreach ($Server in $DnsServers) {
    $CurrentForwarders = (Get-DnsServerForwarder -ComputerName $Server).IPAddress.IPAddressToString

    if ($CurrentForwarders -notcontains $Forwarder) {
        Add-DnsServerForwarder `
            -ComputerName $Server `
            -IPAddress $Forwarder `
            -PassThru

        Write-Host "Added forwarder $Forwarder to $Server"
    }
    else {
        Write-Host "$Server already has forwarder $Forwarder"
    }
}