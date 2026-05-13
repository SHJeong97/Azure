# Project 05 Batch 7
# Rollback helper script.
# This removes pilot users from the Microsoft 365 pilot licensing group.
# Do not run unless you intentionally need to remove license assignment scope.

Connect-MgGraph -Scopes "User.ReadWrite.All","Group.ReadWrite.All","Directory.ReadWrite.All"

$LicenseGroupName = "GRP-M365-E5-Pilot-License"

$PilotUPNs = @(
    "emma.wilson@summitridge-mfg.com",
    "olivia.brown@summitridge-mfg.com",
    "sophia.martinez@summitridge-mfg.com"
)

$LicenseGroup = Get-MgGroup `
    -Filter "displayName eq '$LicenseGroupName'" `
    -Property Id,DisplayName `
    -ErrorAction Stop

foreach ($UPN in $PilotUPNs) {
    $User = Get-MgUser `
        -Filter "userPrincipalName eq '$UPN'" `
        -Property Id,DisplayName,UserPrincipalName `
        -ErrorAction SilentlyContinue

    if ($User) {
        Remove-MgGroupMemberByRef `
            -GroupId $LicenseGroup.Id `
            -DirectoryObjectId $User.Id `
            -ErrorAction SilentlyContinue

        Write-Host "Removed $($User.UserPrincipalName) from $LicenseGroupName"
    }
    else {
        Write-Host "User not found: $UPN"
    }
}

$RemainingMembers = Get-MgGroupMember -GroupId $LicenseGroup.Id -All |
ForEach-Object {
    Get-MgUser -UserId $_.Id -Property DisplayName,UserPrincipalName
} |
Select-Object DisplayName,UserPrincipalName

$RemainingMembers