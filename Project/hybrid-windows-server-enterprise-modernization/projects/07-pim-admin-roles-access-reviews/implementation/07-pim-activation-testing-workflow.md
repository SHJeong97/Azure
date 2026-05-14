# PIM Activation Testing and Evidence Workflow

## Purpose

This document records PIM activation testing, temporary admin capability validation, deactivation, and sanitized evidence collection for Project 07.

## Project Context

Project 07 builds a privileged access governance baseline using Microsoft Entra Privileged Identity Management, admin role inventory, access review planning, audit monitoring, and rollback controls.

Batch 4 validates that an eligible user can activate privileged roles through PIM, perform a view-only admin validation, and deactivate the role afterward.

## Pilot User

| User | UPN | Purpose |
|---|---|---|
| Sophia Martinez | sophia.martinez@summitridge-mfg.com | IT pilot user for PIM activation workflow testing |

## Eligible Roles Tested

| Role | Intended Workflow |
|---|---|
| User Administrator | User and group administration workflow |
| Helpdesk Administrator | Helpdesk/password support workflow |

## Activation Workflow

Sophia reviewed eligible assignments from:

```text
Microsoft Entra admin center
→ Identity governance
→ Privileged Identity Management
→ My roles
→ Microsoft Entra roles
```

Activation testing used:

```text
Activation duration: 2 hours
Justification: Project 07 PIM activation workflow validation
```

## Activation Result

| Role | Result |
|---|---|
| User Administrator | Eligible assignment confirmed; not active during deactivation review |
| Helpdesk Administrator | Activated and deactivated successfully |

## Admin Capability Validation

After activation, Sophia performed a view-only validation by opening Microsoft Entra user administration areas.

No user, group, password, role, or emergency access changes were made.

## Deactivation Workflow

Sophia reviewed active assignments from:

```text
Microsoft Entra admin center
→ Identity governance
→ Privileged Identity Management
→ My roles
→ Microsoft Entra roles
→ Active assignments
```

Helpdesk Administrator was deactivated.

User Administrator did not require deactivation because it was not active during the deactivation review.

## Evidence Captured

Evidence included:

- Eligible assignments before activation
- Active assignments before activation
- Activation test plan
- Activation baseline summary
- My Roles portal review note
- Activation test note
- Active assignments after activation
- PIM activation requests
- Sanitized activation audit logs
- Admin capability validation note
- Deactivation evidence note
- Active assignments after deactivation
- Deactivation requests
- Activation/deactivation lifecycle summary

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

## Safety Decisions

This batch did not:

- Remove emergency access
- Modify Global Administrator assignments
- Remove active administrator assignments
- Modify users
- Modify groups
- Reset passwords
- Change Conditional Access policies
- Export public IP address fields
- Export location fields

## Business Risk

PIM activation testing can create temporary privileged access. If not validated carefully, this can result in over-permissioned users, missed deactivation, or incorrect evidence.

## Risk Treatment

The project reduced risk by limiting testing to one pilot user, using low-risk admin roles, validating activation with view-only testing, deactivating the active role, exporting sanitized audit evidence, and documenting no emergency access changes.

## Business Value

This batch proves that eligible privileged access can be activated temporarily, validated, audited, and removed after use.
