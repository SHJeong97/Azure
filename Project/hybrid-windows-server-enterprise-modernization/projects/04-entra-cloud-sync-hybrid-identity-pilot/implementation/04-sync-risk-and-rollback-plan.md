# Sync Risk and Rollback Plan

## Purpose

This document identifies the main risks of synchronizing on-premises Active Directory users to Microsoft Entra ID.

## Key Risks

| Risk | Impact | Treatment |
|---|---|---|
| Full directory synced accidentally | Too many users appear in cloud | Use pilot scope only |
| Wrong OU selected | Incorrect users synchronized | Validate OU and users before enabling sync |
| Duplicate cloud users | Sign-in and licensing confusion | Check existing cloud users before sync |
| UPN mismatch | Users may sign in with unexpected names | Validate verified UPN suffix before sync |
| Missing required AD attributes | Cloud user objects may be incomplete | Validate pilot attributes before sync |
| Agent installation failure | Sync cannot start | Confirm prerequisites before install |
| Sync service account issue | Provisioning errors | Use supported Cloud Sync setup flow |
| Accidental deletion behavior | Cloud objects may be impacted | Understand delete/disable behavior before broad rollout |
| Licensing confusion | Users synced but unlicensed | Separate identity sync from license assignment |

## Rollback Principles

The rollback approach for a pilot sync is:

1. Disable the Cloud Sync configuration.
2. Confirm provisioning stops.
3. Remove or adjust pilot scope if needed.
4. Review synchronized cloud users.
5. Do not delete cloud objects until impact is understood.
6. Document what changed.
7. Re-enable only after root cause is understood.

## Pilot Safety Boundary

Only the pilot users should be in scope:

| User | Department |
|---|---|
| Emma Wilson | HR |
| Olivia Brown | Finance |
| Sophia Martinez | IT |

## What Rollback Does Not Mean

Rollback does not automatically mean deleting cloud users.

Cloud objects may be needed for evidence, licensing, mailbox planning, or future validation.

## Business Risk

A poor sync rollout can affect:

- User sign-in
- Licensing
- Mailbox provisioning
- Teams access
- OneDrive access
- Helpdesk volume
- Identity governance

## Risk Treatment

The project reduces risk by:

- Starting with three pilot users
- Validating AD state before sync
- Validating cloud state before sync
- Keeping evidence before and after sync
- Avoiding full-directory synchronization
- Documenting rollback before implementation

## Business Value

A documented rollback plan gives IT a controlled path to stop or correct synchronization before expanding to the full company.
