# Validation Scenarios

## Scenario 1: External subject tagging
Send a normal external email to Emma Reed.

Expected:
- Delivered successfully
- Subject begins with [External]

## Scenario 2: Shared mailbox disclaimer
Send a normal external email to HR shared mailbox.

Expected:
- Delivered successfully
- External warning disclaimer appears in the message body
- Subject may also contain [External]

## Scenario 3: Executable attachment block
Send an external message with an executable-style attachment to an internal recipient.

Expected:
- Message is rejected or blocked by transport rule
- Sender receives rejection explanation

## Scenario 4: Shared mailbox spam/quarantine path
Send a spam-like external message to a shared mailbox.

Expected:
- Message is quarantined by anti-spam policy

## Scenario 5: Executive impersonation path
Send a lookalike/phish-style message targeting executive-sensitive recipients.

Expected:
- Anti-phishing policy behavior is visible through quarantine, junking, or safety-tip evidence depending on verdict
