# Project 03 Batch 4
# Rollback script for pilot UPN changes.
# Use only if pilot UPN migration causes issues.

Import-Module ActiveDirectory

$RollbackUsers = @(
    @{
        SamAccountName = "emma.wilson"
        RollbackUPN    = "emma.wilson@corp.democompany1016.local"
    },
    @{
        SamAccountName = "olivia.brown"
        RollbackUPN    = "olivia.brown@corp.democompany1016.local"
    },
    @{
        SamAccountName = "sophia.martinez"
        RollbackUPN    = "sophia.martinez@corp.democompany1016.local"
    }
)

foreach ($User in $RollbackUsers) {
    Set-ADUser `
        -Identity $User.SamAccountName `
        -UserPrincipalName $User.RollbackUPN

    Write-Host "Rolled back $($User.SamAccountName) to $($User.RollbackUPN)"
}