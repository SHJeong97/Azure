Import-Module ActiveDirectory

$DomainDN = "DC=corp,DC=democompany1016,DC=local"
$ServiceAccountPath = "OU=Service Accounts,OU=SRMG,$DomainDN"
$ServicePassword = ConvertTo-SecureString "SvcDisabled!2026-Lab" -AsPlainText -Force

$ServiceAccounts = @(
    @{Name="SVC Entra Connect"; Sam="svc-entra-connect"; Description="Placeholder for Microsoft Entra Connect sync service account"},
    @{Name="SVC Azure File Sync"; Sam="svc-azure-file-sync"; Description="Placeholder for Azure File Sync service planning"},
    @{Name="SVC App Proxy"; Sam="svc-app-proxy"; Description="Placeholder for Microsoft Entra Application Proxy connector planning"}
)

foreach ($Svc in $ServiceAccounts) {
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$($Svc.Sam)'" -ErrorAction SilentlyContinue)) {
        New-ADUser `
            -Name $Svc.Name `
            -SamAccountName $Svc.Sam `
            -UserPrincipalName "$($Svc.Sam)@corp.democompany1016.local" `
            -DisplayName $Svc.Name `
            -Path $ServiceAccountPath `
            -AccountPassword $ServicePassword `
            -Enabled $false `
            -Description $Svc.Description

        Write-Host "Created disabled service account: $($Svc.Sam)"
    }
    else {
        Write-Host "Service account already exists: $($Svc.Sam)"
    }
}
