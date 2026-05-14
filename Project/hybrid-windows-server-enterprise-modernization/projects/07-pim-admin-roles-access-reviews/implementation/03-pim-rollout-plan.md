# PIM Rollout Plan

## Purpose

This document defines the rollout plan for Microsoft Entra Privileged Identity Management, admin role governance, and access review preparation.

## Rollout Strategy

The project will start with discovery and documentation before making privileged access changes.

The first goal is to understand current admin role assignments, preserve emergency access, and prepare a controlled PIM governance model.

## Rollout Phases

| Phase | Action | Purpose |
|---|---|---|
| Phase 1 | Inventory admin roles | Identify current privileged access |
| Phase 2 | Validate emergency access | Prevent administrative lockout |
| Phase 3 | Identify standing privilege | Find users with permanent admin roles |
| Phase 4 | Define PIM controls | Plan eligible assignments and activation settings |
| Phase 5 | Configure pilot PIM settings | Apply controlled role activation settings |
| Phase 6 | Test activation workflow | Validate just-in-time admin access |
| Phase 7 | Plan access reviews | Prepare recurring privileged access reviews |
| Phase 8 | Review audit logs | Validate admin activity visibility |
| Phase 9 | Create rollback runbook | Document recovery and operational controls |

## Initial Governance Scope

| Area | Scope |
|---|---|
| Admin role inventory | Microsoft Entra directory roles |
| PIM planning | Privileged Microsoft Entra roles |
| Access reviews | Admin groups and privileged assignments |
| Audit review | Role assignment and activation activity |
| Emergency access | Break-glass account preserved |

## Target Roles

| Role | Rollout Intent |
|---|---|
| Global Administrator | Preserve emergency access and reduce unnecessary standing access |
| Privileged Role Administrator | Govern role and PIM administration |
| Security Administrator | Govern security administration |
| Conditional Access Administrator | Govern Conditional Access management |
| Exchange Administrator | Govern messaging administration |
| User Administrator | Govern user and group administration |
| Helpdesk Administrator | Govern limited support operations |

## Pilot Accounts

| Account | Purpose |
|---|---|
| srmgadmin@democompany1016.onmicrosoft.com | Existing lab administrator |
| emergency.access01@democompany1016.onmicrosoft.com | Emergency access account |
| sophia.martinez@summitridge-mfg.com | IT pilot user for limited admin testing |

## PIM Activation Controls

Planned controls include:

- Limited activation duration
- Justification required
- MFA required where supported
- Approval considered for sensitive roles
- Role activation audit review
- Access review planning

## Emergency Access Protection

Emergency access must remain available.

The project will not remove the emergency access account or make it dependent on temporary activation.

## Privacy-Safe Evidence Rule

Do not export:

```text
IpAddress
Location
City
State
CountryOrRegion
```

Screenshots must be cropped or blurred if they show public IP, location, device details, or session metadata.

## Safety Decisions

This rollout will not:

- Remove emergency access
- Remove current admin roles before inventory
- Convert all roles at once
- Assign privileged roles broadly
- Export public IP or location fields
- Require Intune or compliant devices

## Success Criteria

The rollout is successful when:

- Admin role assignments are inventoried
- Emergency access is preserved
- PIM governance model is documented
- Activation controls are defined
- Access review scope is prepared
- Audit and monitoring evidence is captured safely
- Rollback procedure is documented

## Business Value

A staged PIM rollout reduces privileged access risk while preserving administrative recovery and operational continuity.
