Import-Module ActiveDirectory

$DomainDN = "DC=corp,DC=democompany1016,DC=local"
$GroupPath = "OU=Licensing,OU=Groups,OU=SRMG,$DomainDN"

$LicensingGroups = @(
    "GG-LIC-O365-E3",
    "GG-LIC-O365-E5",
    "GG-LIC-EMS-E5"
)

foreach ($Group in $LicensingGroups) {
    if (-not (Get-ADGroup -Filter "Name -eq '$Group'" -ErrorAction SilentlyContinue)) {
        New-ADGroup `
            -Name $Group `
            -SamAccountName $Group `
            -GroupScope Global `
            -GroupCategory Security `
            -Path $GroupPath `
            -Description "Future Microsoft cloud licensing group for $Group"

        Write-Host "Created group: $Group"
    }
    else {
        Write-Host "Group already exists: $Group"
    }
}
