Import-Module ActiveDirectory
$ErrorActionPreference = 'Stop'

$domainDn = "DC=corp,DC=democompany1016,DC=local"

$ouList = @(
    @{ Name = "Admins"; Path = $domainDn },
    @{ Name = "Privileged Users"; Path = "OU=Admins,$domainDn" },
    @{ Name = "Operations"; Path = "OU=Admins,$domainDn" },

    @{ Name = "Groups"; Path = $domainDn },
    @{ Name = "Departments"; Path = "OU=Groups,$domainDn" },
    @{ Name = "Licensing"; Path = "OU=Groups,$domainDn" },
    @{ Name = "Roles"; Path = "OU=Groups,$domainDn" },

    @{ Name = "Employees"; Path = $domainDn },
    @{ Name = "Executive"; Path = "OU=Employees,$domainDn" },
    @{ Name = "IT"; Path = "OU=Employees,$domainDn" },
    @{ Name = "HR"; Path = "OU=Employees,$domainDn" },
    @{ Name = "Finance"; Path = "OU=Employees,$domainDn" },
    @{ Name = "Sales"; Path = "OU=Employees,$domainDn" },
    @{ Name = "Operations"; Path = "OU=Employees,$domainDn" },

    @{ Name = "Servers"; Path = $domainDn },
    @{ Name = "Workstations"; Path = $domainDn },
    @{ Name = "Service Accounts"; Path = $domainDn }
)

foreach ($ou in $ouList) {
    try {
        $existingOu = Get-ADOrganizationalUnit `
            -LDAPFilter "(ou=$($ou.Name))" `
            -SearchBase $ou.Path `
            -SearchScope OneLevel `
            -ErrorAction SilentlyContinue

        if (-not $existingOu) {
            New-ADOrganizationalUnit `
                -Name $ou.Name `
                -Path $ou.Path `
                -ProtectedFromAccidentalDeletion $true `
                -ErrorAction Stop

            Write-Host "Created OU: $($ou.Name) under $($ou.Path)"
        }
        else {
            Write-Host "OU already exists: $($ou.Name) under $($ou.Path)"
        }
    }
    catch {
        Write-Host "FAILED: $($ou.Name) under $($ou.Path) :: $($_.Exception.Message)"
    }
}

Get-ADOrganizationalUnit -Filter * -SearchBase $domainDn |
    Select-Object Name, DistinguishedName |
    Sort-Object DistinguishedName
