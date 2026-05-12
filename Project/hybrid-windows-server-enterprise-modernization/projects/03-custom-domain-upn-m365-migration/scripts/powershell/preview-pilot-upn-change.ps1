# Project 03 Batch 4
# Preview only. Do not run to make changes.
# This script shows the planned UPN changes for pilot users.

Import-Module ActiveDirectory

$PilotUsers = @(
    @{
        SamAccountName = "emma.wilson"
        CurrentUPN     = "emma.wilson@corp.democompany1016.local"
        TargetUPN      = "emma.wilson@summitridge-mfg.com"
    },
    @{
        SamAccountName = "olivia.brown"
        CurrentUPN     = "olivia.brown@corp.democompany1016.local"
        TargetUPN      = "olivia.brown@summitridge-mfg.com"
    },
    @{
        SamAccountName = "sophia.martinez"
        CurrentUPN     = "sophia.martinez@corp.democompany1016.local"
        TargetUPN      = "sophia.martinez@summitridge-mfg.com"
    }
)

foreach ($User in $PilotUsers) {
    Get-ADUser $User.SamAccountName -Properties UserPrincipalName |
    Select-Object `
        Name,
        SamAccountName,
        UserPrincipalName,
        @{Name="PlannedTargetUPN";Expression={$User.TargetUPN}}
}