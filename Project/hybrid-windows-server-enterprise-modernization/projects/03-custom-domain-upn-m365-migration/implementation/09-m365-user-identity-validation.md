# Microsoft 365 User Identity Validation

## Purpose

This document records the Microsoft 365 / Microsoft Entra identity validation after pilot UPN changes were applied in on-premises Active Directory.

## Domain

Verified public domain:

```text
summitridge-mfg.com
```

Internal AD DS domain:

```text
corp.democompany1016.local
```

## Pilot Users

| User | Department | AD UPN After Batch 5 |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Validation Performed

Validation included:

- Microsoft Graph PowerShell module check
- Microsoft Graph connection validation
- Microsoft 365 / Entra custom domain validation
- Microsoft 365 user export
- Cloud lookup for pilot users
- AD pilot user export
- AD-to-cloud identity comparison

## Important Identity Finding

Update this section based on your validation result:

```text
Pilot users do not exist in Microsoft 365 yet because Entra Connect / Cloud Sync has not been configured.
```

or:

```text
Pilot users exist in Microsoft 365 and were found with summitridge-mfg.com UPNs.
```

## Design Explanation

Changing a user UPN in on-premises Active Directory does not automatically create or update a Microsoft 365 user unless identity synchronization is configured.

This project validates the identity state before broader hybrid identity synchronization.

## Risk

If the company assumes AD changes automatically appear in Microsoft 365 without synchronization, users may experience:

- Missing cloud accounts
- Failed Microsoft 365 sign-in
- Confusion between AD UPN and cloud UPN
- Incorrect mailbox assignment
- Helpdesk ticket increase

## Risk Treatment

The project reduces risk by:

- Validating the verified public domain
- Exporting current cloud users
- Checking pilot users directly in Microsoft 365
- Comparing AD and cloud identity state
- Documenting the identity gap before broader rollout

## Business Value

This validation creates a clear separation between:

```text
On-premises identity state
```

and:

```text
Microsoft 365 / Entra identity state
```

That clarity is necessary before implementing hybrid identity synchronization, licensing, mailbox planning, and user migration.
