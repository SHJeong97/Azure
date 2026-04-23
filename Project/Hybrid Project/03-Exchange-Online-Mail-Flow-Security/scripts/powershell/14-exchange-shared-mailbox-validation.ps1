Import-Module ExchangeOnlineManagement

Connect-ExchangeOnline -UserPrincipalName seunghunjeong@democompany1016.onmicrosoft.com -ShowBanner:$false

Write-Host "`n=== Shared Mailboxes ==="
Get-EXOMailbox -RecipientTypeDetails SharedMailbox -ResultSize Unlimited |
    Where-Object {$_.PrimarySmtpAddress -in @(
        "hr@democompany1016.onmicrosoft.com",
        "finance@democompany1016.onmicrosoft.com",
        "operations@democompany1016.onmicrosoft.com"
    )} |
    Select-Object DisplayName,PrimarySmtpAddress,RecipientTypeDetails

Write-Host "`n=== HR Full Access ==="
Get-EXOMailboxPermission -Identity "hr@democompany1016.onmicrosoft.com" |
    Select-Object User,AccessRights,IsInherited,Deny

Write-Host "`n=== Finance Full Access ==="
Get-EXOMailboxPermission -Identity "finance@democompany1016.onmicrosoft.com" |
    Select-Object User,AccessRights,IsInherited,Deny

Write-Host "`n=== Operations Full Access ==="
Get-EXOMailboxPermission -Identity "operations@democompany1016.onmicrosoft.com" |
    Select-Object User,AccessRights,IsInherited,Deny

Write-Host "`n=== HR Send As ==="
Get-EXORecipientPermission -Identity "hr@democompany1016.onmicrosoft.com" |
    Select-Object Trustee,AccessRights,IsInherited

Write-Host "`n=== Finance Send As ==="
Get-EXORecipientPermission -Identity "finance@democompany1016.onmicrosoft.com" |
    Select-Object Trustee,AccessRights,IsInherited

Write-Host "`n=== Operations Send As ==="
Get-EXORecipientPermission -Identity "operations@democompany1016.onmicrosoft.com" |
    Select-Object Trustee,AccessRights,IsInherited

Disconnect-ExchangeOnline -Confirm:$false
