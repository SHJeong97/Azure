# Project 08 — Microsoft Defender for Office 365 Email Security Baseline

## Introduction

This project implements a Microsoft Defender for Office 365 email security baseline for **Summit Ridge Manufacturing Group**, a simulated hybrid Microsoft 365 organization using synchronized identities, Exchange Online mailboxes, Conditional Access, and privileged access governance.

The goal of Project 08 was to improve Microsoft 365 email security by reviewing the existing Exchange Online Protection baseline, configuring pilot-scoped Defender for Office 365 controls, documenting quarantine and investigation workflows, validating mail flow, and collecting privacy-safe evidence.

This project builds on the previous portfolio projects:

- **Project 04:** Hybrid identity synchronization from on-premises Active Directory to Microsoft Entra ID
- **Project 05:** Microsoft 365 service activation, Exchange Online mailbox provisioning, and primary SMTP alignment
- **Project 06:** Conditional Access, MFA enforcement, legacy authentication controls, rollback planning, and privacy-safe evidence handling
- **Project 07:** Privileged Identity Management, admin role governance, access review documentation, audit monitoring, and rollback controls

Project 08 extends the environment by adding an email security baseline with Microsoft Defender for Office 365 and Exchange Online Protection.

---

## Objectives

The objectives of this project were to:

- Validate Exchange Online and Defender for Office 365 readiness
- Confirm accepted domains and pilot mailbox readiness
- Export the existing Exchange Online Protection baseline before changes
- Review anti-spam, anti-malware, connection filter, transport rule, and connector settings
- Configure a pilot-scoped anti-phishing policy
- Configure pilot-scoped Safe Links protection
- Configure pilot-scoped Safe Attachments protection
- Review preset security policies without tenant-wide expansion
- Review spoof intelligence and Tenant Allow/Block List posture
- Document quarantine review workflow
- Document threat submission workflow
- Review Defender alerts, incidents, and investigation workflow
- Validate pilot mail flow using safe plain-text internal messages
- Export sanitized message trace evidence using `Get-MessageTraceV2`
- Avoid real phishing, real malware, credential-harvesting URLs, and unsafe test content
- Avoid exporting public IP address, location, headers, routing details, or private message content
- Create a GitHub-ready final documentation package

---

## Full Implementation

Project 08 was completed in seven implementation batches.

| Batch | Focus Area | Result |
|---|---|---|
| Batch 1 | Project scope, folder structure, business scenario, design, rollout plan, risk register, and validation checklist | Completed |
| Batch 2 | Tenant readiness, Exchange Online Protection baseline, Defender policy inventory, connectors, and mail flow baseline | Completed |
| Batch 3 | Anti-phishing pilot policy, anti-spam review, anti-malware review, spoof intelligence, and Tenant Allow/Block List review | Completed |
| Batch 4 | Safe Links, Safe Attachments, and preset security policy review | Completed |
| Batch 5 | Quarantine workflow, threat submissions, alerts, incidents, and investigation workflow | Completed |
| Batch 6 | Safe mail flow validation, sanitized message trace evidence, and Defender monitoring review | Completed |
| Batch 7 | Final validation, final architecture summary, final outcome summary, and README preparation | Completed |

---

## Implementation Walkthrough

### 1. Project Structure and Planning Foundation

The project folder structure was created under:

```text
projects/08-defender-office365-email-security
```

The project included folders for:

```text
implementation/
scripts/powershell/
evidence/screenshots/
evidence/command-outputs/
evidence/validation-notes/
data/
```

The initial planning files included:

- `01-business-scenario.md`
- `02-email-security-design.md`
- `03-defender-rollout-plan.md`
- `04-risk-and-rollback-plan.md`
- `project-08-policy-scope.csv`
- `project-08-risk-register.csv`
- `project-08-validation-checklist.csv`

The project used a pilot-first rollout model to avoid broad tenant-wide impact.

### 2. Tenant Readiness and Exchange Online Baseline

Exchange Online readiness was validated by connecting to Exchange Online PowerShell and exporting tenant, domain, mailbox, and policy state.

The following items were exported:

- Exchange organization configuration
- Accepted domains
- Pilot mailbox readiness
- Pilot mailbox statistics
- Mailbox inventory summary
- Tenant readiness summary

The verified pilot domain was:

```text
summitridge-mfg.com
```

The pilot users were:

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

### 3. Exchange Online Protection Baseline Review

The current Exchange Online Protection baseline was exported before making Defender policy changes.

Reviewed areas included:

- Inbound anti-spam policies
- Inbound anti-spam rules
- Outbound spam policies
- Outbound spam rules
- Anti-malware policies
- Anti-malware rules
- Connection filter policies

