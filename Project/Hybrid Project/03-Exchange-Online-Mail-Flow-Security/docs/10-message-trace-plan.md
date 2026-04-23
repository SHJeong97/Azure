# Message Trace Plan

## Goal
Use message trace and quarantine review to prove whether each test message was delivered, rejected, or quarantined.

## Validation Points
- External tag rule delivery
- Shared mailbox disclaimer delivery
- Executable attachment reject event
- Shared mailbox quarantine event
- Any anti-phishing or anti-spam enforcement event visible in trace or quarantine

## Evidence Sources
- Exchange admin center message trace
- Microsoft Defender quarantine
- Test mailbox screenshots
- Rejection / NDR screenshot if available
