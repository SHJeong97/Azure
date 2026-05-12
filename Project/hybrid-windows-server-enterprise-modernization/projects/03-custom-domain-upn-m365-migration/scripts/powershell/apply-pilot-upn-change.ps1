# Project 03 Batch 5
# This script will be used later to apply pilot UPN changes.
# Do not run during Batch 4.

Import-Module ActiveDirectory

$PilotUsers = @(
    @{
        SamAccountName = "emma.wilson"
        TargetUPN      = "emma.wilson@summitridge-mfg.com"
    },
    @{
        SamAccountName = "olivia.brown"
        TargetUPN      = "olivia.brown@summitridge-mfg.com"
    },
    @{
        SamAccountName = "sophia.martinez"
        TargetUPN      = "sophia.martinez@summitridge-mfg.com"
    }
)

foreach ($User in $PilotUsers) {
    Set-ADUser `
        -Identity $User.SamAccountName `
        -UserPrincipalName $User.TargetUPN

    Write-Host "Changed $($User.SamAccountName) to $($User.TargetUPN)"
}