# Implementation Notes

## Batch 1 Scope
This batch defines the project structure, business scenario, risk model, and Exchange administration target state.

## Existing Foundation Reused
- Microsoft 365 tenant
- Hybrid identity
- Synced users
- Named admin accounts
- Licensing baseline

## New Scope for Project 3
- Exchange Online administration
- Shared mailbox model
- Mail flow control
- Mail hygiene validation

## Batch 2 Notes
Three shared mailboxes were created in Microsoft 365:
- hr@democompany1016.onmicrosoft.com
- finance@democompany1016.onmicrosoft.com
- operations@democompany1016.onmicrosoft.com

Department users were added as members of the appropriate shared mailboxes.
Full Access and Send As permissions were assigned to the same department users.
Shared mailbox Sent Items behavior was enabled so replies remain visible from the shared mailbox context.
Exchange Online PowerShell validation confirmed the shared mailboxes and delegation state.
