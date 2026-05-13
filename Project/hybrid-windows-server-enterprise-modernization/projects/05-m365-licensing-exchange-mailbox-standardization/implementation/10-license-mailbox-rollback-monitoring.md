# License, Mailbox Rollback, and Operational Monitoring

## Purpose

This document records rollback readiness and operational monitoring controls for Project 05 Microsoft 365 licensing and Exchange Online mailbox enablement.

## Pilot Licensing Group

```text
GRP-M365-E5-Pilot-License
```

## Pilot Users

| User | UPN |
|---|---|
| Emma Wilson | emma.wilson@summitridge-mfg.com |
| Olivia Brown | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | sophia.martinez@summitridge-mfg.com |

## Current State

The pilot users are:

- Synchronized from on-premises Active Directory
- Licensed through a dedicated Microsoft 365 pilot licensing group
- Mailbox-enabled in Exchange Online
- Standardized with primary SMTP addresses using summitridge-mfg.com

## Rollback Scope

Rollback planning covers:

- Removing users from the pilot licensing group
- Restoring users to the pilot licensing group
- Monitoring license assignment state
- Monitoring mailbox state
- Documenting mailbox/license impact before any rollback action

## Important Rollback Warning

License rollback can affect Exchange Online mailbox access.

The project does not delete cloud users or mailboxes during rollback planning.

Removing an Exchange Online-capable license must be handled carefully because mailbox availability and retention behavior can be affected.

## Recommended Rollback Order

1. Confirm the issue.
2. Export current license and mailbox state.
3. Remove only the affected user from the pilot licensing group if needed.
4. Wait for license assignment state to update.
5. Validate mailbox state.
6. Restore the user to the pilot licensing group if rollback was temporary.
7. Document the final state.

## Rollback Helper Scripts

| Script | Purpose |
|---|---|
| remove-pilot-users-from-license-group.ps1 | Removes pilot users from the license group |
| restore-pilot-users-to-license-group.ps1 | Restores pilot users to the license group |
| monitor-pilot-license-state.ps1 | Checks current pilot license state |
| monitor-pilot-mailbox-state.ps1 | Checks current pilot mailbox state |

## Monitoring Areas

Operational monitoring includes:

- Pilot licensing group membership
- Pilot user assigned license count
- Microsoft 365 service plan status
- Exchange Online mailbox existence
- Primary SMTP address state
- Mailbox statistics
- Message trace readiness

## Healthy State

Expected healthy state:

```text
Only three pilot users are in GRP-M365-E5-Pilot-License.
Pilot users are licensed.
Exchange service plans are provisioned.
Pilot users have UserMailbox recipient type.
Primary SMTP addresses use summitridge-mfg.com.
Mailbox statistics are available.
```

## Safety Decisions

This batch did not:

- Remove any licenses
- Delete any mailboxes
- Remove any cloud users
- Change primary SMTP addresses
- Modify DNS records
- Create broad licensing changes

## Business Risk

Without rollback and monitoring controls, licensing or mailbox issues could cause:

- Service access disruption
- Mailbox access loss
- Incorrect license removal
- Helpdesk escalation
- User confusion
- Delayed recovery

## Risk Treatment

The project reduces risk by documenting rollback steps, exporting current state, creating helper scripts, and validating operational monitoring points.

## Business Value

Rollback readiness and monitoring controls make the Microsoft 365 pilot safer to operate before expanding licensing and mailbox enablement to additional users.
