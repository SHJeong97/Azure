# Project 3 Batch 3 Mail Flow Results

## Rule 1
Name:
- MF01-Tag-External-Inbound-Mail

Expected:
- External inbound messages to internal recipients receive [External] in the subject

## Rule 2
Name:
- MF02-Warn-External-Mail-To-Shared-Mailboxes

Expected:
- External messages to hr, finance, and operations shared mailboxes receive a visible warning disclaimer

## Rule 3
Name:
- MF03-Block-Inbound-Executable-Attachments

Expected:
- Messages from external senders with executable attachments are blocked

## Validation Notes
- Rule order reviewed
- Enabled state reviewed
- Message trace will be used in a later batch for deeper verification
