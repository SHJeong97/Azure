# Run on MGMT-01 only after confirming DNS points to the domain controller.
# This is a reference script. GUI join is still preferred for this batch because it gives cleaner screenshots.

Add-Computer `
  -DomainName "corp.democompany1016.local" `
  -Credential "CORP\Administrator" `
  -Restart `
  -Force `
  -Verbose
