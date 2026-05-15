# Audit, eDiscovery, and Compliance Monitoring Workflow

## Purpose

This document records the Microsoft Purview audit, Content Search/eDiscovery, compliance alerts, Activity Explorer, Content Explorer, and compliance monitoring workflow for Project 09.

## Project Context

Project 09 is the final project in the portfolio sequence.

The project focuses on Microsoft Purview compliance and governance capabilities, including sensitivity labels, DLP design, retention governance, audit review, eDiscovery workflow, compliance monitoring, and privacy-safe evidence handling.

Batch 6 focuses on audit and compliance investigation workflow without exporting private Microsoft 365 content.

## Workflow Scope

| Workflow Area | Final Treatment |
|---|---|
| Audit | Sanitized audit evidence exported |
| Content Search | Workflow reviewed only |
| eDiscovery | Workflow reviewed only |
| Compliance alerts | Reviewed only |
| Activity Explorer | Reviewed or limitation documented |
| Content Explorer | Reviewed or limitation documented |
| Data classification | Reviewed safely |

## Audit Review

Audit was reviewed from:

```text
Microsoft Purview portal
→ Solutions
→ Audit
```

A sanitized unified audit search was also completed through PowerShell.

The audit export included:

- Creation date
- User IDs
- Operation
- Workload
- Result status

The audit export intentionally excluded:

- AuditData
- ObjectId
- ClientIP
- Public IP address
- Location data
- Private content references
- Message IDs
- SharePoint URLs
- OneDrive URLs
- Mailbox item IDs

## Audit Safety Decision

Audit records can expose sensitive operational details if exported without filtering.

Project 09 exported only sanitized audit fields and avoided full audit payloads.

## Content Search Workflow

Content Search / eDiscovery workflow was reviewed from:

```text
Microsoft Purview portal
→ Solutions
→ eDiscovery
```

And, where available:

```text
Microsoft Purview portal
→ Solutions
→ Content search
```

No Content Search was created.

No search results were exported.

No result previews were published.

## eDiscovery Workflow

The eDiscovery workflow was documented conceptually for:

| Area | Treatment |
|---|---|
| Case creation | Reviewed only |
| Search creation | Not performed |
| Custodian or data source selection | Documented conceptually |
| Query and result review | Not performed |
| Export | Not performed |
| Hold | Not performed |

## eDiscovery Safety Decision

eDiscovery and Content Search can expose mailbox, SharePoint, OneDrive, Teams, and Microsoft 365 group content.

For this portfolio lab, the workflow was reviewed without creating cases, searches, holds, or exports.

## Compliance Monitoring Review

The following monitoring areas were reviewed:

| Monitoring Area | Treatment |
|---|---|
| Compliance alerts | Reviewed only |
| Activity Explorer | Reviewed or limitation documented |
| Content Explorer | Reviewed or limitation documented |
| Audit portal | Reviewed |
| Data classification | Reviewed |

A small lab tenant may show limited or no compliance alerts.

Activity Explorer and Content Explorer may be unavailable or empty depending on licensing, role permissions, portal version, and tenant data volume.

## Feature Limitation Handling

If a feature was unavailable, the correct lab response was:

1. Capture a sanitized screenshot.
2. Document the limitation.
3. Avoid forcing unsupported configuration.
4. Continue with safe manual evidence.
5. Do not overstate the result in the final README.

## What Was Completed

Batch 6 completed or documented:

- Batch 6 evidence folder
- Exchange Online and Purview compliance PowerShell connection
- Audit/eDiscovery command validation
- Workflow scope matrix
- Sanitized unified audit search
- Final audit search summary
- Purview Audit portal review
- Audit portal review note
- Content Search/eDiscovery portal workflow review
- Content Search/eDiscovery workflow matrix
- eDiscovery workflow review note
- Compliance alerts review
- Activity Explorer / Content Explorer review or limitation documentation
- Compliance monitoring review matrix
- Compliance monitoring review note
- Batch 6 workflow and monitoring summary

## What Was Not Completed

Batch 6 did not:

- Create a Content Search
- Create an eDiscovery case
- Create an eDiscovery hold
- Export eDiscovery results
- Export Content Search results
- Publish search result previews
- Open private item-level content for evidence
- Perform compliance alert remediation
- Export private document content
- Export private email body content

## Privacy-Safe Evidence Handling

The following data was not exported:

```text
IpAddress
Location
City
State
CountryOrRegion
ClientIP
AuditData
ObjectId
Private document content
Private email body content
Search result previews
Sensitive document previews
Sensitive message previews
Full message headers
SharePoint URLs
OneDrive URLs
Mailbox item IDs
Message IDs
```

Screenshots must be cropped or blurred if they show:

- Public IP address
- Location
- Device details
- Session metadata
- Private document text
- Private email body content
- Search result previews
- Sensitive file names
- SharePoint URLs
- OneDrive URLs
- Mailbox item IDs
- Message IDs
- Full user activity details

## Safety Decisions

This batch did not:

- Export private document content
- Export private email body content
- Export full eDiscovery results
- Create Content Search exports
- Create eDiscovery exports
- Publish result previews
- Export public IP address fields
- Export location fields
- Export full audit payloads

## Business Risk

Audit, Content Search, and eDiscovery workflows can expose sensitive Microsoft 365 content if used without strict evidence handling.

Search result exports, previews, object IDs, URLs, message IDs, and audit payloads can reveal private business information.

## Risk Treatment

The project reduced risk by exporting only sanitized audit fields, reviewing eDiscovery workflow without creating searches, avoiding exports, and documenting monitoring limitations transparently.

## Business Value

This batch demonstrates Microsoft Purview audit and compliance investigation awareness.

It shows how to validate audit visibility, document eDiscovery workflow, review compliance monitoring areas, and preserve privacy-safe portfolio evidence without exposing sensitive Microsoft 365 content.
