# Privileged Access Operational Runbook

## Purpose

This runbook defines operational monitoring, rollback readiness, emergency access protection, and evidence-handling procedures for Project 07 privileged access governance.

## Project Scope

Project 07 focuses on Microsoft Entra Privileged Identity Management, admin role inventory, eligible role assignments, PIM activation testing, access review documentation, audit monitoring, and rollback controls.

## Key Accounts

| Account | Purpose |
|---|---|
| srmgadmin@democompany1016.onmicrosoft.com | Existing lab administrator and reviewer |
| emergency.access01@democompany1016.onmicrosoft.com | Emergency access account |
| sophia.martinez@summitridge-mfg.com | PIM activation pilot user |

## Governed Roles

| Role | Governance Purpose |
|---|---|
| Global Administrator | Emergency tenant recovery and critical administration |
| Privileged Role Administrator | Role and PIM administration |
| Security Administrator | Security administration |
| Conditional Access Administrator | Conditional Access management |
| Exchange Administrator | Exchange Online administration |
| User Administrator | User and group administration |
| Helpdesk Administrator | Helpdesk and password support |

## Current Pilot PIM State

Sophia Martinez has eligible assignments for:

```text
User Administrator
Helpdesk Administrator
```

These roles are used for Project 07 PIM activation workflow testing.

## Emergency Access Rule

The emergency access account must remain available:

```text
emergency.access01@democompany1016.onmicrosoft.com
```

Do not remove, disable, or weaken emergency access during normal privileged access governance tasks.

## Monitoring Checklist

| Area | Healthy State |
|---|---|
| Emergency access account | Account exists and is enabled |
| Emergency access role assignment | Required recovery role remains assigned |
| Sophia eligible assignments | User Administrator and Helpdesk Administrator remain eligible during lab |
| Sophia active assignments | No active assignment remains after testing |
| Privileged role assignments | Assignments are explainable |
| PIM audit activity | Activation and deactivation activity is explainable |
| Emergency access sign-ins | Rare and documented |
| Evidence privacy | No public IP or location data exported |

## Monitoring Scripts

| Script | Purpose |
|---|---|
| export-pim-operational-state.ps1 | Exports target account and PIM operational state |
| monitor-privileged-role-assignments.ps1 | Reviews active privileged role assignments |
| monitor-sophia-pim-eligibility.ps1 | Reviews Sophia eligible and active PIM assignments |
| monitor-emergency-access-state.ps1 | Reviews emergency access account and role state |
| export-privileged-signins-sanitized.ps1 | Exports sign-ins without IP or location fields |

## Rollback Triggers

Rollback or corrective action should be considered if:

- Emergency access is missing or disabled
- Emergency access role assignment is missing
- Sophia keeps an active role longer than expected
- A wrong user receives a privileged assignment
- A privileged role is assigned too broadly
- An access review result is applied unexpectedly
- Evidence exposes public IP or location data

## Rollback Order

1. Confirm emergency access is available.
2. Identify the affected role, user, or assignment.
3. Stop new privileged access changes.
4. Deactivate temporary active assignments if needed.
5. Restore required emergency or admin access if missing.
6. Document the issue.
7. Export sanitized audit evidence.
8. Update the risk register and validation checklist.
9. Resume changes only after validation.

## Privacy-Safe Evidence Rule

Do not export these fields:

```text
IpAddress
Location
City
State
CountryOrRegion
```

Screenshots must be cropped or blurred if they show public IP address, location, device details, browser details, session metadata, phone numbers, or QR codes.

## Safety Decisions

This operational model does not:

- Remove emergency access
- Remove privileged assignments automatically
- Auto-apply access review results
- Depend on Intune
- Require compliant devices
- Export public IP address fields
- Export location fields

## Business Value

This runbook provides a safe operational process for privileged access governance, emergency access preservation, PIM monitoring, rollback readiness, and privacy-safe evidence handling.
