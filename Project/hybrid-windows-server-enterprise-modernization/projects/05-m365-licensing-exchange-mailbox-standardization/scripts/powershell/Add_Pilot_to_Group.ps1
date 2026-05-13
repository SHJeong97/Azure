$PilotUPNs = @(
    "emma.wilson@summitridge-mfg.com",
    "olivia.brown@summitridge-mfg.com",
    "sophia.martinez@summitridge-mfg.com"
)

$PilotCloudUsers = foreach ($UPN in $PilotUPNs) {
    Get-MgUser `
        -Filter "userPrincipalName eq '$UPN'" `
        -Property Id,DisplayName,UserPrincipalName,UsageLocation,AssignedLicenses,OnPremisesSyncEnabled
}

foreach ($User in $PilotCloudUsers) {
    New-MgGroupMemberByRef `
        -GroupId $LicenseGroup.Id `
        -BodyParameter @{
            "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$($User.Id)"
        } `
        -ErrorAction SilentlyContinue

    Write-Host "Ensured $($User.UserPrincipalName) is a member of $LicenseGroupName"
}