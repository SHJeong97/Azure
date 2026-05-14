# Quarantine, Threat Submission, Alerts, and Investigation Workflow

## Purpose

This document records the quarantine review workflow, threat submission workflow, alert review, and investigation workflow for Project 08.

## Project Context

Project 08 builds a Microsoft Defender for Office 365 email security baseline for Summit Ridge Manufacturing Group.

Batch 5 focuses on documenting operational review workflows without releasing quarantined messages, submitting real threats, or exposing sensitive message data.

## Quarantine Review

Quarantine was reviewed from:

```text
Microsoft Defender portal
→ Email & collaboration
→ Review
→ Quarantine
```

## Quarantine Evidence

The following quarantine evidence was collected:

| Evidence | Result |
|---|---|
| Quarantine policy baseline | Exported |
| Sanitized quarantine message review | Exported |
| Quarantine message summary | Created |
| Quarantine portal review | Completed |
| Quarantine workflow note | Created |
| Quarantine readiness summary | Created |

## Quarantine Safety Decisions

This batch did not:

- Release quarantined messages
- Delete quarantined messages
- Export message body content
- Export message headers
- Export sender infrastructure
- Export message routing details
- Export public IP address fields
- Export location fields

## Expected Quarantine Result

It is acceptable if no quarantined messages exist in the lab tenant.

Small lab tenants often have limited quarantine activity unless test messages or external malicious traffic are present.

## Threat Submission Workflow

Threat submissions were reviewed from:

```text
Microsoft Defender portal
→ Email & collaboration
→ Submissions
```

Reviewed submission areas:

| Submission Area | Lab Action |
|---|---|
| Emails | Review only |
| URLs | Review only |
| Email attachments | Review only |
| Files | Review only |
| User reported messages | Review only |

## Threat Submission Safety Decisions

This batch did not:

- Submit real phishing messages
- Submit real malware
- Submit credential-harvesting URLs
- Upload sensitive files
- Export private mailbox content
- Export message headers
- Export public IP or location fields

## Alerts and Incidents Review

Alerts and incidents were reviewed from:

```text
Microsoft Defender portal
→ Incidents & alerts
→ Alerts
```

And:

```text
Microsoft Defender portal
→ Incidents & alerts
→ Incidents
```

The review focused on email-related security activity such as:

- Phishing alerts
- Malware alerts
- Safe Links events
- Safe Attachments events
- User submissions
- Quarantine-related activity
- Email investigation workflow

## Expected Alert Result

It is acceptable if no active Defender alerts or incidents exist in the lab tenant.

Small lab tenants often have limited alert activity unless real security signals are generated.

## Investigation Workflow

The investigation workflow was documented for:

| Workflow Area | Purpose |
|---|---|
| Defender alerts | Review email security alerts |
| Defender incidents | Review grouped security events |
| Email entity investigation | Review message timeline and verdict |
| URL investigation | Review Safe Links and URL verdict context |
| Attachment investigation | Review Safe Attachments verdict and handling |

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
Sender infrastructure
Message routing details
Private mailbox content
Credential-harvesting URLs
Malware samples
Sensitive attachments
```

Screenshots must be cropped or blurred if they show:

- Sender address
- Recipient address
- Subject
- Message preview
- Message ID
- URL
- File hash
- Message header
- Routing detail
- Public IP address
- Location
- Private mailbox content
- Device details
- Session metadata

## Safety Decisions

This batch did not:

- Release quarantined messages
- Delete quarantined messages
- Submit real phishing
- Submit real malware
- Upload sensitive files
- Perform alert remediation
- Export private message content
- Export public IP address fields
- Export location fields

## Business Risk

Quarantine and investigation workflows can expose sensitive email data if evidence is not sanitized.

Incorrect quarantine release decisions can also deliver malicious messages to users.

Submitting real phishing or malware can create unnecessary security risk in the tenant.

## Risk Treatment

The project reduced risk by reviewing workflows only, avoiding real malicious content, not releasing or deleting quarantined messages, and sanitizing all evidence.

## Business Value

This batch demonstrates Microsoft Defender for Office 365 operational review skills.

It shows how to document quarantine handling, threat submission workflow, alert review, investigation workflow, and privacy-safe evidence collection without introducing unsafe test content.
