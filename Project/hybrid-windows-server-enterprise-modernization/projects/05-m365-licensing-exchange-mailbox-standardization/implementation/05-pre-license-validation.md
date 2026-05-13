# Pre-License Validation

## Purpose

This document records the pre-license validation for the Microsoft 365 pilot users.

## Pilot Users

| User | UPN |
|---|---|
| Emma Wilson | emma.wilson@summitridge-mfg.com |
| Olivia Brown | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | sophia.martinez@summitridge-mfg.com |

## Validation Performed

Pre-license validation included:

- Microsoft Graph connection
- Pilot cloud user validation
- UsageLocation validation
- License readiness check
- Tenant license SKU export
- Target pilot SKU selection
- Exchange Online PowerShell connection
- Accepted domain validation
- Pre-license mailbox lookup
- Recipient address conflict check
- MX and Autodiscover readiness check

## Expected Pre-License State

The expected state before license assignment is:

| Item | Expected Result |
|---|---|
| Cloud user exists | Yes |
| On-premises sync enabled | True |
| UsageLocation | US |
| Assigned licenses | 0 |
| Exchange mailbox | Not provisioned yet |
| Target SMTP conflict | No conflict |

## Exchange Online Connection Note

The default Exchange Online connection method triggered a RuntimeBroker/MSAL broker error on the lab server.

Device-code authentication was used instead:

```powershell
Connect-ExchangeOnline -Device -ShowBanner:$false
```

## Accepted Domain

The verified public domain is:

```text
summitridge-mfg.com
```

This domain was validated as an Exchange Online accepted domain before mailbox provisioning.

## Mailbox State

Before license assignment, the pilot users are expected to have no Exchange Online mailbox.

Mailbox provisioning will be validated after license assignment in the next batches.

## Address Conflict State

The target addresses were checked before licensing and SMTP standardization:

```text
emma.wilson@summitridge-mfg.com
olivia.brown@summitridge-mfg.com
sophia.martinez@summitridge-mfg.com
```

No address conflict should exist before continuing.

## Safety Decision

No license assignment was performed in Batch 2.

No mailbox changes were performed in Batch 2.

No SMTP address changes were performed in Batch 2.

## Business Value

Pre-license validation reduces the risk of assigning licenses to the wrong users, creating unexpected mailboxes, or discovering address conflicts after service activation.
