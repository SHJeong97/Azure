
# Privileged Access Design

## Purpose

This document defines the privileged access governance design for Project 07.

## Management Platform

```text
Microsoft Entra Privileged Identity Management
```

## Governance Goals

The project focuses on:

- Reducing standing privileged access
- Using eligible access where appropriate
- Requiring justification during activation
- Documenting activation controls
- Preparing access reviews
- Monitoring privileged role activity
- Preserving emergency access

## Admin Access Model

| Access Type | Description | Use Case |
|---|---|---|
| Permanent active assignment | Role is always active | Emergency access or required standing admin access |
| Eligible assignment | Role can be activated when needed | Standard admin operational access |
| Time-bound assignment | Assignment has start and end time | Temporary project or support access |
| Reviewed assignment | Assignment is periodically reviewed | Governance and audit readiness |

## Recommended Pilot Admin Accounts

| Account | Purpose |
|---|---|
| srmgadmin@democompany1016.onmicrosoft.com | Existing lab admin account |
| emergency.access01@democompany1016.onmicrosoft.com | Emergency access account |
| sophia.martinez@summitridge-mfg.com | IT pilot user for limited admin workflow testing |

## Target Admin Roles

| Role | Governance Intent |
|---|---|
| Global Administrator | Preserve only for emergency or required tenant-wide administration |
| Privileged Role Administrator | Govern role assignment and PIM management |
| Security Administrator | Govern security policy and alert administration |
| Conditional Access Administrator | Govern Conditional Access policy management |
| Exchange Administrator | Govern Exchange Online administrative tasks |
| User Administrator | Govern user and group administration |
| Helpdesk Administrator | Govern limited password and support operations |

## Emergency Access Principle

The emergency access account must remain available for tenant recovery.

The project will not remove emergency access.

The emergency access account should not be used for daily administration.

## Planned PIM Controls

| Control | Target |
|---|---|
| Eligible role assignment | Standard admin roles |
| Activation duration | Limited activation window |
| Activation justification | Required |
| MFA on activation | Required where supported |
| Approval | Optional for lab, recommended for production |
| Access review | Planned for privileged role assignments |
| Audit review | Required after activation testing |

## Access Review Scope

Access reviews will focus on:

- Privileged admin groups
- Role-assignable groups if used
- Users with privileged roles
- Emergency access exclusion membership
- Standing administrative assignments

## Privacy-Safe Evidence Rule

Do not export:

```text
IpAddress
Location
City
State
CountryOrRegion
```

Screenshots must be sanitized if the portal displays IP address, location, device details, or session metadata.

## Safety Decisions

This project will not:

- Remove emergency access
- Remove current admin access before validation
- Assign privileged roles broadly
- Convert all admins at once
- Export public IP or location fields
- Depend on Intune
- Require compliant devices

## Business Risk

Privileged role changes can cause:

- Administrator lockout
- Loss of tenant management access
- Over-permissioned users
- Unreviewed standing privilege
- Weak accountability for admin activity
- Delayed recovery during incidents

## Risk Treatment

The project reduces risk by inventorying privileged access first, preserving emergency access, using pilot admin accounts, documenting PIM controls, and validating changes before expansion.

## Business Value

This design creates a controlled privileged access governance model for least privilege, just-in-time access, access reviews, and audit readiness.
