# Sync Risk Controls, Rollback, and Operational Monitoring

## Purpose

This document records operational monitoring, rollback readiness, and risk controls for the Microsoft Entra Cloud Sync pilot.

## Sync Configuration

| Item | Value |
|---|---|
| Sync direction | Active Directory to Microsoft Entra ID |
| AD domain | corp.democompany1016.local |
| Tenant | democompany1016.onmicrosoft.com |
| Provisioning agent | MGMT01 |
| Pilot group | GRP-EntraCloudSync-Pilot |
| Scope method | Selected security group |

## Pilot Users

| User | UPN |
|---|---|
| Emma Wilson | emma.wilson@summitridge-mfg.com |
| Olivia Brown | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | sophia.martinez@summitridge-mfg.com |

## Operational Health Checks

The following checks were completed:

- Provisioning agent service health
- AD replication health
- Pilot sync group membership
- Nested group validation
- Synced pilot user validation in Microsoft Entra ID
- summitridge-mfg.com synced user scope check
- Cloud Sync provisioning log review
- Cloud Sync configuration health review
- Accidental-delete protection review

## Healthy Configuration State

Expected healthy state:

```text
Configuration status: Healthy
Password hash sync: Enabled
Agent enabled: 1
Exchange hybrid writeback: Disabled
```

## Scope Control

The pilot scope remains limited to:

```text
GRP-EntraCloudSync-Pilot
```

Nested groups are not used.

Full directory synchronization is not enabled.

## Rollback Readiness

If Cloud Sync causes issues, the first response is to disable the Cloud Sync configuration from Microsoft Entra admin center.

Rollback should follow this order:

1. Disable the Cloud Sync configuration.
2. Confirm provisioning stops.
3. Review provisioning logs.
4. Validate synced cloud users.
5. Remove users from the pilot group only if needed.
6. Avoid deleting cloud users until impact is understood.
7. Document all changes before re-enabling.

## Rollback Scripts

Rollback helper script:

```text
scripts/powershell/remove-pilot-users-from-sync-group.ps1
```

Restore helper script:

```text
scripts/powershell/restore-pilot-users-to-sync-group.ps1
```

## Accidental-Delete Protection

Accidental-delete protection was reviewed as part of operational readiness.

This control helps reduce the risk of a scoping mistake or directory change impacting too many synchronized cloud users.

## Business Risk

Poor sync monitoring can cause:

- Missed provisioning errors
- Unexpected cloud users
- Attribute issues
- Sync scope expansion
- User sign-in disruption
- Helpdesk impact

## Risk Treatment

The project reduces risk by:

- Monitoring the provisioning agent
- Reviewing provisioning logs
- Keeping the sync scope narrow
- Avoiding nested groups
- Reviewing accidental-delete protection
- Preparing rollback scripts
- Keeping licensing separate from synchronization

## Business Value

Operational monitoring and rollback planning make the Cloud Sync pilot safer and more supportable before expanding synchronization to additional users.