Connection filter evidence intentionally excluded IP allow/block lists.

### 4. Defender for Office 365 Policy Inventory

The Defender for Office 365 baseline was exported for:

- Anti-phishing policies
- Anti-phishing rules
- Safe Links policies
- Safe Links rules
- Safe Attachments policies
- Safe Attachments rules
- Transport rules
- Inbound connectors
- Outbound connectors

Connector evidence was sanitized and did not export connector IP allow/block fields.

### 5. Pilot Anti-Phishing Policy

A pilot anti-phishing policy and matching rule were created or confirmed.

| Item | Value |
|---|---|
| Policy name | `P08-Pilot-AntiPhishing` |
| Rule name | `P08-Pilot-AntiPhishing-Rule` |
| Scope | Pilot users only |
| Protected domain | `summitridge-mfg.com` |
| Tenant-wide expansion | No |
| Real phishing sent | No |

The anti-phishing configuration included controls for:

- Targeted user protection
- Targeted domain protection
- Organization domain protection
- Mailbox intelligence
- Mailbox intelligence protection
- Spoof intelligence
- Unauthenticated sender indicators
- Quarantine actions for phishing-related detections

### 6. Anti-Spam, Anti-Malware, and Spoof Intelligence Review

Anti-spam and anti-malware settings were reviewed only. No anti-spam or anti-malware settings were changed.

The project documented:

- Spam actions
- High-confidence spam actions
- Phishing-related spam actions
- Bulk threshold
- Quarantine retention
- Malware action
- File filter state
- Quarantine tag

Spoof intelligence was reviewed from PowerShell and the Microsoft Defender portal. The portal showed no spoofed domain activity during the review window, which was documented as acceptable for a small lab tenant.

Tenant Allow/Block List evidence was limited to summary counts for:

- Sender
- URL
- File hash

Detailed sender, URL, file hash, IP, and sender infrastructure values were not exported for public evidence.

### 7. Pilot Safe Links Policy

A pilot Safe Links policy and matching rule were created or confirmed.

| Item | Value |
|---|---|
| Policy name | `P08-Pilot-SafeLinks` |
| Rule name | `P08-Pilot-SafeLinks-Rule` |
| Scope | Pilot users only |
| Tenant-wide expansion | No |
| Real phishing links used | No |

The Safe Links configuration included:

- Email link protection
- Microsoft Teams link protection
- Office app link protection
- URL scanning
- Click tracking
- Internal sender protection
- Message delivery after scan
- No user click-through for unsafe links

### 8. Pilot Safe Attachments Policy

A pilot Safe Attachments policy and matching rule were created or confirmed.

| Item | Value |
|---|---|
| Policy name | `P08-Pilot-SafeAttachments` |
| Rule name | `P08-Pilot-SafeAttachments-Rule` |
| Scope | Pilot users only |
| Action | Dynamic Delivery |
| Tenant-wide expansion | No |
| Real malware used | No |

The Safe Attachments configuration included:

- Attachment detonation
- Dynamic delivery
- Error handling
- No redirection mailbox
- Pilot-only recipient scope

### 9. Preset Security Policy Review

Preset security policies were reviewed in the Microsoft Defender portal.

| Preset Policy | Decision |
|---|---|
| Built-in protection | Reviewed |
| Standard protection | Reviewed only |
| Strict protection | Reviewed only |

Standard and Strict preset security policies were not enabled tenant-wide. The project used custom pilot policies first to reduce mail-flow risk.

### 10. Quarantine Workflow Documentation

Quarantine was reviewed from:

```text
Microsoft Defender portal
→ Email & collaboration
→ Review
→ Quarantine
```

The quarantine workflow documentation included:

- Quarantine policy baseline
- Sanitized quarantine message review
- Quarantine message summary
- Quarantine portal review
- Quarantine workflow note
- Quarantine readiness summary

No quarantined messages were released or deleted.

No message body, message headers, sender infrastructure, routing details, public IP, or location data were exported.

### 11. Threat Submission Workflow Documentation

Threat submissions were reviewed from:

```text
Microsoft Defender portal
→ Email & collaboration
→ Submissions
```

Reviewed submission areas included:

- Emails
- URLs
- Email attachments
- Files
- User reported messages

No real phishing, real malware, credential-harvesting URL, sensitive file, or private mailbox content was submitted.

### 12. Alert and Investigation Workflow Review

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

The project documented investigation workflows for:

- Defender alerts
- Defender incidents
- Email entity investigation
- URL investigation
- Attachment investigation

No alert remediation was performed.

