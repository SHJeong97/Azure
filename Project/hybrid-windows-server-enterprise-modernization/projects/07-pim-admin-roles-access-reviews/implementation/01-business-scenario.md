
# Business Scenario

## Company

Summit Ridge Manufacturing Group is a simulated 250-user hybrid organization modernizing Microsoft identity, Microsoft 365 services, Conditional Access, and privileged access governance.

## Current State

| Area | Value |
|---|---|
| Internal AD DS domain | corp.democompany1016.local |
| Microsoft 365 tenant | democompany1016.onmicrosoft.com |
| Verified public domain | summitridge-mfg.com |
| Identity sync method | Microsoft Entra Cloud Sync |
| Microsoft 365 service state | Pilot users licensed and mailbox-enabled |
| Conditional Access state | Pilot MFA and legacy authentication controls implemented |
| Privileged access state | Standing admin access not yet governed through PIM |

## Previous Project Baseline

Project 04 synchronized selected on-premises Active Directory users into Microsoft Entra ID.

Project 05 activated Microsoft 365 services by assigning licenses, provisioning Exchange Online mailboxes, and standardizing primary SMTP addresses.

Project 06 implemented a controlled Conditional Access baseline with MFA enforcement, legacy authentication controls, break-glass exclusions, rollback scripts, and privacy-safe sign-in evidence handling.

## Business Problem

The organization has implemented identity synchronization, Microsoft 365 services, and Conditional Access controls, but privileged administrator access is not yet formally governed.

Standing privileged access increases risk because admin roles may remain permanently assigned even when users only need temporary access for operational tasks.

## Business Need

The company needs to:

- Inventory current Microsoft Entra admin role assignments
- Identify standing privileged access
- Prepare PIM-based eligible role assignments
- Document role activation controls
- Validate privileged access activation workflow
- Prepare access reviews for privileged assignments
- Monitor role changes and privileged activity
- Preserve emergency access
- Create rollback and operational controls

## Target Admin Roles

Initial governance focus:

| Role | Purpose |
|---|---|
| Global Administrator | Emergency and tenant-wide administration |
| Privileged Role Administrator | Manage role assignments and PIM |
| Security Administrator | Manage security policies and alerts |
| Conditional Access Administrator | Manage Conditional Access policies |
| Exchange Administrator | Manage Exchange Online settings |
| User Administrator | Manage users and groups |
| Helpdesk Administrator | Limited password/helpdesk support |

## Target Pilot Accounts

| Account | Purpose |
|---|---|
| srmgadmin@democompany1016.onmicrosoft.com | Existing lab administrator |
| emergency.access01@democompany1016.onmicrosoft.com | Emergency access account |
| sophia.martinez@summitridge-mfg.com | IT pilot user for limited admin workflow testing |

## Target State

| Item | Target Result |
|---|---|
| Privileged role inventory | Exported and documented |
| Standing admin access | Reviewed |
| PIM eligibility model | Designed |
| Activation controls | Documented |
| Access reviews | Planned for privileged groups and roles |
| Audit evidence | Exported without IP/location fields |
| Emergency access | Preserved |
| Rollback controls | Documented |
| Operational runbook | Created |

## Privacy-Safe Evidence Rule

The project will not export:

```text
IpAddress
Location
City
State
CountryOrRegion
```

Screenshots must be cropped or blurred if the portal displays IP address, location, device details, or session metadata.

## Safety Decisions

This project will not:

- Remove emergency access
- Remove current admin access before validation
- Assign privileged roles broadly
- Convert all administrators at once
- Export public IP or location fields
- Depend on Intune
- Require compliant devices

## Business Value

This project establishes a privileged access governance baseline that supports least privilege, just-in-time access, admin role monitoring, access reviews, and stronger identity security operations.
