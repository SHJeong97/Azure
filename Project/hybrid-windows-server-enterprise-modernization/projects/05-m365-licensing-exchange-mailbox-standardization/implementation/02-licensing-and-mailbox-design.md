# Licensing and Mailbox Design

## Purpose

This document defines the licensing and mailbox enablement design for the Microsoft 365 pilot users.

## Pilot Users

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Licensing Approach

The project will use a controlled pilot license assignment.

For production, group-based licensing is preferred because it scales better for a 100–500 user company.

For this lab, the project will validate:

- Available tenant SKUs
- Pilot user UsageLocation
- Current license state
- License assignment method
- Service provisioning result
- Exchange Online mailbox creation

## Recommended License

Recommended pilot license:

```text
Office 365 E5 trial
```

Reason:

```text
E5 provides strong Microsoft 365 portfolio value and supports Exchange Online mailbox readiness for the pilot users.
```

## Mailbox Enablement Logic

Exchange Online mailboxes are created after users receive an Exchange Online-capable license.

The project will validate mailbox provisioning after licensing instead of manually assuming the mailbox exists.

## Primary SMTP Standard

Target primary SMTP format:

```text
first.last@summitridge-mfg.com
```

Examples:

```text
emma.wilson@summitridge-mfg.com
olivia.brown@summitridge-mfg.com
sophia.martinez@summitridge-mfg.com
```

## Alias Strategy

Each pilot mailbox should be reviewed for:

| Alias Type | Example |
|---|---|
| Primary SMTP | emma.wilson@summitridge-mfg.com |
| Tenant alias | emma.wilson@democompany1016.onmicrosoft.com |
| Legacy/internal reference | emma.wilson@corp.democompany1016.local |

## Safety Decisions

The project will not assign licenses to all users.

The project will not change mailbox addresses until mailboxes exist.

The project will not apply broad email address policy changes.

The project will not remove aliases until mail flow behavior is validated.

## Business Risk

Licensing and mailbox changes can cause:

- Unexpected mailbox creation
- Incorrect sender addresses
- Duplicate proxy address conflicts
- Outlook profile confusion
- Mail delivery issues
- Increased helpdesk tickets

## Risk Treatment

The project reduces risk by:

- Licensing only three pilot users
- Validating UsageLocation first
- Exporting available tenant licenses
- Validating mailbox provisioning after license assignment
- Standardizing addresses after mailbox existence is confirmed
- Documenting rollback options

## Business Value

A controlled pilot license and mailbox rollout proves the company can activate Microsoft 365 services for synchronized users without causing broad identity or messaging disruption.