### 13. Mail Flow Validation

Safe plain-text internal mail flow validation was completed between pilot users.

| Test ID | Sender | Recipient | Subject |
|---|---|---|---|
| P08-MF-001 | emma.wilson@summitridge-mfg.com | olivia.brown@summitridge-mfg.com | P08 Mail Flow Validation Test 001 |
| P08-MF-002 | olivia.brown@summitridge-mfg.com | sophia.martinez@summitridge-mfg.com | P08 Mail Flow Validation Test 002 |
| P08-MF-003 | sophia.martinez@summitridge-mfg.com | emma.wilson@summitridge-mfg.com | P08 Mail Flow Validation Test 003 |

Only safe lab messages were used. No phishing, malware, suspicious attachments, or credential-harvesting URLs were used.

### 14. Sanitized Message Trace Evidence

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

### 15. Final Project Validation

Final validation confirmed:

- Pilot mailbox readiness
- Anti-phishing policy and rule state
- Safe Links policy and rule state
- Safe Attachments policy and rule state
- Sanitized message trace evidence
- Quarantine workflow documentation
- Threat submission workflow documentation
- Alert and investigation workflow documentation
- Final architecture summary
- Final security outcomes summary
- Final privacy-safe evidence handling

---

## Results & Validation

### Final Architecture Summary

| Component | Configuration | Result |
|---|---|---|
| Microsoft 365 tenant | `democompany1016.onmicrosoft.com` | Validated |
| Verified public domain | `summitridge-mfg.com` | Validated |
| Pilot users | Emma Wilson, Olivia Brown, Sophia Martinez | Validated |
| Pilot mailbox readiness | Exchange Online mailboxes | Validated |
| Exchange Online Protection baseline | Anti-spam, anti-malware, connection filter baseline | Validated |
| Anti-phishing policy | `P08-Pilot-AntiPhishing` | Configured |
| Anti-phishing rule | `P08-Pilot-AntiPhishing-Rule` | Configured |
| Safe Links policy | `P08-Pilot-SafeLinks` | Configured |
| Safe Links rule | `P08-Pilot-SafeLinks-Rule` | Configured |
| Safe Attachments policy | `P08-Pilot-SafeAttachments` | Configured |
| Safe Attachments rule | `P08-Pilot-SafeAttachments-Rule` | Configured |
| Preset security policies | Built-in, Standard, Strict | Reviewed only |
| Spoof intelligence | Portal and PowerShell review | Validated |
| Tenant Allow/Block List | Summary counts only | Validated |
| Quarantine workflow | Reviewed and documented | Validated |
| Threat submission workflow | Reviewed and documented | Validated |
| Alert and investigation workflow | Reviewed and documented | Validated |
| Mail flow validation | Safe pilot messages sent and traced | Validated |
| Message trace method | `Get-MessageTraceV2` | Validated |
| Evidence privacy | IP, location, headers, routing details, and private content excluded | Implemented |

### Final Security Outcomes

| Area | Final Outcome | Status |
|---|---|---|
| Pilot users | Protected by pilot-scoped email security policies | Completed |
| Anti-phishing | Pilot anti-phishing baseline configured | Completed |
| Safe Links | Pilot URL protection configured | Completed |
| Safe Attachments | Pilot attachment detonation configured | Completed |
| Anti-spam | EOP baseline reviewed without changes | Completed |
| Anti-malware | EOP baseline reviewed without changes | Completed |
| Spoof intelligence | Reviewed; no spoof activity found in portal | Completed |
| Tenant Allow/Block List | Summary counts documented without sensitive entries | Completed |
| Quarantine | Workflow documented without release or deletion | Completed |
| Threat submissions | Reviewed without submitting real threats | Completed |
| Alerts and incidents | Reviewed without remediation | Completed |
| Mail flow | Safe internal pilot messages sent and traced | Completed |
| Message trace | Sanitized trace exported using `Get-MessageTraceV2` | Completed |
| Preset security policies | Standard and Strict reviewed but not enabled tenant-wide | Completed |
| Evidence privacy | IP, location, headers, routing details, and private content excluded | Completed |

### Final Safety Decisions

Project 08 did **not**:

- Send real phishing messages
- Send real malware
- Submit real threats
- Release quarantined messages
- Delete quarantined messages
- Perform alert remediation
- Enable tenant-wide Standard preset security policy
- Enable tenant-wide Strict preset security policy
- Expand Safe Links tenant-wide
- Expand Safe Attachments tenant-wide
- Export public IP address fields
- Export location fields
- Export message headers
- Export private message body content
- Export sender infrastructure
- Export routing details

---

