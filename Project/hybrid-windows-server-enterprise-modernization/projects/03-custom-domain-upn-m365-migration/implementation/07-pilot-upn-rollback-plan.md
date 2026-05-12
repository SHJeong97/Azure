# Pilot UPN Rollback Plan

## Purpose

This document defines the rollback plan for the pilot UPN migration.

## Pilot Users

| User | Target UPN | Rollback UPN |
|---|---|---|
| emma.wilson | emma.wilson@summitridge-mfg.com | emma.wilson@corp.democompany1016.local |
| olivia.brown | olivia.brown@summitridge-mfg.com | olivia.brown@corp.democompany1016.local |
| sophia.martinez | sophia.martinez@summitridge-mfg.com | sophia.martinez@corp.democompany1016.local |

## Rollback Trigger

Rollback may be required if users experience:

- Failed Microsoft 365 sign-in
- Unexpected Teams identity issues
- OneDrive access problems
- Outlook profile confusion
- Application authentication issues
- Helpdesk-impacting identity problems

## Rollback Command Pattern

```powershell
Set-ADUser -Identity <samAccountName> -UserPrincipalName <rollbackUPN>
```

## Rollback Script

Rollback script location:

```text
scripts/powershell/rollback-pilot-upn-change.ps1
```

## Rollback Validation

After rollback, validate each user:

```powershell
Get-ADUser <samAccountName> -Properties UserPrincipalName
```

Expected rollback suffix:

```text
@corp.democompany1016.local
```

## Business Value

Rollback planning reduces risk by giving IT a clear recovery path before changing user identities.
