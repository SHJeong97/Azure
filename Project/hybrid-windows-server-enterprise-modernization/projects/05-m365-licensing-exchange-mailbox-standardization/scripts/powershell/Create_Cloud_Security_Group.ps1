$LicenseGroupName = "GRP-M365-E5-Pilot-License"
$LicenseGroupMailNickname = "GRP-M365-E5-Pilot-License"

$ExistingLicenseGroup = Get-MgGroup `
    -Filter "displayName eq '$LicenseGroupName'" `
    -Property Id,DisplayName,MailEnabled,SecurityEnabled,MailNickname `
    -ErrorAction SilentlyContinue

if (-not $ExistingLicenseGroup) {
    $LicenseGroup = New-MgGroup `
        -DisplayName $LicenseGroupName `
        -Description "Pilot licensing group for Project 05 Microsoft 365 E5 mailbox enablement" `
        -MailEnabled:$false `
        -MailNickname $LicenseGroupMailNickname `
        -SecurityEnabled:$true `
        -GroupTypes @()
}
else {
    $LicenseGroup = $ExistingLicenseGroup
}

$LicenseGroup |
Select-Object Id,DisplayName,MailEnabled,SecurityEnabled,MailNickname