# Tenant Readiness, Admin Role Inventory, and Privileged Access Baseline

## Purpose

This document records tenant readiness, PIM licensing readiness, admin role inventory, standing privilege review, and emergency access validation for Project 07.

## Project Context

Project 07 builds a privileged access governance baseline for Summit Ridge Manufacturing Group.

The project focuses on Microsoft Entra Privileged Identity Management, admin role governance, access review planning, audit visibility, emergency access preservation, and rollback controls.

## Tenant Readiness Validation

The following tenant readiness checks were completed:

- Microsoft Graph connection
- Tenant organization details export
- Tenant SKU export for PIM readiness
- PIM license readiness summary
- Target admin account readiness export
- Active Microsoft Entra role assignment export
- Privileged role inventory summary

## Target Admin Accounts

| Account | Purpose |
|---|---|
| srmgadmin@democompany1016.onmicrosoft.com | Existing lab administrator |
| emergency.access01@democompany1016.onmicrosoft.com | Emergency access account |
| sophia.martinez@summitridge-mfg.com | IT pilot user for limited admin workflow testing |

## Target Privileged Roles

The following Microsoft Entra roles were reviewed:

| Role | Purpose |
|---|---|
| Global Administrator | Tenant-wide administration and emergency recovery |
| Privileged Role Administrator | Role assignment and PIM management |
| Security Administrator | Security policy and alert administration |
| Conditional Access Administrator | Conditional Access policy administration |
| Exchange Administrator | Exchange Online administration |
| User Administrator | User and group administration |
| Helpdesk Administrator | Limited support and password operations |

## Standing Privilege Review

Standing privilege was reviewed by comparing target admin accounts against active Microsoft Entra role assignments.

The review identified which target accounts currently have active privileged assignments and which accounts should be reviewed for future PIM eligibility.

## Emergency Access Validation

The emergency access account was reviewed:

| Item | Value |
|---|---|
| Emergency access account | emergency.access01@democompany1016.onmicrosoft.com |
| Intended purpose | Tenant recovery |
| Daily admin use | No |
| Governance action | Preserve and monitor |

The project does not remove or weaken emergency access.

## Batch 2 Decision

Batch 2 was documentation-only.

No privileged role assignments were removed.

No PIM assignments were changed.

No access reviews were created.

Emergency access was preserved.

## Privacy-Safe Evidence Handling

The following fields were not exported:

- IpAddress
- Location
- City
- State
- CountryOrRegion

Screenshots must be cropped or blurred if the portal displays public IP address, location, device details, or session metadata.

## Business Risk

Privileged access changes can cause administrator lockout, loss of tenant management access, over-permissioning, or missed privileged activity.

## Risk Treatment

The project reduces risk by inventorying privileged access first, validating emergency access, documenting standing privilege, and delaying role changes until the baseline is understood.

## Business Value

This batch creates the privileged access baseline needed before implementing PIM role settings, eligible assignments, activation testing, access reviews, and privileged activity monitoring.
