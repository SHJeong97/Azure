# Project 08 Final Validation Summary

## Purpose

This document records the final validation result for Project 08: Microsoft Defender for Office 365 Email Security Baseline.

## Project Context

Project 08 builds on the previous identity, Microsoft 365, Conditional Access, and privileged access governance projects.

Project 04 synchronized selected on-premises Active Directory users into Microsoft Entra ID.

Project 05 activated Microsoft 365 services by assigning licenses, provisioning Exchange Online mailboxes, and standardizing primary SMTP addresses.

Project 06 implemented Conditional Access, MFA enforcement, legacy authentication control, break-glass exclusions, rollback planning, and privacy-safe sign-in evidence.

Project 07 implemented privileged access governance using Microsoft Entra PIM, admin role inventory, eligible role assignments, activation testing, manual access review evidence, audit monitoring, rollback controls, and operational runbooks.

Project 08 adds Microsoft Defender for Office 365 email security controls, Exchange Online Protection baseline review, Safe Links, Safe Attachments, quarantine workflow, threat submissions, alert review, mail flow validation, and sanitized message trace evidence.

## Environment

| Area | Value |
|---|---|
| Microsoft 365 tenant | democompany1016.onmicrosoft.com |
| Verified public domain | summitridge-mfg.com |
| Identity source | On-premises AD synced through Microsoft Entra Cloud Sync |
| Mail platform | Exchange Online |
| Email security platform | Microsoft Defender for Office 365 and Exchange Online Protection |
| Pilot users | Emma Wilson, Olivia Brown, Sophia Martinez |
| Intune dependency | None |
| Compliant-device requirement | None |

## Pilot Users

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Email Security Scope

The project reviewed or configured the following email security areas:

| Area | Final Result |
|---|---|
| Exchange Online tenant readiness | Validated |
| Accepted domains | Validated |
| Pilot mailboxes | Validated |
| EOP anti-spam baseline | Reviewed |
| EOP anti-malware baseline | Reviewed |
| Connection filter baseline | Reviewed without IP lists |
| Anti-phishing policy | Configured for pilot users |
| Safe Links policy | Configured for pilot users |
| Safe Attachments policy | Configured for pilot users |
| Preset security policies | Reviewed only |
| Spoof intelligence | Reviewed |
| Tenant Allow/Block List | Summary counts documented |
| Quarantine workflow | Reviewed and documented |
| Threat submission workflow | Reviewed and documented |
| Alerts and incidents | Reviewed and documented |
| Mail flow validation | Completed with safe messages |
| Message trace | Exported with sanitized fields |

## Configured Pilot Policies

| Policy Area | Policy | Rule | Scope |
|---|---|---|---|
| Anti-phishing | P08-Pilot-AntiPhishing | P08-Pilot-AntiPhishing-Rule | Pilot users only |
| Safe Links | P08-Pilot-SafeLinks | P08-Pilot-SafeLinks-Rule | Pilot users only |
| Safe Attachments | P08-Pilot-SafeAttachments | P08-Pilot-SafeAttachments-Rule | Pilot users only |

## Pilot-Scoped Deployment Decision

The project used pilot-scoped custom policies instead of tenant-wide preset expansion.

This reduced risk by limiting policy impact to Emma Wilson, Olivia Brown, and Sophia Martinez while validating Defender for Office 365 controls.

No tenant-wide Standard or Strict preset security policy expansion was performed.

## Exchange Online Protection Baseline

The following Exchange Online Protection baseline areas were reviewed and documented:

| Area | Result |
|---|---|
| Inbound anti-spam policy | Reviewed |
| Inbound anti-spam rules | Reviewed |
| Outbound spam policy | Reviewed |
| Outbound spam rules | Reviewed |
| Anti-malware policy | Reviewed |
| Anti-malware rules | Reviewed |
| Connection filter policy | Reviewed without IP allow/block lists |

No anti-spam or anti-malware settings were changed during the baseline review.

## Anti-Phishing Result

A pilot anti-phishing policy was created or confirmed.

| Item | Result |
|---|---|
| Policy | P08-Pilot-AntiPhishing |
| Rule | P08-Pilot-AntiPhishing-Rule |
| Scope | Pilot users only |
| Protected domain | summitridge-mfg.com |
| Real phishing sent | No |
| Tenant-wide expansion | No |

The policy includes user impersonation protection, domain impersonation protection, organization domain protection, mailbox intelligence, spoof intelligence, and quarantine actions for phishing-related detections.

## Safe Links Result

