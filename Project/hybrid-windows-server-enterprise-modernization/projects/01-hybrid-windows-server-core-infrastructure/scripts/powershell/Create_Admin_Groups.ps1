Import-Module ActiveDirectory

$DomainDN = "DC=corp,DC=democompany1016,DC=local"
$GroupPath = "OU=Admin,OU=Groups,OU=SRMG,$DomainDN"

$AdminGroups = @(
    "GG-Admin-Tier0-DomainAdmins",
    "GG-Admin-Tier1-ServerAdmins",
    "GG-Admin-Tier2-Helpdesk",
    "GG-Admin-DNSAdmins",
    "GG-Admin-GPOAdmins"
)

foreach ($Group in $AdminGroups) {
    if (-not (Get-ADGroup -Filter "Name -eq '$Group'" -ErrorAction SilentlyContinue)) {
        New-ADGroup `
            -Name $Group `
            -SamAccountName $Group `
            -GroupScope Global `
            -GroupCategory Security `
            -Path $GroupPath `
            -Description "Administrative role group for $Group"

        Write-Host "Created group: $Group"
    }
    else {
        Write-Host "Group already exists: $Group"
    }
}
