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

## Batch 3 Notes
Three Exchange Online mail flow rules were created.

MF01 tagged inbound external mail to internal recipients by prepending [External] to the subject.

MF02 added a warning disclaimer to external messages sent to the HR, Finance, and Operations shared mailboxes.

MF03 blocked inbound executable attachments from external senders.

These rules established a transport-control baseline before deeper anti-spam and anti-phishing tuning.

## Batch 4 Notes
A custom anti-phishing policy was created in Microsoft Defender to protect executive and sensitive shared-mailbox paths against impersonation and phishing.
User impersonation protection, domain protection, mailbox intelligence, and phishing safety tips were enabled for the scoped recipients.
A custom inbound anti-spam policy was created for the HR, Finance, and Operations shared mailboxes.
The default anti-malware policy was retained because it already protects all cloud mailboxes and no custom anti-malware scope was required for this batch.
Preset security policies were intentionally not enabled for the same recipients in this project stage so custom-policy behavior would remain visible and testable.