## Validation Walkthrough

Validation was completed through command outputs, CSV exports, Defender portal review, Exchange admin center review, implementation documents, and sanitized screenshots.

### Key Evidence Files

| Evidence File | Purpose |
|---|---|
| `batch-02-accepted-domains.csv` | Validates accepted domains |
| `batch-02-pilot-mailbox-readiness.csv` | Validates pilot mailbox readiness |
| `batch-02-inbound-anti-spam-policy-baseline.csv` | Captures EOP anti-spam baseline |
| `batch-02-anti-malware-policy-baseline.csv` | Captures EOP anti-malware baseline |
| `batch-02-anti-phishing-policy-baseline.csv` | Captures Defender anti-phishing baseline |
| `batch-03-antiphish-policy-after.csv` | Validates pilot anti-phishing policy |
| `batch-03-antiphish-rule-after.csv` | Validates pilot anti-phishing rule |
| `batch-03-spoof-intelligence-sanitized.csv` | Captures spoof intelligence without sender infrastructure |
| `batch-04-safe-links-policy-after.csv` | Validates pilot Safe Links policy |
| `batch-04-safe-links-rule-after.csv` | Validates pilot Safe Links rule |
| `batch-04-safe-attachments-policy-after.csv` | Validates pilot Safe Attachments policy |
| `batch-04-safe-attachments-rule-after.csv` | Validates pilot Safe Attachments rule |
| `batch-05-quarantine-message-summary.csv` | Summarizes quarantine state |
| `batch-05-threat-submission-workflow-matrix.csv` | Documents submission workflow |
| `batch-05-alert-investigation-workflow-matrix.csv` | Documents investigation workflow |
| `batch-06-pilot-message-trace-sanitized.csv` | Validates mail flow with sanitized trace evidence |
| `project-08-final-pilot-policy-state.csv` | Confirms final policy and rule state |
| `project-08-final-security-outcomes.csv` | Summarizes final security outcomes |

### Key Implementation Documents

| Document | Purpose |
|---|---|
| `01-business-scenario.md` | Defines business problem and target state |
| `02-email-security-design.md` | Defines Defender and EOP design |
| `03-defender-rollout-plan.md` | Defines pilot-first rollout strategy |
| `04-risk-and-rollback-plan.md` | Defines rollback and safety approach |
| `05-tenant-readiness-eop-mail-flow-baseline.md` | Documents tenant readiness and baseline exports |
| `06-antiphishing-eop-protection-baseline.md` | Documents anti-phishing and EOP protection baseline |
| `07-safe-links-safe-attachments-baseline.md` | Documents Safe Links and Safe Attachments |
| `08-quarantine-submission-alert-investigation-workflow.md` | Documents quarantine, submissions, alerts, and investigation workflow |
| `09-mail-flow-validation-monitoring.md` | Documents mail flow validation and Defender monitoring |
| `10-project-08-final-validation-summary.md` | Documents final project validation |

### Screenshot Evidence

Screenshots were captured for:

- Project folder structure
- Lab evidence folders
- Exchange Online connection
- Accepted domains
- Pilot mailbox readiness
- EOP policy baseline exports
- Anti-phishing policy and rule validation
- Spoofed senders portal review
- Safe Links policy and rule validation
- Safe Attachments policy and rule validation
- Preset security policy review
- Quarantine portal review
- Threat submissions portal review
- Defender alerts and incidents review
- Message trace portal review
- Defender Explorer or Real-time detections review
- Final outcome summaries

All screenshots were required to be cropped or blurred if they displayed public IP addresses, location data, message headers, message previews, private mailbox content, routing details, URLs, file hashes, device details, or session metadata.

---

## Key Takeaways

- Microsoft Defender for Office 365 should be rolled out carefully using pilot scope before tenant-wide expansion.
- Anti-phishing policies require both a policy and a matching rule to apply to users.
- Safe Links and Safe Attachments also use a policy-plus-rule model.
- Preset security policies are useful but can have broad tenant-wide impact if enabled without planning.
- Exchange Online Protection baseline exports are important before changing anti-spam or anti-malware behavior.
- Quarantine and threat investigation workflows can expose sensitive email content, so evidence must be sanitized.
- Safe mail flow validation can be performed using plain-text internal test messages without phishing or malware.
- `Get-MessageTraceV2` should be used for message trace evidence instead of older trace commands.
- Public IP, location, headers, routing details, and private message content should not be included in public GitHub evidence.
- This project demonstrates practical Microsoft 365 security administration across Defender for Office 365, Exchange Online Protection, quarantine handling, alert review, and privacy-safe evidence collection.
