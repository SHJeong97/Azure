# Compliance Governance Design

## Purpose

This document defines the Microsoft Purview compliance and data governance design for Project 09.

## Security and Compliance Goal

The goal is to create a safe Microsoft Purview baseline for Summit Ridge Manufacturing Group.

The baseline focuses on:

- Sensitivity labels
- Label publishing
- Data Loss Prevention
- Retention labels
- Retention policies
- Audit review
- Content Search / eDiscovery workflow
- Compliance monitoring
- Privacy-safe evidence collection
- Rollback planning

## Current Environment

| Area | Value |
|---|---|
| Microsoft 365 tenant | democompany1016.onmicrosoft.com |
| Verified public domain | summitridge-mfg.com |
| Identity source | On-premises AD synced through Microsoft Entra Cloud Sync |
| Pilot mailboxes | Emma Wilson, Olivia Brown, Sophia Martinez |
| Conditional Access baseline | Implemented in Project 06 |
| Privileged access governance | Implemented in Project 07 |
| Email security baseline | Implemented in Project 08 |
| Purview baseline | Not yet configured |

## Pilot Users

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Governance Scope

| Governance Area | Target Design |
|---|---|
| Sensitivity labels | Create classification labels for business content |
| Label publishing | Publish labels to pilot users first |
| DLP | Configure test-mode policy for sensitive data scenarios |
| Retention labels | Design labels for business records |
| Retention policies | Plan retention scope without destructive enforcement |
| Audit | Review compliance-related audit events |
| Content Search / eDiscovery | Document search workflow without exporting private content |
| Monitoring | Review compliance alerts and activity where available |

## Sensitivity Label Design

| Label | Purpose | Protection Intent |
|---|---|---|
| Public | Approved for broad sharing | No encryption required |
| Internal | Normal internal business content | Internal handling |
| Confidential | Sensitive internal information | Stronger handling and user awareness |
| Highly Confidential | Restricted business information | Strict handling and limited sharing |

## Sensitivity Label Publishing Design

Labels should be published to pilot users first:

```text
emma.wilson@summitridge-mfg.com
olivia.brown@summitridge-mfg.com
sophia.martinez@summitridge-mfg.com
```

Pilot-first publishing reduces the risk of confusing users or applying labels broadly before validation.

## DLP Design

DLP will use test mode first.

| DLP Area | Design Decision |
|---|---|
| Policy scope | Pilot users / Exchange Online / SharePoint / OneDrive where available |
| Sensitive data type | Financial or employee-related data indicators |
| Mode | Test mode first |
| Enforcement | No full enforcement until validation |
| User impact | Minimized during lab testing |
| Evidence | Policy state and safe notes only |

## Retention Design

Retention planning will focus on records governance without destructive actions.

| Retention Area | Design Decision |
|---|---|
| General business content | Plan business retention label |
| HR content | Plan HR records label |
| Finance content | Plan finance records label |
| Deletion behavior | Avoid destructive deletion in lab |
| Scope | Pilot locations where safe |
| Evidence | Design and configuration state only |

## Audit and eDiscovery Design

Audit and search workflows will be documented carefully.

| Area | Design Decision |
|---|---|
| Audit | Review administrative and compliance activity |
| Content Search | Document workflow with safe search terms |
| eDiscovery | Document workflow without exporting private content |
| Search results | Do not expose full result previews |
| Export behavior | Avoid exporting private document or mailbox content |

## Compliance Role Design

Project 09 may require roles such as:

| Role | Purpose |
|---|---|
| Compliance Administrator | Manage Purview compliance features |
| Information Protection Administrator | Manage sensitivity labels |
| Data Loss Prevention Administrator | Manage DLP policies |
| eDiscovery Manager | Review eDiscovery workflow |
| Audit Reader | Review audit evidence |

Use least privilege where possible.

Do not remove emergency access.

## Portal Areas

Primary portal:

```text
Microsoft Purview portal
```

Primary review areas:

```text
Information protection
Data loss prevention
Records management / Data lifecycle management
Audit
eDiscovery / Content search
Data classification
Activity explorer
Content explorer
Alerts
```

Feature names may vary depending on license and portal version.

If a feature is unavailable, document the limitation and continue with safe manual evidence.

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
Full message headers
```

Screenshots must be cropped or blurred if they show:

- Public IP address
- Location
- Device details
- Session metadata
- Private document text
- Private email content
- Search result previews
- Sensitive file names
- Message IDs
- User activity details beyond what is needed for the lab

## Safety Decisions

This project will not:

- Export private document content
- Export private email body content
- Export full eDiscovery results
- Publish sensitive search previews
- Create destructive retention behavior without planning
- Turn on DLP full enforcement before test-mode validation
- Remove emergency access
- Depend on Intune
- Require compliant devices
- Export public IP address fields
- Export location fields

## Rollout Model

The rollout model is:

1. Validate Purview readiness and roles.
2. Review audit and data classification availability.
3. Create sensitivity label design.
4. Publish labels to pilot users.
5. Validate label visibility where available.
6. Create DLP policy in test mode.
7. Review DLP alerts and activity where available.
8. Create retention label and policy design.
9. Document audit and eDiscovery workflow safely.
10. Export final sanitized evidence.
11. Create rollback and operational controls.

## Business Risk

Compliance controls can affect how users classify, share, retain, delete, and discover organizational data.

Incorrectly scoped DLP or retention policies can block business activity, retain content longer than intended, delete content too early, or expose sensitive information in evidence.

## Risk Treatment

The project reduces risk by using pilot scope, test mode, manual review notes, safe evidence handling, and non-destructive retention planning.

## Business Value

This design creates a Microsoft Purview baseline that improves data classification, compliance governance, sensitive information handling, audit readiness, and discovery workflow documentation.

It demonstrates practical compliance administration skills without exposing private content or applying risky enforcement too early.
