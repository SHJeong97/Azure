# Business Scenario

## Company

Summit Ridge Manufacturing Group is a simulated 250-user company modernizing its Microsoft identity and messaging environment.

## Current State

| Area | Value |
|---|---|
| Internal AD DS domain | corp.democompany1016.local |
| Microsoft tenant default domain | democompany1016.onmicrosoft.com |
| Future public domain | summitridge-mfg.com |
| Current user UPN format | first.last@corp.democompany1016.local |
| Target user UPN format | first.last@summitridge-mfg.com |

## Business Problem

The company needs a professional public identity for Microsoft 365 sign-in, Exchange Online email, Teams, OneDrive, SharePoint, and future endpoint management.

Using the internal AD DS domain as the long-term cloud sign-in suffix is not ideal because it is not a public business domain and does not match the company’s external identity.

## Business Need

The company needs to:

- Add summitridge-mfg.com to Microsoft 365
- Verify ownership through public DNS
- Prepare Microsoft 365 service records
- Plan user UPN changes
- Avoid changing every user at once
- Avoid breaking mail flow
- Prepare for future Exchange Online email migration

## Design Decision

The internal AD DS domain will stay:

```text
corp.democompany1016.local
```

The public Microsoft 365 sign-in and email domain will become:

```text
summitridge-mfg.com
```

This avoids an AD DS domain rename while still allowing professional cloud identity.

## Business Value

This project creates a clean Microsoft 365 identity foundation and prepares the company for secure email, Teams, OneDrive, SharePoint, Intune, Conditional Access, and hybrid identity synchronization.
