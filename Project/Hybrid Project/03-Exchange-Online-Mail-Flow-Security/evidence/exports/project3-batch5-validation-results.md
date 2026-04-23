# Project 3 Batch 5 Validation Results

## Test A
Subject:
- Project3 Test A External Subject Tag

Expected:
- Delivered
- [External] subject tag visible

Observed:
- [Fill in actual result]

## Test B
Subject:
- Project3 Test B Shared Mailbox Warning

Expected:
- Delivered
- Disclaimer visible in HR shared mailbox

Observed:
- [Fill in actual result]

## Test C
Subject:
- Project3 Test C Executable Attachment Block

Expected:
- Rejected or blocked

Observed:
- [Fill in actual result]

## Test D
Subject:
- Project3 Test D Spamlike Mail To Finance

Expected:
- Quarantined or otherwise filtered by anti-spam path

Observed:
- Delivered to Finance Shared
- [External] subject tag applied
- Shared mailbox external warning disclaimer applied
- Message was not quarantined

Interpretation:
- Mail flow transport controls worked
- The custom anti-spam policy did not classify this message strongly enough to quarantine it

## Evidence Sources
- Exchange message trace
- Defender quarantine
- mailbox screenshots
- sender-side rejection screenshot if applicable
