# Pilot UPN Migration Plan

## Purpose

This document defines the pilot UPN migration plan for Summit Ridge Manufacturing Group.

## Current State

The internal Active Directory domain is:

```text
corp.democompany1016.local
```

Current user UPN format:

```text
first.last@corp.democompany1016.local
```

## Target State

The verified Microsoft 365 public domain is:

```text
summitridge-mfg.com
```

Target user UPN format:

```text
first.last@summitridge-mfg.com
```

## Pilot Users

| User | Department | Current UPN | Target UPN |
|---|---|---|---|
| Emma Wilson | HR | emma.wilson@corp.democompany1016.local | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@corp.democompany1016.local | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@corp.democompany1016.local | sophia.martinez@summitridge-mfg.com |

## Why These Users Were Selected

The pilot includes users from HR, Finance, and IT.

This provides coverage across:

- Business user validation
- Sensitive department validation
- Technical/admin support validation

## Safety Decision

No UPN changes are made during Batch 4.

Batch 4 only prepares:

- Current UPN inventory
- Target UPN plan
- Rollback UPN values
- Future change script
- Rollback script

## Planned Change

The future UPN change will use:

```powershell
Set-ADUser -Identity <samAccountName> -UserPrincipalName <targetUPN>
```

## Rollback Plan

If a pilot UPN change causes issues, the rollback script will return users to:

```text
first.last@corp.democompany1016.local
```

## Business Risk

Changing UPNs can affect:

- Microsoft 365 sign-in
- Teams identity
- OneDrive access
- Outlook profile behavior
- Mobile sign-in
- Helpdesk volume

## Risk Treatment

The project reduces risk by:

- Using only three pilot users
- Exporting current UPNs before change
- Preparing rollback commands
- Avoiding broad rollout
- Validating domain verification first
- Keeping MX and mail-flow changes separate

## Business Value

A pilot UPN migration allows the company to validate professional Microsoft 365 sign-in names while reducing identity disruption risk.
