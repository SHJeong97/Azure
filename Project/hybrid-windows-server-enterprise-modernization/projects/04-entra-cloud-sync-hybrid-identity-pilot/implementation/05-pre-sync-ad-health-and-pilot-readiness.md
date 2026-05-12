# Pre-Sync AD Health and Pilot Readiness

## Purpose

This document records the pre-sync readiness validation for the Microsoft Entra Cloud Sync pilot.

## Project Context

The company is preparing to synchronize selected on-premises Active Directory users to Microsoft Entra ID using Microsoft Entra Cloud Sync.

## Internal AD DS Domain

```text
corp.democompany1016.local
```

## Verified Public Domain

```text
summitridge-mfg.com
```

## Pilot Sync Group

```text
GRP-EntraCloudSync-Pilot
```

## Pilot Users

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Validation Performed

Pre-sync validation included:

- Admin/session context validation
- AD domain validation
- AD forest and UPN suffix validation
- Domain controller inventory
- AD replication validation
- Internal DNS validation
- Microsoft endpoint DNS validation
- Pilot AD user validation
- Pilot user enabled-state validation
- Pilot sync group creation
- Direct group membership validation
- Nested group check
- Microsoft Entra verified domain check
- Existing cloud user conflict check

## Important Scoping Decision

The pilot sync group uses direct user membership only.

Nested groups are not used.

This is important because nested group members are not included when using group scoping in Microsoft Entra Cloud Sync.

## Current Readiness Result

The environment is ready to proceed to provisioning agent installation if:

- AD replication has no failures
- Pilot users are enabled
- summitridge-mfg.com is verified in Microsoft Entra ID
- No existing cloud-user conflicts were found
- The pilot group contains only direct user members

## Business Risk

Syncing users without readiness checks can cause:

- Duplicate cloud accounts
- Wrong UPNs
- Attribute issues
- Licensing confusion
- Helpdesk impact
- Accidental broad synchronization

## Risk Treatment

The project reduces risk by validating the AD environment, confirming the pilot scope, checking for cloud conflicts, and documenting the readiness state before installing or configuring Cloud Sync.

## Business Value

Pre-sync readiness validation gives the company a safer path to hybrid identity by proving that the pilot users and sync scope are controlled before any cloud synchronization occurs.
