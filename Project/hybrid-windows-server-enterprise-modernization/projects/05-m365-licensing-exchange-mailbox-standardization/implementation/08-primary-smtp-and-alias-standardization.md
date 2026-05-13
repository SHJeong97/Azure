# Primary SMTP and Alias Standardization

## Purpose

This document records the primary SMTP and alias standardization process for the Microsoft 365 pilot mailboxes.

## Pilot Users

| User | UPN | Target Primary SMTP |
|---|---|---|
| Emma Wilson | emma.wilson@summitridge-mfg.com | emma.wilson@summitridge-mfg.com |
| Olivia Brown | olivia.brown@summitridge-mfg.com | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | sophia.martinez@summitridge-mfg.com | sophia.martinez@summitridge-mfg.com |

## Source-of-Authority Decision

The pilot users are synchronized from on-premises Active Directory.

Because of that, address standardization was performed at the Active Directory source first.

The following AD attributes were updated:

```text
mail
proxyAddresses
```

## Target Address Format

The target primary SMTP format is:

```text
first.last@summitridge-mfg.com
```

## Alias Strategy

Each pilot user should have:

| Address Type | Format |
|---|---|
| Primary SMTP | SMTP:first.last@summitridge-mfg.com |
| Tenant alias | smtp:first.last@democompany1016.onmicrosoft.com |

The internal AD domain was not added as an SMTP proxy address.

## Pre-Change Validation

Before making changes, the project exported:

- Current Exchange Online mailbox address state
- Current AD mail and proxyAddresses state
- Target email address plan
- Exchange Online target address conflict check
- AD target address conflict check

## Standardization Process

The project updated each pilot user in Active Directory with:

```text
mail = first.last@summitridge-mfg.com
proxyAddresses = SMTP:first.last@summitridge-mfg.com
proxyAddresses = smtp:first.last@democompany1016.onmicrosoft.com
```

After updating AD, Cloud Sync was restarted from Microsoft Entra admin center.

## Post-Change Validation

Post-change validation included:

- AD mail and proxyAddresses validation
- Microsoft Entra cloud mail/proxyAddresses validation
- Exchange Online mailbox address validation
- Primary SMTP match validation
- Address standardization result summary

## Expected Result

Each mailbox should show:

```text
PrimarySmtpAddress = first.last@summitridge-mfg.com
RecipientTypeDetails = UserMailbox
```

## Sync Propagation Note

Address changes may take time to appear in Microsoft Entra ID and Exchange Online.

If the target primary SMTP is not visible immediately, the result should be documented as sync propagation pending and checked again later.

## Safety Decisions

The project avoided:

- Broad email address policy changes
- Removing aliases before validation
- Adding internal AD domain addresses as SMTP aliases
- Changing unrelated mailboxes
- Standardizing addresses before mailbox provisioning was confirmed

## Business Risk

Incorrect SMTP standardization can cause:

- Mail delivery failures
- Duplicate proxy address conflicts
- Incorrect sender address
- Outlook profile confusion
- Helpdesk escalation

## Risk Treatment

The project reduced risk by exporting pre-change state, checking conflicts, updating only three pilot users, and validating the result after synchronization.

## Business Value

Standardized primary SMTP addresses provide a clean user experience and align sign-in identity with email identity using the verified public domain.
