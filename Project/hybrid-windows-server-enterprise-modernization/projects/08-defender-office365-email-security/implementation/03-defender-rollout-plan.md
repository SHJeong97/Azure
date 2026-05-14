# Defender Rollout Plan

## Purpose

This document defines the rollout plan for the Microsoft Defender for Office 365 email security baseline.

## Rollout Strategy

The project will use a pilot-first rollout.

The first goal is to review the current Exchange Online Protection and Defender for Office 365 state before enforcing new security policies broadly.

## Rollout Phases

| Phase | Action | Purpose |
|---|---|---|
| Phase 1 | Review tenant readiness | Confirm licensing, mailboxes, accepted domains, and admin access |
| Phase 2 | Review EOP baseline | Export anti-spam, anti-malware, and mail flow baseline |
| Phase 3 | Configure anti-phishing controls | Protect pilot users against impersonation and spoofing |
| Phase 4 | Configure Safe Links | Provide time-of-click URL protection |
| Phase 5 | Configure Safe Attachments | Detonate attachments safely for pilot users |
| Phase 6 | Document quarantine workflow | Review suspicious messages safely |
| Phase 7 | Review alerts and submissions | Validate Defender investigation workflow |
| Phase 8 | Validate mail flow | Confirm expected pilot user mail behavior |
| Phase 9 | Create rollback controls | Document policy rollback and monitoring |

## Initial Pilot Scope

| Scope Area | Target |
|---|---|
| Pilot users | Emma Wilson, Olivia Brown, Sophia Martinez |
| Pilot domain | summitridge-mfg.com |
| Admin reviewer | srmgadmin@democompany1016.onmicrosoft.com |
| Mailboxes | Exchange Online pilot mailboxes |
| Policy rollout | Pilot users first |

## Target Pilot Users

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Defender Policy Areas

| Policy Area | Rollout Intent |
|---|---|
| Anti-phishing | Protect pilot users from impersonation and spoofing |
| Anti-spam | Review spam and high-confidence spam actions |
| Anti-malware | Review malware handling and attachment filtering |
| Safe Links | Enable URL protection for pilot users |
| Safe Attachments | Enable attachment detonation for pilot users |
| Quarantine | Document admin review workflow |
| Threat submissions | Document suspicious message submission workflow |
| Alerts | Review Defender alert visibility |

## Validation Strategy

Validation will use:

- Policy export evidence
- Defender portal screenshots
- Safe test messages only
- Quarantine workflow notes
- Alert review notes
- Mail flow validation notes
- Sanitized screenshots and command outputs

## Safety Rules

This rollout will not:

- Send real phishing emails
- Upload real malware
- Expose private email body content
- Export public IP address fields
- Export location fields
- Apply broad tenant-wide changes before pilot validation
- Remove emergency access

## Privacy-Safe Evidence Rule

Do not export:

```text
IpAddress
Location
City
State
CountryOrRegion
```

Screenshots must be cropped or blurred if they show public IP address, message routing headers, mailbox content, location details, device details, or session metadata.

## Success Criteria

The rollout is successful when:

- Defender licensing/readiness is validated
- Current mail security baseline is exported
- Pilot policy scope is documented
- Anti-phishing, Safe Links, and Safe Attachments are configured or documented
- Quarantine workflow is documented
- Alert and submission workflows are reviewed
- Mail flow validation is completed
- Rollback and operational controls are documented
- Final evidence avoids IP/location exposure

## Business Value

A staged Defender for Office 365 rollout reduces email security risk while protecting mail flow stability and preserving privacy-safe evidence.
