# Rollback and Operational Controls Summary

## Purpose

This document records rollback readiness, operational monitoring controls, emergency access protection, and privacy-safe evidence handling for Project 07.

## Project Context

Project 07 builds a privileged access governance baseline using Microsoft Entra Privileged Identity Management, admin role inventory, eligible role assignments, PIM activation testing, access review documentation, audit monitoring, rollback controls, and operational documentation.

Batch 7 focuses on operational controls and rollback readiness.

## Operational Targets

| Account | Purpose |
|---|---|
| srmgadmin@democompany1016.onmicrosoft.com | Existing lab administrator and reviewer |
| emergency.access01@democompany1016.onmicrosoft.com | Emergency access account |
| sophia.martinez@summitridge-mfg.com | PIM activation pilot user |

## Operational State Exported

The following state was exported:

- Target admin account state
- Current active role assignments
- Sophia current eligible assignments
- Sophia current active assignments
- Rollback decision matrix
- Operational control matrix

## Current Sophia PIM State

Sophia Martinez is expected to have eligible assignments for:

```text
User Administrator
Helpdesk Administrator
```

Sophia should not have active User Administrator or Helpdesk Administrator assignments after Batch 4 deactivation testing.

## Rollback Readiness

Rollback readiness was documented for these scenarios:

| Scenario | Response |
|---|---|
| Sophia eligible assignment no longer needed | Remove eligible assignment only after final validation |
| Sophia role remains active unexpectedly | Deactivate active assignment through PIM |
| Emergency access missing or disabled | Stop changes and restore emergency access |
| Unexpected active admin role assignment found | Document and review before removal |
| Evidence exposes IP/location | Sanitize or remove evidence before GitHub upload |

## Scripts Created

| Script | Purpose |
|---|---|
| export-pim-operational-state.ps1 | Export target account and PIM operational state |
| monitor-privileged-role-assignments.ps1 | Monitor active privileged role assignments |
| monitor-sophia-pim-eligibility.ps1 | Monitor Sophia eligible and active assignments |
| monitor-emergency-access-state.ps1 | Monitor emergency access account and role state |
| export-privileged-signins-sanitized.ps1 | Export privileged sign-ins without IP/location fields |

## Runbook Documents Created

| Document | Purpose |
|---|---|
| 10-privileged-access-operational-runbook.md | Defines monitoring, rollback triggers, emergency access rules, and evidence handling |
| 11-pim-rollback-procedure.md | Defines rollback procedure for active assignments, eligible assignments, emergency access issues, and evidence cleanup |

## Emergency Access Protection

The emergency access account was not removed, disabled, or changed.

```text
emergency.access01@democompany1016.onmicrosoft.com
```

Emergency access must remain available for tenant recovery.

## Safety Decisions

This batch did not:

- Remove emergency access
- Remove privileged assignments
- Remove Sophia eligible assignments
- Execute rollback scripts
- Auto-apply access review results
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

Screenshots must be cropped or blurred if they show public IP address, location, device details, browser details, session metadata, phone numbers, or QR codes.

## Business Risk

Privileged access governance can introduce lockout risk if emergency access is weakened or role assignments are removed without validation.

Operational failure can also occur if PIM activation remains active longer than expected, monitoring is not performed, or rollback steps are not documented.

## Risk Treatment

The project reduces risk by preserving emergency access, documenting rollback procedures, creating monitoring scripts, exporting operational state, and avoiding automatic privileged access removal.

## Business Value

This batch makes the privileged access governance model safer to operate by adding rollback readiness, monitoring controls, and documented recovery procedures.
