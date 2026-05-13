# Project 05 Batch 7
# Restore helper script.
# This restores pilot users to the Microsoft 365 pilot licensing group.

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
        New-MgGroupMemberByRef `
            -GroupId $LicenseGroup.Id `
            -BodyParameter @{
                "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$($User.Id)"
            } `
            -ErrorAction SilentlyContinue

        Write-Host "Ensured $($User.UserPrincipalName) is a member of $LicenseGroupName"
    }
    else {
        Write-Host "User not found: $UPN"
    }
}

$CurrentMembers = Get-MgGroupMember -GroupId $LicenseGroup.Id -All |
ForEach-Object {
    Get-MgUser -UserId $_.Id -Property DisplayName,UserPrincipalName
} |
Select-Object DisplayName,UserPrincipalName

$CurrentMembers