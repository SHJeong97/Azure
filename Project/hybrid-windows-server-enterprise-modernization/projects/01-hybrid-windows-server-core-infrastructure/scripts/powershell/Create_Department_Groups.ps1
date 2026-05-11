Import-Module ActiveDirectory

$DomainDN = "DC=corp,DC=democompany1016,DC=local"
$GroupPath = "OU=Department,OU=Groups,OU=SRMG,$DomainDN"

$DepartmentGroups = @(
    "GG-Dept-Executives",
    "GG-Dept-HR",
    "GG-Dept-Finance",
    "GG-Dept-IT",
    "GG-Dept-Sales",
    "GG-Dept-Operations"
)

foreach ($Group in $DepartmentGroups) {
    if (-not (Get-ADGroup -Filter "Name -eq '$Group'" -ErrorAction SilentlyContinue)) {
        New-ADGroup `
            -Name $Group `
            -SamAccountName $Group `
            -GroupScope Global `
            -GroupCategory Security `
            -Path $GroupPath `
            -Description "Department security group for $Group"

        Write-Host "Created group: $Group"
    }
    else {
        Write-Host "Group already exists: $Group"
    }
}
