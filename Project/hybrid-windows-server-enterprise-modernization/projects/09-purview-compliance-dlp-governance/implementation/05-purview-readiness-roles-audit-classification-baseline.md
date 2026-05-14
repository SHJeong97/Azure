# Purview Readiness, Roles, Audit, and Data Classification Baseline

## Purpose

This document records Microsoft Purview readiness, compliance PowerShell validation, role group review, audit baseline review, and data classification inventory for Project 09.

## Project Context

Project 09 builds the final compliance and data governance baseline for the portfolio project series.

The project focuses on Microsoft Purview compliance capabilities, including sensitivity labels, Data Loss Prevention, retention planning, audit review, Content Search/eDiscovery workflow, and privacy-safe evidence handling.

Batch 2 validates readiness before creating labels, DLP policies, retention policies, or eDiscovery searches.

## Readiness Scope

The following areas were reviewed:

| Area | Result |
|---|---|
| Exchange Online PowerShell connection | Validated |
| Microsoft Purview compliance PowerShell connection | Validated |
| Purview command availability | Validated |
| Pilot mailbox readiness | Validated |
| Unified audit configuration | Validated |
| Purview portal readiness | Reviewed |
| Compliance role group visibility | Reviewed |
| Compliance role group membership | Reviewed |
| Unified audit baseline | Exported with sanitized fields |
| Data classification overview | Reviewed |

## Pilot Users

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Purview PowerShell Validation

The following Microsoft Purview-related commands were validated where available:

| Command | Purpose |
|---|---|
| Get-ComplianceSearch | Validate Content Search / eDiscovery command availability |
| Search-UnifiedAuditLog | Validate unified audit search command availability |
| Get-Label | Validate sensitivity label command availability |

If a command was unavailable, the limitation should be documented and handled with portal evidence or manual notes.

## Compliance Role Review

The following role groups were reviewed without changing membership:

| Role Group | Purpose |
|---|---|
| Compliance Administrator | General Microsoft Purview administration |
| Information Protection | Sensitivity label and information protection management |
| Information Protection Admins | Information protection administration |
| Data Loss Prevention | DLP policy administration |
| eDiscovery Manager | eDiscovery and Content Search workflow |
| Audit Reader | Audit review |
| Records Management | Retention and records governance |
| Organization Management | Broad Exchange/compliance management |

No role assignments were changed in Batch 2.

## Audit Readiness

Audit readiness was validated using Exchange Online and Microsoft Purview PowerShell.

The audit baseline confirmed whether unified audit logging was available and whether organization audit was disabled.

Expected healthy state:

| Setting | Expected Result |
|---|---|
| UnifiedAuditLogIngestionEnabled | True |
| AuditDisabled | False |

## Unified Audit Baseline

A sanitized unified audit search was performed for the last 7 days.

The export included:

- Creation date
- User IDs
- Operations
- Workload
- Result status

The export intentionally excluded:

- AuditData
- ClientIP
- ObjectId
- Private content references
- Location fields

## Data Classification Review

Data classification was reviewed in the Microsoft Purview portal.

Reviewed areas included:

| Area | Review Result |
|---|---|
| Sensitive information types | Reviewed where available |
| Trainable classifiers | Reviewed where available |
| Activity explorer | Reviewed where available |
| Content explorer | Reviewed where available |
| Sensitivity labels | Reviewed where available |
| Retention labels | Reviewed where available |

If Activity Explorer or Content Explorer was unavailable, the limitation should be documented as a feature availability or permission limitation.

## Feature Availability Handling

Some Microsoft Purview features depend on licensing, tenant state, role assignments, or portal version.

If a feature was unavailable, the correct lab response was:

1. Capture a sanitized screenshot.
2. Document the limitation.
3. Avoid forcing unsupported configuration.
4. Continue with safe manual evidence.

## Privacy-Safe Evidence Handling

The following data was not exported:

```text
IpAddress
Location
City
State
CountryOrRegion
AuditData
ClientIP
ObjectId
Private document content
Private email body content
Search result previews
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
- Full user activity details

## Safety Decisions

This batch did not:

- Create sensitivity labels
- Create label publishing policies
- Create DLP policies
- Create retention labels
- Create retention policies
- Create eDiscovery searches
- Change role group membership
- Export private document content
- Export private email body content
- Export public IP address fields
- Export location fields

## Business Risk

Purview configuration can affect classification, data sharing, retention, audit visibility, and compliance workflows.

Starting configuration before validating roles, audit readiness, and feature availability can lead to incomplete implementation, unsupported features, or inaccurate documentation.

## Risk Treatment

The project reduced risk by validating Purview readiness, reviewing compliance roles, checking audit availability, documenting feature availability, and exporting only sanitized baseline evidence before making changes.

## Business Value

This batch establishes the readiness foundation for Microsoft Purview compliance governance.

It proves that Purview access, role visibility, audit readiness, pilot user scope, and data classification areas were reviewed before sensitivity labels, DLP, retention, and eDiscovery workflows were configured.
