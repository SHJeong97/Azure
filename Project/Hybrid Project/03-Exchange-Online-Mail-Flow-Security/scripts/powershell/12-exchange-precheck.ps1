Write-Host "=== Exchange Online Admin Precheck ==="

Write-Host "`n1. Confirm Exchange Online module availability"
Get-Module ExchangeOnlineManagement -ListAvailable

Write-Host "`n2. Confirm Microsoft Graph module availability"
Get-Module Microsoft.Graph -ListAvailable

Write-Host "`n3. Planned shared mailboxes"
Import-Csv "C:\LabSources\ExchangeProject3\data\mailbox-plan.csv" | Format-Table

Write-Host "`n4. Reminder"
Write-Host "Use existing synced department groups for mailbox access design."
