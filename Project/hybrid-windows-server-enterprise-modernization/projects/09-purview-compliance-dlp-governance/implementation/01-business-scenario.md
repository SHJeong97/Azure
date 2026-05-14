# Business Scenario

## Company

Summit Ridge Manufacturing Group is a simulated 250-user hybrid organization modernizing Microsoft identity, Microsoft 365, security operations, privileged access, email security, and compliance governance.

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
| Email security state | Defender for Office 365 pilot baseline implemented |
| Compliance governance state | Purview baseline not yet configured |

## Previous Project Baseline

Project 04 synchronized selected on-premises Active Directory users into Microsoft Entra ID.

Project 05 activated Microsoft 365 services by assigning licenses, provisioning Exchange Online mailboxes, and standardizing primary SMTP addresses.

Project 06 implemented Conditional Access, MFA enforcement, legacy authentication controls, break-glass exclusions, rollback scripts, and privacy-safe sign-in evidence.

Project 07 implemented privileged access governance using Microsoft Entra PIM, admin role inventory, eligible role assignments, activation testing, manual access review evidence, audit monitoring, rollback controls, and operational runbooks.

Project 08 implemented a pilot-scoped Microsoft Defender for Office 365 email security baseline with anti-phishing, Safe Links, Safe Attachments, quarantine workflow, threat submissions, alert review, mail flow validation, and sanitized message trace evidence.

## Business Problem

The organization has identity, Microsoft 365, privileged access, and email protection foundations, but compliance and data governance controls are not yet baselined.

Without Microsoft Purview governance, sensitive data may be stored, shared, retained, deleted, or discovered inconsistently.

The company needs a documented compliance baseline for data classification, data loss prevention, retention, audit review, and eDiscovery workflow.

## Business Need

The company needs to:

- Review Microsoft Purview readiness
- Validate compliance administrator access
- Review audit availability
- Create a sensitivity label design
- Publish sensitivity labels to pilot users
- Validate label visibility where available
- Create DLP policy design
- Configure DLP in test mode where supported
- Create retention label and policy planning
- Document content search and eDiscovery workflow
- Export safe compliance evidence
- Avoid exposing private document or email content
- Create rollback and operational controls

## Target Pilot Users

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Target Data Governance Areas

| Area | Purpose |
|---|---|
| Sensitivity labels | Classify and protect business content |
| Label publishing | Make labels available to pilot users |
| Data Loss Prevention | Detect and prevent risky sharing of sensitive information |
| Retention labels | Classify content for lifecycle governance |
| Retention policies | Apply retention behavior to Microsoft 365 locations |
| Audit | Review compliance and administrative activity |
| Content Search / eDiscovery | Document search and discovery workflow |
| Compliance evidence | Prove configuration without exposing private content |

## Target Label Design

| Label | Purpose |
|---|---|
| Public | Content approved for broad sharing |
| Internal | Normal internal business content |
| Confidential | Sensitive internal content requiring stronger handling |
| Highly Confidential | Restricted business content requiring strict handling |

## Target DLP Design

| DLP Area | Intended Result |
|---|---|
| Financial data | Detect sensitive financial information in test mode |
| HR data | Detect sensitive employee-related information in test mode |
| External sharing | Review risky outbound sharing behavior |
| Policy mode | Test mode first, not full enforcement |
| Evidence | Policy state and safe validation notes only |

## Target Retention Design

| Retention Area | Intended Result |
|---|---|
| General business records | Retain for a defined business period |
| HR records | Plan longer retention due to employee record sensitivity |
| Finance records | Plan retention for business and audit needs |
| Deletion behavior | Document carefully before enforcement |
| Evidence | Policy and label design only unless safe to create |

## Privacy-Safe Evidence Rule

Do not export:

```text
IpAddress
Location
City
State
CountryOrRegion
Private document content
Private email body content
Full eDiscovery result content
Sensitive document previews
Sensitive message previews
```

Screenshots must be cropped or blurred if they show public IP address, location, device details, session metadata, private document text, private email content, search result previews, file names containing sensitive data, message IDs, or user activity details beyond what is needed for the lab.

## Safety Decisions

This project will not:

- Export private document content
- Export private email body content
- Publish sensitive search results
- Create destructive retention behavior without planning
- Turn on DLP full enforcement before test-mode validation
- Remove emergency access
- Depend on Intune
- Require compliant devices
- Export public IP or location fields

## Business Value

This project establishes a Microsoft Purview compliance and data governance baseline.

It demonstrates practical skills in data classification, sensitivity labels, DLP planning, retention governance, audit review, eDiscovery workflow, compliance documentation, rollback planning, and privacy-safe evidence handling.

This supports real-world Microsoft 365 Administrator, Compliance Administrator, Security Administrator, IAM, and cloud governance responsibilities.
