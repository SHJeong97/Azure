# Exchange Online Mailbox Provisioning Validation

## Purpose

This document records Exchange Online mailbox provisioning validation for the Microsoft 365 pilot users.

## Pilot Users

| User | UPN |
|---|---|
| Emma Wilson | emma.wilson@summitridge-mfg.com |
| Olivia Brown | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | sophia.martinez@summitridge-mfg.com |

## Licensing Context

The pilot users were assigned Microsoft 365 licenses through the pilot licensing group:

```text
GRP-M365-E5-Pilot-License
```

After licensing, Exchange Online mailbox provisioning was validated.

## Exchange Online Connection Method

The lab server experienced a WAM/MSAL broker issue when using the default Exchange Online connection method.

Device-code authentication was used:

```powershell
Connect-ExchangeOnline -Device -ShowBanner:$false
```

## Validation Performed

Validation included:

- Microsoft Graph license state validation
- Exchange-related service plan status export
- Exchange Online PowerShell connection
- Pilot mailbox lookup
- Pilot mailbox email address export
- Recipient validation
- Mailbox statistics export
- Accepted domain and mailbox readiness summary

## Expected Result

Each pilot user should have:

```text
RecipientTypeDetails = UserMailbox
```

Each mailbox should be associated with the synchronized Microsoft Entra user.

## Mailbox Statistics Note

Newly provisioned mailboxes may show:

```text
ItemCount = 0
LastLogonTime = blank
```

This is expected until users sign in, receive mail, or generate mailbox activity.

## Accepted Domain

The verified public domain is:

```text
summitridge-mfg.com
```

The domain was validated as an Exchange Online accepted domain before mailbox address standardization.

## Mailbox Address State

The current mailbox primary SMTP and proxy addresses were exported before standardization.

This creates a rollback and comparison point before Batch 5.

## Safety Decisions

The project did not change primary SMTP addresses in this batch.

The project did not remove aliases in this batch.

The project only validated mailbox provisioning and captured the current mailbox address state.

## Business Risk

Mailbox provisioning issues can cause:

- Users unable to access Outlook
- Mail delivery failures
- Incorrect recipient state
- Helpdesk escalation
- Confusion between licensed users and mailbox-enabled users

## Risk Treatment

The project validates mailboxes after license assignment and before email address standardization.

## Business Value

This batch proves that licensed synced identities can become Exchange Online mailbox users before moving to address standardization and mail-flow validation.
