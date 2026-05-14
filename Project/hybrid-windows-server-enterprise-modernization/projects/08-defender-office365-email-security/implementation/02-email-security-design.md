# Email Security Design

## Purpose

This document defines the Microsoft Defender for Office 365 and Exchange Online Protection design for Project 08.

## Security Goal

The goal is to create a practical email security baseline for Summit Ridge Manufacturing Group.

The baseline focuses on:

- Anti-phishing protection
- Anti-spam protection
- Anti-malware protection
- Safe Links
- Safe Attachments
- Quarantine handling
- Threat submissions
- Alert review
- Mail flow validation
- Privacy-safe evidence collection

## Current Environment

| Area | Value |
|---|---|
| Microsoft 365 tenant | democompany1016.onmicrosoft.com |
| Verified public domain | summitridge-mfg.com |
| Identity source | On-prem AD synced through Microsoft Entra Cloud Sync |
| Pilot mailboxes | Emma Wilson, Olivia Brown, Sophia Martinez |
| Conditional Access baseline | Implemented in Project 06 |
| Privileged access governance | Implemented in Project 07 |

## Pilot Users

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Email Security Scope

| Security Area | Target Design |
|---|---|
| Anti-phishing | Protect pilot users from impersonation and spoofing |
| Anti-spam | Review inbound spam filtering behavior |
| Anti-malware | Review malware filtering and attachment handling |
| Safe Links | Enable time-of-click URL protection for pilot users |
| Safe Attachments | Enable attachment detonation for pilot users |
| Quarantine | Document review and release workflow |
| Threat submissions | Document suspicious message submission process |
| Alerts | Review Defender alert workflow |
| Mail flow | Validate expected inbound and internal mail behavior |

## Policy Scope Design

The lab will use pilot scope first.

| Policy Type | Scope |
|---|---|
| Anti-phishing | Pilot users |
| Safe Links | Pilot users |
| Safe Attachments | Pilot users |
| Quarantine workflow | Pilot users and admin review |
| Threat submission workflow | Admin review only |
| Tenant-wide policy changes | Avoided unless documented and low risk |

## Defender Portal Areas

Primary portal locations:

```text
Microsoft Defender portal
→ Email & collaboration
→ Policies & rules
→ Threat policies
```

Review areas:

```text
Anti-phishing
Anti-spam
Anti-malware
Safe Links
Safe Attachments
Quarantine policies
Submissions
Alerts
Explorer / Real-time detections
```

## Safe Links Design

Safe Links will be designed to:

- Protect pilot users
- Check links at time of click
- Track malicious URL behavior where available
- Avoid broad tenant-wide enforcement before validation
- Preserve normal mail flow for lab users

## Safe Attachments Design

Safe Attachments will be designed to:

- Protect pilot users
- Detonate attachments in a safe environment
- Block or replace malicious attachments depending on policy
- Avoid testing with real malware
- Use safe validation messages only

## Anti-Phishing Design

Anti-phishing configuration will focus on:

- User impersonation protection
- Domain impersonation protection
- Mailbox intelligence where available
- Spoof intelligence review
- Policy scope limited to pilot users

## Anti-Spam and Anti-Malware Design

Exchange Online Protection controls will be reviewed for:

- Spam filtering
- High-confidence spam behavior
- Malware filtering
- Common attachment filter settings
- Quarantine behavior
- Admin notification behavior

## Quarantine Workflow

The project will document:

- How quarantined messages are reviewed
- Which messages require admin review
- Which messages should not be released
- How lab evidence is captured
- How to avoid exposing sensitive message data

## Threat Submission Workflow

The project will document:

- How suspicious messages are submitted
- How admin submissions are reviewed
- How false positives and false negatives are handled
- How evidence is captured without exposing sensitive data

## Privacy-Safe Evidence Rule

Do not export:

```text
IpAddress
Location
City
State
CountryOrRegion
```

Screenshots must be cropped or blurred if they show:

- Public IP address
- Location
- Message headers containing routing details
- Personal mailbox content
- Message body content
- Session metadata
- Device details

## Safety Decisions

This project will not:

- Send real phishing campaigns
- Upload real malware
- Publish public IP address evidence
- Publish location evidence
- Expose private email body content
- Remove emergency access
- Depend on Intune
- Require compliant devices
- Enforce tenant-wide policies before validation

## Business Value

This design creates a practical Microsoft 365 email security baseline that improves protection against phishing, spoofing, spam, malicious links, malicious attachments, and suspicious mail activity.

It also demonstrates security operations skills across Defender for Office 365, Exchange Online Protection, quarantine handling, threat submissions, alert review, and evidence-based validation.
