# UPN, Attribute, License, and Sign-In Readiness Validation

## Purpose

This document records the post-sync validation of pilot users synchronized from on-premises Active Directory to Microsoft Entra ID.

## Sync Context

| Item | Value |
|---|---|
| Sync method | Microsoft Entra Cloud Sync |
| Sync direction | Active Directory to Microsoft Entra ID |
| AD domain | corp.democompany1016.local |
| Public UPN suffix | summitridge-mfg.com |
| Provisioning agent | MGMT01 |
| Pilot group | GRP-EntraCloudSync-Pilot |

## Pilot Users

| User | Cloud UPN |
|---|---|
| Emma Wilson | emma.wilson@summitridge-mfg.com |
| Olivia Brown | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | sophia.martinez@summitridge-mfg.com |

## Validation Performed

Validation included:

- Microsoft Graph connection
- Synced pilot user lookup
- UPN validation
- AD-to-cloud attribute comparison
- UsageLocation validation
- Tenant license inventory export
- License readiness decision
- Sign-in readiness decision

## Expected Identity Result

Each pilot user should exist in Microsoft Entra ID with:

```text
first.last@summitridge-mfg.com
```

Each pilot user should show as synchronized from on-premises Active Directory.

## License Readiness

UsageLocation was validated because Microsoft 365 license assignment requires a user location.

For this lab, the location used was:

```text
US
```

## License Assignment Decision

Licenses were not assigned in Project 04.

License assignment is deferred to:

```text
Project 05 — Microsoft 365 Licensing, Exchange Online Mailbox Enablement, and Address Standardization
```

## Why Licensing Was Deferred

Project 04 focuses on proving hybrid identity synchronization.

Project 05 will handle:

- Microsoft 365 license assignment
- Exchange Online mailbox enablement
- Primary SMTP standardization
- Email alias validation
- Mailbox readiness validation

## Sign-In Readiness

The pilot users are identity-ready when:

- Cloud user exists
- Account is enabled
- OnPremisesSyncEnabled is true
- UPN uses summitridge-mfg.com
- Password hash sync is enabled in the Cloud Sync configuration

Service access is still pending until licensing is completed.

## Business Risk

Assigning licenses too early can cause:

- Premature mailbox creation
- Incorrect service access
- Licensing confusion
- Helpdesk impact
- Mailbox/address planning issues

## Risk Treatment

The project separates identity sync validation from Microsoft 365 service activation.

## Business Value

This confirms that the company can synchronize on-premises AD users into Microsoft Entra ID with professional UPNs before assigning Microsoft 365 licenses and enabling cloud services.
