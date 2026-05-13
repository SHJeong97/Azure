$TargetAddresses = @(
    "emma.wilson@summitridge-mfg.com",
    "olivia.brown@summitridge-mfg.com",
    "sophia.martinez@summitridge-mfg.com"
)

$RecipientConflictCheck = foreach ($Address in $TargetAddresses) {
    $Recipient = Get-Recipient -Filter "EmailAddresses -eq 'smtp:$Address'" -ErrorAction SilentlyContinue

    if ($Recipient) {
        [PSCustomObject]@{
            TargetAddress = $Address
            ConflictFound = "Yes"
            RecipientName = $Recipient.Name
            RecipientType = $Recipient.RecipientType
            RecipientTypeDetails = $Recipient.RecipientTypeDetails
            PrimarySmtpAddress = $Recipient.PrimarySmtpAddress
        }
    }
    else {
        [PSCustomObject]@{
            TargetAddress = $Address
            ConflictFound = "No"
            RecipientName = ""
            RecipientType = ""
            RecipientTypeDetails = ""
            PrimarySmtpAddress = ""
        }
    }
}

$RecipientConflictCheck