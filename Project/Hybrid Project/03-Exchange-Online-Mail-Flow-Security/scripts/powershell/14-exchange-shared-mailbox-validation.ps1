param(
    [Parameter(Mandatory = $true)]
    [string]$AdminUPN = "seunghunjeong@democompany1016.onmicrosoft.com
)

$ErrorActionPreference = "Stop"

Write-Host "=== Exchange Shared Mailbox Validation ==="

# Make sure module exists
$exoModule = Get-Module ExchangeOnlineManagement -ListAvailable
if (-not $exoModule) {
    throw "ExchangeOnlineManagement module is not installed. Install it first with: Install-Module ExchangeOnlineManagement -Scope CurrentUser"
}

Import-Module ExchangeOnlineManagement

# Connect
Connect-ExchangeOnline -UserPrincipalName $AdminUPN -ShowBanner:$false

try {
    $mailboxes = @(
        "hr@democompany1016.onmicrosoft.com",
        "finance@democompany1016.onmicrosoft.com",
        "operations@democompany1016.onmicrosoft.com"
    )

    Write-Host "`n=== Shared Mailboxes ==="
    $sharedMailboxResults = Get-EXOMailbox -RecipientTypeDetails SharedMailbox -ResultSize Unlimited |
        Where-Object { $_.PrimarySmtpAddress -in $mailboxes } |
        Select-Object DisplayName, PrimarySmtpAddress, RecipientTypeDetails

    $sharedMailboxResults | Format-Table -AutoSize

    foreach ($mailbox in $mailboxes) {
        Write-Host "`n=== $mailbox : Full Access ==="
        $fullAccess = Get-EXOMailboxPermission -Identity $mailbox |
            Where-Object {
                $_.User -notlike "NT AUTHORITY\SELF" -and
                $_.User -notlike "S-1-5-21*" -and
                $_.AccessRights -match "FullAccess"
            } |
            Select-Object User, AccessRights, IsInherited, Deny

        if ($fullAccess) {
            $fullAccess | Format-Table -AutoSize
        }
        else {
            Write-Host "No explicit Full Access delegates found."
        }

        Write-Host "`n=== $mailbox : Send As ==="
        $sendAs = Get-EXORecipientPermission -Identity $mailbox |
            Where-Object { $_.AccessRights -match "SendAs" } |
            Select-Object Trustee, AccessRights, IsInherited

        if ($sendAs) {
            $sendAs | Format-Table -AutoSize
        }
        else {
            Write-Host "No explicit Send As delegates found."
        }
    }
}
finally {
    Disconnect-ExchangeOnline -Confirm:$false
}
