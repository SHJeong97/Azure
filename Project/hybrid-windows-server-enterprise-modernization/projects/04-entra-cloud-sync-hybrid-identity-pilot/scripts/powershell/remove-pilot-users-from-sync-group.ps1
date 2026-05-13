# Project 04 Batch 7
# Rollback helper script.
# This removes pilot users from the Cloud Sync pilot group.
# Do not run unless you intentionally want to remove users from sync scope.

Import-Module ActiveDirectory

$PilotGroup = "GRP-EntraCloudSync-Pilot"
$PilotUsers = "emma.wilson","olivia.brown","sophia.martinez"

foreach ($User in $PilotUsers) {
    Remove-ADGroupMember `
        -Identity $PilotGroup `
        -Members $User `
        -Confirm:$false

    Write-Host "Removed $User from $PilotGroup"
}

$RemainingMembers = Get-ADGroupMember $PilotGroup |
Select-Object Name,SamAccountName,objectClass,DistinguishedName

$RemainingMembers