# Risk and Rollback Plan

## Purpose

This document defines risks and rollback planning for Microsoft 365 license assignment, Exchange Online mailbox provisioning, and email address standardization.

## Key Risks

| Risk | Impact | Treatment |
|---|---|---|
| License assigned to wrong users | Unexpected service access or cost | Use pilot group only |
| UsageLocation missing | License assignment fails | Validate UsageLocation before licensing |
| Wrong SKU selected | Incorrect services enabled | Export tenant SKUs before assignment |
| Mailbox does not provision | User cannot use Exchange Online | Validate mailbox after licensing |
| Primary SMTP mismatch | User confusion or sender inconsistency | Standardize after mailbox exists |
| Duplicate proxy address | Address assignment failure | Validate existing recipients before change |
| MX already routes to Microsoft 365 | Inbound mail may arrive before readiness | Validate mailbox and mail flow state |
| Broad license assignment | Cost and service impact | Start with three pilot users only |
| License removed incorrectly | Mailbox/service disruption | Document rollback before removal |

## Pilot Users

| User | UPN |
|---|---|
| Emma Wilson | emma.wilson@summitridge-mfg.com |
| Olivia Brown | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | sophia.martinez@summitridge-mfg.com |

## Rollback Principles

Rollback must be controlled and documented.

The first rollback action depends on the issue.

| Issue | First Response |
|---|---|
| Wrong users licensed | Remove users from licensing group or remove assigned license |
| Mailbox provisioning issue | Review license and Exchange service plan |
| Wrong primary SMTP | Revert primary SMTP to prior value |
| Duplicate alias conflict | Remove or correct conflicting proxy address |
| Mail flow issue | Validate MX, accepted domain, mailbox, and recipient state |

## License Rollback

If licensing causes issues, the project should:

1. Identify affected pilot user.
2. Confirm assigned SKU.
3. Remove the pilot user from the licensing group or remove direct license.
4. Validate AssignedLicenses count.
5. Document the rollback result.
6. Do not delete the cloud user.

## Mailbox Rollback

Mailbox rollback requires caution.

Removing an Exchange Online license can affect mailbox availability and retention behavior.

Do not remove licenses casually after mailbox creation without documenting the expected mailbox state.

## Email Address Rollback

Before changing primary SMTP addresses, export:

- PrimarySmtpAddress
- EmailAddresses
- RecipientTypeDetails
- UserPrincipalName

If needed, revert the primary SMTP address using Exchange Online PowerShell after confirming the previous value.

## Business Risk

Poor rollback planning can extend outage time, increase helpdesk tickets, and create confusion for users.

## Risk Treatment

This project prepares rollback notes before making license, mailbox, or SMTP changes.

## Business Value

A documented rollback plan allows IT to activate Microsoft 365 services while maintaining a controlled recovery path.
