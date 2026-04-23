Import-Module ExchangeOnlineManagement

Connect-ExchangeOnline -UserPrincipalName your-admin-upn@democompany1016.onmicrosoft.com -ShowBanner:$false

Write-Host "`n=== Shared Mailboxes ==="
Get-Mailbox -RecipientTypeDetails SharedMailbox |
    Where-Object {$_.PrimarySmtpAddress -in @(
        "hr@democompany1016.onmicrosoft.com",
        "finance@democompany1016.onmicrosoft.com",
        "operations@democompany1016.onmicrosoft.com"
    )} |
    Select-Object DisplayName,PrimarySmtpAddress,RecipientTypeDetails

Write-Host "`n=== HR Full Access ==="
Get-MailboxPermission -Identity "hr@democompany1016.onmicrosoft.com" |
    Where-Object {$_.User -notlike "NT AUTHORITY\SELF"} |
    Select-Object User,AccessRights,IsInherited,Deny

Write-Host "`n=== Finance Full Access ==="
Get-MailboxPermission -Identity "finance@democompany1016.onmicrosoft.com" |
    Where-Object {$_.User -notlike "NT AUTHORITY\SELF"} |
    Select-Object User,AccessRights,IsInherited,Deny

Write-Host "`n=== Operations Full Access ==="
Get-MailboxPermission -Identity "operations@democompany1016.onmicrosoft.com" |
    Where-Object {$_.User -notlike "NT AUTHORITY\SELF"} |
    Select-Object User,AccessRights,IsInherited,Deny

Write-Host "`n=== HR Send As ==="
Get-RecipientPermission -Identity "hr@democompany1016.onmicrosoft.com" |
    Select-Object Trustee,AccessRights,IsInherited

Write-Host "`n=== Finance Send As ==="
Get-RecipientPermission -Identity "finance@democompany1016.onmicrosoft.com" |
    Select-Object Trustee,AccessRights,IsInherited

Write-Host "`n=== Operations Send As ==="
Get-RecipientPermission -Identity "operations@democompany1016.onmicrosoft.com" |
    Select-Object Trustee,AccessRights,IsInherited

Disconnect-ExchangeOnline -Confirm:$false
