
Import-Module ActiveDirectory

$DomainDN = "DC=corp,DC=democompany1016,DC=local"

function New-SafeOU {
    param(
        [string]$Name,
        [string]$Path
    )

    $OUPath = "OU=$Name,$Path"

    if (-not (Get-ADOrganizationalUnit -LDAPFilter "(distinguishedName=$OUPath)" -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $Name -Path $Path -ProtectedFromAccidentalDeletion $true
        Write-Host "Created OU: $OUPath"
    }
    else {
        Write-Host "OU already exists: $OUPath"
    }
}

# Root OU
New-SafeOU -Name "SRMG" -Path $DomainDN

# First-level OUs
$RootOUs = @(
    "Admin",
    "Groups",
    "Service Accounts",
    "Users",
    "Workstations",
    "Servers",
    "Disabled Objects",
    "Staging"
)

foreach ($OU in $RootOUs) {
    New-SafeOU -Name $OU -Path "OU=SRMG,$DomainDN"
}

# Admin child OUs
$AdminOUs = @("Tier0","Tier1","Tier2")

foreach ($OU in $AdminOUs) {
    New-SafeOU -Name $OU -Path "OU=Admin,OU=SRMG,$DomainDN"
}

# Group child OUs
$GroupOUs = @("Department","FileAccess","Admin","Licensing")

foreach ($OU in $GroupOUs) {
    New-SafeOU -Name $OU -Path "OU=Groups,OU=SRMG,$DomainDN"
}

# User department OUs
$UserOUs = @("Executives","HR","Finance","IT","Sales","Operations")

foreach ($OU in $UserOUs) {
    New-SafeOU -Name $OU -Path "OU=Users,OU=SRMG,$DomainDN"
}

# Server child OUs
$ServerOUs = @("Management","Member Servers","Application Servers")

foreach ($OU in $ServerOUs) {
    New-SafeOU -Name $OU -Path "OU=Servers,OU=SRMG,$DomainDN"
}
