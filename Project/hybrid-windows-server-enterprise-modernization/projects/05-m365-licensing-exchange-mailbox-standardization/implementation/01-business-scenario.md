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
