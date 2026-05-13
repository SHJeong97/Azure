# Business Scenario

## Company

Summit Ridge Manufacturing Group is a simulated 250-user hybrid organization modernizing identity and productivity services with Microsoft 365.

## Current State

| Area | Value |
|---|---|
| Internal AD DS domain | corp.democompany1016.local |
| Microsoft 365 tenant | democompany1016.onmicrosoft.com |
| Verified public domain | summitridge-mfg.com |
| Identity sync method | Microsoft Entra Cloud Sync |
| Provisioning agent | MGMT01 |
| Pilot sync group | GRP-EntraCloudSync-Pilot |
| Password hash sync | Enabled |
| Pilot users | Synced to Microsoft Entra ID |
| License state | Not assigned |
| Mailbox state | Not provisioned |

## Business Problem

Project 04 synchronized the pilot users from Active Directory into Microsoft Entra ID.

However, synchronized users cannot use Microsoft 365 services until licenses are assigned.

The company also needs Exchange Online mailboxes and professional email addresses using:

```text
first.last@summitridge-mfg.com
```
## Business Need

### The company needs to:

- Validate synced pilot users before license assignment
- Assign Microsoft 365 licenses in a controlled way
- Confirm Exchange Online mailbox provisioning
- Standardize primary SMTP addresses
- Validate aliases
- Avoid accidental broad license assignment
- Separate identity readiness from service activation
- Document rollback and monitoring


| User            | Target Sign-In                                                                    | Target Primary SMTP                                                               |
| --------------- | --------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| Emma Wilson     | [emma.wilson@summitridge-mfg.com](mailto:emma.wilson@summitridge-mfg.com)         | [emma.wilson@summitridge-mfg.com](mailto:emma.wilson@summitridge-mfg.com)         |
| Olivia Brown    | [olivia.brown@summitridge-mfg.com](mailto:olivia.brown@summitridge-mfg.com)       | [olivia.brown@summitridge-mfg.com](mailto:olivia.brown@summitridge-mfg.com)       |
| Sophia Martinez | [sophia.martinez@summitridge-mfg.com](mailto:sophia.martinez@summitridge-mfg.com) | [sophia.martinez@summitridge-mfg.com](mailto:sophia.martinez@summitridge-mfg.com) |

## Business Value

This project activates Microsoft 365 productivity services for synchronized users while keeping licensing, mailbox provisioning, and address standardization controlled and measurable.
