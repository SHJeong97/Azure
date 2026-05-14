# Business Scenario

## Company

Summit Ridge Manufacturing Group is a simulated 250-user hybrid organization modernizing Microsoft identity, Microsoft 365 services, privileged access governance, and email security.

## Current State

| Area | Value |
|---|---|
| Internal AD DS domain | corp.democompany1016.local |
| Microsoft 365 tenant | democompany1016.onmicrosoft.com |
| Verified public domain | summitridge-mfg.com |
| Identity sync method | Microsoft Entra Cloud Sync |
| Microsoft 365 service state | Pilot users licensed and mailbox-enabled |
| Conditional Access state | Pilot MFA and legacy authentication controls implemented |
| Privileged access state | PIM governance baseline implemented |
| Email security state | Defender for Office 365 baseline not yet configured |

## Previous Project Baseline

Project 04 synchronized selected on-premises Active Directory users into Microsoft Entra ID.

Project 05 activated Microsoft 365 services by assigning licenses, provisioning Exchange Online mailboxes, and standardizing primary SMTP addresses.

Project 06 implemented Conditional Access, MFA enforcement, legacy authentication controls, break-glass exclusions, rollback scripts, and privacy-safe sign-in evidence.

Project 07 implemented privileged access governance using Microsoft Entra PIM, admin role inventory, eligible role assignments, activation testing, manual access review evidence, audit monitoring, rollback controls, and operational runbooks.

## Business Problem

The organization has Microsoft 365 mailboxes, but email protection has not yet been fully baselined.

Without a documented email security baseline, users are more exposed to phishing, malware, spoofing, malicious links, malicious attachments, spam, and unsafe mail-flow behavior.

## Business Need

The company needs to:

- Review Exchange Online Protection settings
- Configure anti-phishing protection
- Review anti-spam protection
- Review anti-malware protection
- Configure Safe Links
- Configure Safe Attachments
- Document quarantine handling
- Validate threat submission workflow
- Review alert and investigation workflow
- Export sanitized mail security evidence
- Create rollback and operational controls

## Target Pilot Users

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Target Security Areas

| Area | Purpose |
|---|---|
| Exchange Online Protection | Baseline anti-spam, anti-malware, and filtering controls |
| Anti-phishing policy | Protect against impersonation and spoofing |
| Safe Links | Provide time-of-click URL protection |
| Safe Attachments | Detonate suspicious attachments in a safe environment |
| Quarantine | Review and manage blocked or suspicious messages |
| Threat submissions | Submit suspicious messages for analysis |
| Alerts | Review Defender security alerts |
| Mail flow validation | Confirm expected mail behavior and evidence capture |

## Target State

| Item | Target Result |
|---|---|
| Email security baseline | Documented |
| Policy scope | Pilot users and accepted domains reviewed |
| Anti-phishing controls | Configured or documented |
| Anti-spam controls | Reviewed and documented |
| Anti-malware controls | Reviewed and documented |
| Safe Links | Configured for pilot scope |
| Safe Attachments | Configured for pilot scope |
| Quarantine workflow | Documented |
| Threat investigation workflow | Documented |
| Evidence privacy | No public IP or location fields exported |
| Rollback controls | Documented |

## Privacy-Safe Evidence Rule

Do not export:

```text
IpAddress
Location
City
State
CountryOrRegion
```

Screenshots must be cropped or blurred if the portal displays public IP address, location, device details, browser details, or session metadata.

## Safety Decisions

This project will not:

- Send real phishing emails
- Upload real malware
- Expose public IP or location fields
- Modify tenant-wide mail security policies without pilot validation
- Remove emergency access
- Depend on Intune
- Require compliant devices

## Business Value

This project establishes an email security baseline that protects Microsoft 365 users from phishing, malicious attachments, unsafe links, spoofing, spam, and suspicious mail behavior.

It demonstrates practical Microsoft Defender for Office 365 administration, Exchange Online Protection review, security policy planning, quarantine handling, alert review, and privacy-safe evidence collection.
