Import-Module ActiveDirectory
$ErrorActionPreference = 'Stop'

$domainDn = "DC=corp,DC=democompany1016,DC=local"
$appsOuPath = "OU=Groups,$domainDn"
$appChildOu = "OU=Apps,OU=Groups,$domainDn"
$csvPath = "C:\LabSources\HybridIdentity-Project2\data\app-groups.csv"

try {
    $existingAppsOu = Get-ADOrganizationalUnit -LDAPFilter "(ou=Apps)" -SearchBase $appsOuPath -SearchScope OneLevel -ErrorAction SilentlyContinue

    if (-not $existingAppsOu) {
        New-ADOrganizationalUnit -Name "Apps" -Path $appsOuPath -ProtectedFromAccidentalDeletion $true -ErrorAction Stop
        Write-Host "Created OU=Apps under OU=Groups"
    }
    else {
        Write-Host "OU=Apps already exists under OU=Groups"
    }

    $groups = Import-Csv $csvPath

    foreach ($group in $groups) {
        $existingGroup = Get-ADGroup -Filter "SamAccountName -eq '$($group.Name)'" -ErrorAction SilentlyContinue

        if (-not $existingGroup) {
            New-ADGroup `
                -Name $group.Name `
                -SamAccountName $group.Name `
                -GroupScope Global `
                -GroupCategory Security `
                -Path $group.TargetOU `
                -Description $group.Description `
                -ErrorAction Stop

            Write-Host "Created group: $($group.Name)"
        }
        else {
            Write-Host "Group already exists: $($group.Name)"
        }
    }
}
catch {
    Write-Host "FAILED: $($_.Exception.Message)"
    throw
}
