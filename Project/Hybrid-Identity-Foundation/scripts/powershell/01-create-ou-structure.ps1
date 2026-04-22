Import-Module ActiveDirectory

$domainDn = "DC=corp,DC=democompany1016,DC=local"

$ouList = @(
    @{ Name = "Admins"; Path = $domainDn },
    @{ Name = "Privileged Users"; Path = "OU=Admins,$domainDn" },
    @{ Name = "Operations"; Path = "OU=Admins,$domainDn" },

    @{ Name = "Groups"; Path = $domainDn },
    @{ Name = "Departments"; Path = "OU=Groups,$domainDn" },
    @{ Name = "Licensing"; Path = "OU=Groups,$domainDn" },
    @{ Name = "Roles"; Path = "OU=Groups,$domainDn" },

    @{ Name = "Users"; Path = $domainDn },
    @{ Name = "Executive"; Path = "OU=Users,$domainDn" },
    @{ Name = "IT"; Path = "OU=Users,$domainDn" },
    @{ Name = "HR"; Path = "OU=Users,$domainDn" },
    @{ Name = "Finance"; Path = "OU=Users,$domainDn" },
    @{ Name = "Sales"; Path = "OU=Users,$domainDn" },
    @{ Name = "Operations"; Path = "OU=Users,$domainDn" },

    @{ Name = "Servers"; Path = $domainDn },
    @{ Name = "Workstations"; Path = $domainDn },
    @{ Name = "Service Accounts"; Path = $domainDn }
)

foreach ($ou in $ouList) {
    $existingOu = Get-ADOrganizationalUnit -LDAPFilter "(ou=$($ou.Name))" -SearchBase $ou.Path -SearchScope OneLevel -ErrorAction SilentlyContinue

    if (-not $existingOu) {
        New-ADOrganizationalUnit -Name $ou.Name -Path $ou.Path
        Write-Host "Created OU: $($ou.Name) under $($ou.Path)"
    }
    else {
        Write-Host "OU already exists: $($ou.Name) under $($ou.Path)"
    }
}

Get-ADOrganizationalUnit -Filter * -SearchBase $domainDn |
    Select-Object Name, DistinguishedName |
    Sort-Object DistinguishedName
