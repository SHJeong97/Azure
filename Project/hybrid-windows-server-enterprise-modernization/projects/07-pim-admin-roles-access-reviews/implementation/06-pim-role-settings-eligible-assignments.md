# PIM Role Settings and Eligible Assignments

## Purpose

This document records PIM role setting review, activation control planning, and pilot eligible role assignment creation for Project 07.

## Project Context

Project 07 builds a privileged access governance baseline using Microsoft Entra Privileged Identity Management, admin role inventory, access review planning, audit monitoring, and rollback controls.

Batch 3 focuses on preparing eligible privileged role assignments for pilot testing.

## Pilot User

| User | UPN | Purpose |
|---|---|---|
| Sophia Martinez | sophia.martinez@summitridge-mfg.com | IT pilot user for limited privileged access workflow testing |

## Eligible Roles Created or Confirmed

| Role | Assignment Type | Scope | Purpose |
|---|---|---|---|
| User Administrator | Eligible | Directory-wide | Pilot user and group administration workflow |
| Helpdesk Administrator | Eligible | Directory-wide | Pilot helpdesk and password support workflow |

## Activation Control Design

| Control | Lab Baseline |
|---|---|
| Activation duration | 2 hours recommended |
| MFA on activation | Required where supported |
| Justification | Required |
| Approval | Not required for lab pilot |
| Notifications | Default or documented current state |

## Roles Reviewed

The following roles were reviewed during planning:

| Role | Batch 3 Decision |
|---|---|
| Global Administrator | Preserve emergency access; do not modify |
| Privileged Role Administrator | Document and preserve required admin control |
| Security Administrator | Planned for future governance |
| Conditional Access Administrator | Planned for future governance |
| User Administrator | Eligible pilot assignment created or confirmed |
| Helpdesk Administrator | Eligible pilot assignment created or confirmed |

## Safety Decisions

This batch did not:

- Remove emergency access
- Modify the Global Administrator emergency assignment
- Remove active administrator assignments
- Perform tenant-wide privileged role cleanup
- Create access reviews
- Export public IP address fields
- Export location fields

## Privacy-Safe Evidence Handling

The following fields were not exported:

- IpAddress
- Location
- City
- State
- CountryOrRegion

Screenshots must be cropped or blurred if the portal displays public IP address, location, device details, or session metadata.

## Validation Performed

Validation included:

- Microsoft Graph connection
- Target admin account readiness export
- Target role definition export
- PIM activation control design matrix
- PIM role settings portal review
- Pilot eligible role assignment plan
- Sophia Martinez account resolution
- Target role definition resolution
- Existing eligible assignment export
- Eligible assignment creation or confirmation
- Post-change eligible assignment validation
- Eligible assignment evidence note

## Expected Result

Sophia Martinez should have eligible PIM assignments for:

- User Administrator
- Helpdesk Administrator

These assignments will be used for activation workflow testing in the next batch.

## Business Risk

Privileged role assignment changes can cause over-permissioning, admin workflow failure, or tenant access issues if made without planning.

## Risk Treatment

The project reduces risk by using a single pilot user, low-risk admin roles, eligible assignments, documented activation controls, and emergency access preservation.

## Business Value

This batch demonstrates a controlled move from standing privilege toward just-in-time privileged access using Microsoft Entra PIM.
