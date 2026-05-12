# Project 03 Batch 7
# Future-use script only.
# Do not run unless pilot Exchange Online mailboxes exist and you are ready to change primary SMTP addresses.

Import-Module ExchangeOnlineManagement

# Connect first if not already connected:
# Connect-ExchangeOnline

$PilotEmailChanges = @(
    @{
        Identity = "emma.wilson@summitridge-mfg.com"
        PrimarySmtpAddress = "emma.wilson@summitridge-mfg.com"
        Alias1 = "emma.wilson@democompany1016.onmicrosoft.com"
    },
    @{
        Identity = "olivia.brown@summitridge-mfg.com"
        PrimarySmtpAddress = "olivia.brown@summitridge-mfg.com"
        Alias1 = "olivia.brown@democompany1016.onmicrosoft.com"
    },
    @{
        Identity = "sophia.martinez@summitridge-mfg.com"
        PrimarySmtpAddress = "sophia.martinez@summitridge-mfg.com"
        Alias1 = "sophia.martinez@democompany1016.onmicrosoft.com"
    }
)

foreach ($User in $PilotEmailChanges) {
    Set-Mailbox `
        -Identity $User.Identity `
        -PrimarySmtpAddress $User.PrimarySmtpAddress

    Write-Host "Planned primary SMTP set for $($User.Identity) to $($User.PrimarySmtpAddress)"
}