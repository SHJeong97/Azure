Import-Module ActiveDirectory

$DomainDN = "DC=corp,DC=democompany1016,DC=local"
$GroupPath = "OU=FileAccess,OU=Groups,OU=SRMG,$DomainDN"

$FileAccessGroups = @(
    "GG-FS-HR-RW",
    "GG-FS-HR-RO",
    "GG-FS-Finance-RW",
    "GG-FS-Finance-RO",
    "GG-FS-IT-RW",
    "GG-FS-IT-RO",
    "GG-FS-Sales-RW",
    "GG-FS-Sales-RO",
    "GG-FS-Operations-RW",
    "GG-FS-Operations-RO",
    "GG-FS-Public-Modify"
)

foreach ($Group in $FileAccessGroups) {
    if (-not (Get-ADGroup -Filter "Name -eq '$Group'" -ErrorAction SilentlyContinue)) {
        New-ADGroup `
            -Name $Group `
            -SamAccountName $Group `
            -GroupScope Global `
            -GroupCategory Security `
            -Path $GroupPath `
            -Description "File access security group for $Group"

        Write-Host "Created group: $Group"
    }
    else {
        Write-Host "Group already exists: $Group"
    }
}
