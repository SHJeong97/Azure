# Pilot UPN Change Result

## Purpose

This document records the result of the pilot UPN migration for Summit Ridge Manufacturing Group.

## Domain Context

Internal AD DS domain:

```text
corp.democompany1016.local
```

Verified Microsoft 365 public domain:

```text
summitridge-mfg.com
```

## Pilot Users

| User | Department | Previous UPN | New UPN |
|---|---|---|---|
| Emma Wilson | HR | emma.wilson@corp.democompany1016.local | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@corp.democompany1016.local | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@corp.democompany1016.local | sophia.martinez@summitridge-mfg.com |

## Change Method

The pilot users were changed using Active Directory PowerShell:

```powershell
Set-ADUser -Identity <samAccountName> -UserPrincipalName <targetUPN>
```

## Validation Performed

Validation included:

- Confirmed summitridge-mfg.com exists as an AD UPN suffix
- Exported pilot users before change
- Created rollback CSV before change
- Checked for duplicate target UPNs
- Applied pilot UPN changes
- Validated pilot users after change
- Validated pilot UPNs from DC01 and DC02
- Confirmed only pilot users changed
- Exported full user UPN inventory after change
- Confirmed rollback script remains available

## Safety Decision

Only three pilot users were changed.

No broad user migration was performed.

No AD DS domain rename was performed.

No MX/mail-flow cutover was performed as part of this UPN change.

## Rollback Plan

Rollback values were captured before the change.

If required, users can be reverted to:

```text
@corp.democompany1016.local
```

using:

```powershell
Set-ADUser -Identity <samAccountName> -UserPrincipalName <rollbackUPN>
```

## Business Risk

UPN changes can affect:

- Microsoft 365 sign-in
- Teams identity
- OneDrive identity
- Outlook profiles
- Mobile sign-in
- Helpdesk volume

## Risk Treatment

Risk was reduced by:

- Using a small pilot group
- Selecting users from HR, Finance, and IT
- Exporting rollback values
- Validating after change
- Confirming only pilot users changed
- Keeping mail-flow changes separate

## Business Value

The pilot confirms that the company can begin moving from internal AD-style sign-in names to professional Microsoft 365 identities using the verified public domain:

```text
first.last@summitridge-mfg.com
```

This prepares the environment for broader Microsoft 365 identity and email migration work.
