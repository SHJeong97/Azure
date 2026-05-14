# Mail Flow Validation and Defender Monitoring

## Purpose

This document records mail flow validation, sanitized message trace evidence, Defender monitoring review, and final pilot policy state validation for Project 08.

## Project Context

Project 08 builds a Microsoft Defender for Office 365 email security baseline for Summit Ridge Manufacturing Group.

Batch 6 validates that safe pilot messages can be sent and traced after the anti-phishing, Safe Links, and Safe Attachments pilot policies were configured.

## Pilot Users

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Safe Mail Flow Validation Tests

The following safe internal mail flow tests were planned:

| Test ID | Sender | Recipient | Subject |
|---|---|---|---|
| P08-MF-001 | emma.wilson@summitridge-mfg.com | olivia.brown@summitridge-mfg.com | P08 Mail Flow Validation Test 001 |
| P08-MF-002 | olivia.brown@summitridge-mfg.com | sophia.martinez@summitridge-mfg.com | P08 Mail Flow Validation Test 002 |
| P08-MF-003 | sophia.martinez@summitridge-mfg.com | emma.wilson@summitridge-mfg.com | P08 Mail Flow Validation Test 003 |

Only safe plain-text lab messages were used.

## Message Trace Evidence

Message trace evidence was exported using:

```text
Get-MessageTraceV2
```

The sanitized message trace export included:

- Received time
- Sender address
- Recipient address
- Delivery status
- Message size
- Message trace ID

The export intentionally excluded:

- Message subject
- Message body
- Message headers
- FromIP
- ToIP
- Routing details
- Public IP address
- Location data

## Pilot Policy State Validation

The following pilot policies and rules were validated:

| Policy Area | Policy | Rule | Scope |
|---|---|---|---|
| Anti-phishing | P08-Pilot-AntiPhishing | P08-Pilot-AntiPhishing-Rule | Pilot users |
| Safe Links | P08-Pilot-SafeLinks | P08-Pilot-SafeLinks-Rule | Pilot users |
| Safe Attachments | P08-Pilot-SafeAttachments | P08-Pilot-SafeAttachments-Rule | Pilot users |

## Defender Monitoring Review

Monitoring was reviewed in:

```text
Exchange admin center
→ Mail flow
→ Message trace
```

And:

```text
Microsoft Defender portal
→ Email & collaboration
→ Explorer
```

Or, if Explorer was unavailable:

```text
Microsoft Defender portal
→ Email & collaboration
→ Real-time detections
```

## Expected Lab Result

Because only safe plain-text messages were used, no real phishing, malware, Safe Links, or Safe Attachments detections were expected.

It is acceptable if Defender Explorer or Real-time detections shows no threat detections.

## Privacy-Safe Evidence Handling

The following data was not exported:

```text
IpAddress
Location
City
State
CountryOrRegion
Message body
Message headers
Routing details
FromIP
ToIP
Private mailbox content
Credential-harvesting URLs
Malware samples
Sensitive attachments
```

Screenshots must be cropped or blurred if they show:

- Public IP address
- Location
- Message body
- Message preview
- Message headers
- Routing details
- URLs
- Sender infrastructure
- Private mailbox content
- Device details
- Session metadata

## Safety Decisions

This batch did not:

- Send real phishing
- Send real malware
- Use credential-harvesting URLs
- Release suspicious messages
- Export message headers
- Export message body content
- Export routing details
- Export public IP address fields
- Export location fields

## Business Risk

Mail security validation can expose sensitive message data if message trace, headers, URLs, routing details, or mailbox screenshots are not sanitized.

Testing with real phishing or malware can create unnecessary tenant risk.

## Risk Treatment

The project reduced risk by using safe plain-text validation messages, exporting sanitized message trace evidence, avoiding message headers, and reviewing Defender monitoring without unsafe content.

## Business Value

This batch validates that pilot mail flow can be reviewed safely after Defender for Office 365 pilot protections are configured.

It demonstrates practical Exchange Online message trace usage, Defender monitoring review, policy validation, and privacy-safe evidence handling.
