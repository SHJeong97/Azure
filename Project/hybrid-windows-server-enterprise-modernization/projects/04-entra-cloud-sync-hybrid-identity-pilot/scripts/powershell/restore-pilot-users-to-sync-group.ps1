# Project 04 Batch 7
# Restore helper script.
# This re-adds pilot users to the Cloud Sync pilot group.

Import-Module ActiveDirectory

$PilotGroup = "GRP-EntraCloudSync-Pilot"
$PilotUsers = "emma.wilson","olivia.brown","sophia.martinez"

foreach ($User in $PilotUsers) {
    Add-ADGroupMember `
        -Identity $PilotGroup `
        -Members $User `
        -ErrorAction SilentlyContinue

    Write-Host "Ensured $User is a member of $PilotGroup"
}

$CurrentMembers = Get-ADGroupMember $PilotGroup |
Select-Object Name,SamAccountName,objectClass,DistinguishedName

$CurrentMembers