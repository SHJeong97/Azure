$PilotUPNs = @(
    "emma.wilson@summitridge-mfg.com",
    "olivia.brown@summitridge-mfg.com",
    "sophia.martinez@summitridge-mfg.com"
)

$PreLicenseMailboxLookup = foreach ($UPN in $PilotUPNs) {
    $Mailbox = Get-Mailbox -Identity $UPN -ErrorAction SilentlyContinue

    if ($Mailbox) {
        [PSCustomObject]@{
            LookupUPN = $UPN
            MailboxFound = "Yes"
            DisplayName = $Mailbox.DisplayName
            UserPrincipalName = $Mailbox.UserPrincipalName
            PrimarySmtpAddress = $Mailbox.PrimarySmtpAddress
            RecipientTypeDetails = $Mailbox.RecipientTypeDetails
            WhenMailboxCreated = $Mailbox.WhenMailboxCreated
        }
    }
    else {
        [PSCustomObject]@{
            LookupUPN = $UPN
            MailboxFound = "No"
            DisplayName = ""
            UserPrincipalName = ""
            PrimarySmtpAddress = ""
            RecipientTypeDetails = ""
            WhenMailboxCreated = ""
        }
    }
}

$PreLicenseMailboxLookup