A pilot Safe Links policy was created or confirmed.

| Item | Result |
|---|---|
| Policy | P08-Pilot-SafeLinks |
| Rule | P08-Pilot-SafeLinks-Rule |
| Scope | Pilot users only |
| Real phishing links used | No |
| Tenant-wide expansion | No |

The policy validates URL protection configuration without using real phishing links.

## Safe Attachments Result

A pilot Safe Attachments policy was created or confirmed.

| Item | Result |
|---|---|
| Policy | P08-Pilot-SafeAttachments |
| Rule | P08-Pilot-SafeAttachments-Rule |
| Scope | Pilot users only |
| Action | Dynamic Delivery |
| Real malware used | No |
| Tenant-wide expansion | No |

The policy validates attachment detonation configuration without uploading or sending real malware.

## Spoof Intelligence and Tenant Allow/Block List

Spoof intelligence was reviewed in PowerShell and the Microsoft Defender portal.

The portal showed no spoofed domain activity during the review window.

Tenant Allow/Block List summary counts were documented for:

- Sender
- URL
- File hash

Detailed sender values, URL values, file hash values, sending infrastructure, and IP entries were not exported.

## Quarantine Workflow

Quarantine was reviewed from:

```text
Microsoft Defender portal
→ Email & collaboration
→ Review
→ Quarantine
```

The workflow was documented safely.

No quarantined messages were released.

No quarantined messages were deleted.

No message body, message headers, sender infrastructure, routing details, public IP, or location fields were exported.

## Threat Submission Workflow

Threat submissions were reviewed from:

```text
Microsoft Defender portal
→ Email & collaboration
→ Submissions
```

Reviewed areas included:

- Emails
- URLs
- Email attachments
- Files
- User reported messages

No real phishing, real malware, credential-harvesting URL, or sensitive file was submitted.

## Alert and Investigation Workflow

Defender alerts and incidents were reviewed from:

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

The lab documented the investigation workflow for email, URL, and attachment-related detections.

No alert remediation was performed.

## Mail Flow Validation

Safe internal mail flow validation was completed between pilot users.

| Test ID | Sender | Recipient |
|---|---|---|
| P08-MF-001 | emma.wilson@summitridge-mfg.com | olivia.brown@summitridge-mfg.com |
| P08-MF-002 | olivia.brown@summitridge-mfg.com | sophia.martinez@summitridge-mfg.com |
| P08-MF-003 | sophia.martinez@summitridge-mfg.com | emma.wilson@summitridge-mfg.com |

Only safe plain-text lab messages were used.

## Message Trace Validation

Message trace evidence was exported using:

```text
Get-MessageTraceV2
```

The sanitized export included:

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

## Privacy-Safe Evidence Handling

The following data was intentionally excluded from Project 08 public evidence:

```text
IpAddress
Location
City
State
CountryOrRegion
FromIP
ToIP
Message headers
Message body
Routing details
Sender infrastructure
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
- Sender infrastructure
- URLs
- File hashes
- Message IDs
- Private mailbox content
- Device details
- Session metadata

## Safety Decisions

Project 08 did not:

- Send real phishing
- Send real malware
- Submit real threats
- Release quarantined messages
- Delete quarantined messages
- Perform alert remediation
- Enable tenant-wide Standard preset security policy
- Enable tenant-wide Strict preset security policy
- Export public IP address fields
- Export location fields
- Export message headers
- Export private message body content

## Final Technical Result

Project 08 successfully created a pilot-scoped Microsoft Defender for Office 365 email security baseline.

The final state includes:

- Exchange Online readiness validation
- Accepted domain validation
- Pilot mailbox validation
- EOP anti-spam and anti-malware baseline review
- Anti-phishing pilot policy
- Safe Links pilot policy
- Safe Attachments pilot policy
- Preset security policy review
- Spoof intelligence review
- Tenant Allow/Block List summary
- Quarantine workflow documentation
- Threat submission workflow documentation
- Alert and incident workflow documentation
- Safe mail flow validation
- Sanitized message trace evidence using Get-MessageTraceV2
- Privacy-safe evidence handling

## Business Value

Project 08 demonstrates practical Microsoft Defender for Office 365 and Exchange Online Protection administration.

It shows how to deploy email security controls safely using pilot scope, validate mail flow, review operational workflows, and collect sanitized evidence without exposing sensitive message data, public IP addresses, or location details.

This project supports real-world Microsoft 365 Administrator, Security Administrator, Messaging Administrator, IAM, and cloud security responsibilities.
