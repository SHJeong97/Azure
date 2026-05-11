Import-Module ActiveDirectory

$DomainDN = "DC=corp,DC=democompany1016,DC=local"
$AdminPassword = ConvertTo-SecureString "AdminChange!2026-Lab" -AsPlainText -Force

$AdminAccounts = @(
    @{Name="ADM Cloud Admin"; Sam="adm.cloudadmin"; UPN="adm.cloudadmin@corp.democompany1016.local"; OU="OU=Tier0,OU=Admin,OU=SRMG,$DomainDN"; Group="GG-Admin-Tier0-DomainAdmins"; Title="Tier 0 Domain Administrator"},
    @{Name="ADM Server Admin"; Sam="adm.serveradmin"; UPN="adm.serveradmin@corp.democompany1016.local"; OU="OU=Tier1,OU=Admin,OU=SRMG,$DomainDN"; Group="GG-Admin-Tier1-ServerAdmins"; Title="Tier 1 Server Administrator"},
    @{Name="ADM Helpdesk"; Sam="adm.helpdesk"; UPN="adm.helpdesk@corp.democompany1016.local"; OU="OU=Tier2,OU=Admin,OU=SRMG,$DomainDN"; Group="GG-Admin-Tier2-Helpdesk"; Title="Tier 2 Helpdesk Administrator"}
)

foreach ($Admin in $AdminAccounts) {
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$($Admin.Sam)'" -ErrorAction SilentlyContinue)) {
        New-ADUser `
            -Name $Admin.Name `
            -SamAccountName $Admin.Sam `
            -UserPrincipalName $Admin.UPN `
            -DisplayName $Admin.Name `
            -Title $Admin.Title `
            -Path $Admin.OU `
            -AccountPassword $AdminPassword `
            -Enabled $true `
            -ChangePasswordAtLogon $true `
            -Description "Dedicated privileged account for $($Admin.Title)"

        Write-Host "Created admin account: $($Admin.Sam)"
    }
    else {
        Write-Host "Admin account already exists: $($Admin.Sam)"
    }

    Add-ADGroupMember -Identity $Admin.Group -Members $Admin.Sam -ErrorAction SilentlyContinue
}
