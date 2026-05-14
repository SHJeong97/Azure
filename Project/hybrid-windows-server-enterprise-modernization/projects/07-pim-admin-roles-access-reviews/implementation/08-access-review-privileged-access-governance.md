# Access Review for Privileged Access Governance

## Purpose

This document records the privileged access review design, manual review evidence, reviewer decisions, and access review limitations for Project 07.

## Project Context

Project 07 builds a privileged access governance baseline using Microsoft Entra Privileged Identity Management, admin role inventory, access review planning, audit monitoring, and rollback controls.

Batch 5 focuses on access review readiness and privileged access review documentation.

## Review Method

The original plan was to create scoped PIM access reviews in the Microsoft Entra admin center.

During testing, the tenant portal did not allow the exact Sophia-only scoped PIM eligible assignment review with the available options.

The corrected lab approach used manual documented access review records.

## Reviews Documented

| Review Name | Review Type | Target | Decision |
|---|---|---|---|
| AR-P07-PIM-Eligible-Assignments-Sophia | Manual documented access review | Sophia Martinez eligible PIM assignments | Approve for lab |
| AR-P07-Emergency-Access-Exception | Manual documented access review | Emergency access account | Approve / preserve |
| AR-P07-Standing-Admin-Access | Manual documented access review | Current privileged role assignments | Review for future PIM conversion |

## Sophia Eligible Assignment Review

| Item | Value |
|---|---|
| Target user | sophia.martinez@summitridge-mfg.com |
| Access reviewed | Eligible User Administrator and Helpdesk Administrator |
| Reviewer | srmgadmin@democompany1016.onmicrosoft.com |
| Decision | Approve for Project 07 testing |
| Reason | Required for PIM activation workflow testing |
| Access removed | No |
| Results auto-applied | No |

## Emergency Access Review

| Item | Value |
|---|---|
| Target account | emergency.access01@democompany1016.onmicrosoft.com |
| Access reviewed | Emergency administrative access |
| Reviewer | srmgadmin@democompany1016.onmicrosoft.com |
| Decision | Approve / preserve access |
| Reason | Required for tenant recovery |
| Access removed | No |
| Results auto-applied | No |

## Standing Admin Access Review

Standing privileged role assignments were documented for future PIM conversion review.

No standing privileged access was removed in this batch.

## Portal Limitation

The Microsoft Entra portal did not provide the exact scoped review options needed for the Sophia-only PIM eligible assignment review in this lab tenant.

This limitation was documented instead of forcing unsupported portal settings.

## Safety Decisions

This batch did not:

- Remove emergency access
- Remove privileged role assignments
- Auto-apply access review results
- Remove denied access automatically
- Modify Global Administrator assignments
- Export public IP address fields
- Export location fields

## Privacy-Safe Evidence Handling

The following fields were not exported:

```text
IpAddress
Location
City
State
CountryOrRegion
```

Screenshots must be cropped or blurred if the portal displays public IP address, location, device details, browser details, or session metadata.

## Business Risk

Access reviews can remove or change privileged access if configured with automatic result application.

Incorrectly scoped access reviews can review the wrong users, miss privileged assignments, or affect emergency access.

## Risk Treatment

The project reduced risk by using manual documented review evidence, disabling automatic result application, preserving emergency access, and avoiding access removal in the lab.

## Business Value

This batch demonstrates privileged access review governance while preserving safety controls and documenting portal limitations clearly.
