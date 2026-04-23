# Architecture Decisions

## Decision 1: Reuse the existing tenant and hybrid identity foundation
Reason:
The company identity platform is already established.

Business outcome:
This project focuses on Exchange administration rather than rebuilding identity.

## Decision 2: Use shared mailboxes for role-based business functions
Reason:
Departments often need persistent mail identities independent of one employee account.

Business outcome:
Improves continuity and reduces dependency on a single user mailbox.

## Decision 3: Start with baseline mail flow and mail hygiene controls before advanced scenarios
Reason:
A company needs basic protection and transport control before deeper tuning.

Business outcome:
Reduces phishing risk and improves operational consistency.

## Decision 4: Validate all changes with test mail flow and trace evidence
Reason:
Email administration without proof is weak portfolio evidence.

Business outcome:
Shows not only configuration skill but operational verification.

## Final Production Gap Notes

This project intentionally focused on a practical Exchange Online and Defender baseline rather than a full enterprise email-security deployment.

The lab demonstrated shared mailbox administration, transport rules, and Defender policy scoping, but some deeper validation paths such as quarantine confirmation and message trace evidence were not fully captured during the run.

Those limitations were documented honestly and do not change the value of the administrative design work demonstrated in the project.
