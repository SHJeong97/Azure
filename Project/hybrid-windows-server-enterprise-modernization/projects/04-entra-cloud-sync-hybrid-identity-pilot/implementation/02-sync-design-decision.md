# Sync Design Decision

## Purpose

This document records the synchronization design decision for the Summit Ridge hybrid identity pilot.

## Options Considered

| Option | Description |
|---|---|
| Microsoft Entra Cloud Sync | Lightweight cloud-managed synchronization using provisioning agents |
| Microsoft Entra Connect Sync | Traditional on-premises synchronization server |
| Manual cloud user creation | Manually create cloud users without sync |

## Final Decision

The project will use:

```text
Microsoft Entra Cloud Sync
```

## Why Cloud Sync

Cloud Sync is a better fit for this portfolio project because it supports:

- Lightweight agent deployment
- Cloud-managed sync configuration
- Scoped pilot synchronization
- Reduced on-premises sync server management
- Easier demonstration of modern hybrid identity administration

## Why Not Full Directory Sync First

The company should not sync all users immediately.

A full-directory sync could introduce:

- Attribute conflicts
- Duplicate cloud users
- Wrong UPNs
- Licensing confusion
- Helpdesk impact
- Harder rollback

## Pilot Sync Scope

The pilot scope will focus on three users:

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Business Risk

Incorrect sync design can cause:

- Duplicate user objects
- Cloud sign-in problems
- UPN mismatch
- Wrong attributes in Microsoft 365
- Accidental broad rollout
- Licensing mistakes

## Risk Treatment

The project reduces risk by:

- Using a pilot scope first
- Validating AD attributes before sync
- Verifying the public UPN suffix
- Capturing pre-sync evidence
- Documenting rollback planning
- Validating cloud user state after sync

## Business Value

A scoped hybrid identity pilot lets the company validate Microsoft 365 identity readiness without taking unnecessary risk across all 250 users.
