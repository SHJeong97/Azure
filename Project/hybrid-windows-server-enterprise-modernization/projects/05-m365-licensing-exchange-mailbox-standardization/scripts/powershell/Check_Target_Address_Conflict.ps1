$TargetAddresses = @()

foreach ($Plan in $TargetEmailAddressPlan) {
    $TargetAddresses += $Plan.TargetPrimarySMTP
    $TargetAddresses += $Plan.TenantAlias
}

$ExchangeAddressConflictCheck = foreach ($Address in $TargetAddresses) {
    $Recipient = Get-Recipient -Filter "EmailAddresses -eq 'smtp:$Address'" -ErrorAction SilentlyContinue

    if ($Recipient) {
        [PSCustomObject]@{
            TargetAddress = $Address
            ConflictFound = "Yes"
            RecipientName = $Recipient.Name
            RecipientType = $Recipient.RecipientType
            RecipientTypeDetails = $Recipient.RecipientTypeDetails
            PrimarySmtpAddress = $Recipient.PrimarySmtpAddress
            Note = "Existing recipient owns this address"
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
            Note = "No Exchange Online recipient conflict found"
        }
    }
}

$ExchangeAddressConflictCheck