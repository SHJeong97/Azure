# Tenant Readiness, EOP Baseline, and Mail Flow Inventory

## Purpose

This document records tenant readiness, Exchange Online readiness, Exchange Online Protection baseline export, Defender for Office 365 policy inventory, and mail flow baseline evidence for Project 08.

## Project Context

Project 08 builds an email security baseline for Summit Ridge Manufacturing Group using Microsoft Defender for Office 365 and Exchange Online Protection.

This batch validates the current mail security state before changing Defender or Exchange Online Protection policies.

## Tenant and Mail Readiness

The following readiness checks were completed:

| Area | Result |
|---|---|
| Exchange Online connection | Validated |
| Exchange organization configuration | Exported |
| Accepted domains | Exported |
| Pilot mailbox readiness | Exported |
| Pilot mailbox statistics | Exported |
| Mailbox inventory summary | Exported |
| Tenant readiness summary | Created |

## Verified Domain

| Domain | Purpose |
|---|---|
| summitridge-mfg.com | Pilot user primary SMTP domain |
| democompany1016.onmicrosoft.com | Microsoft 365 tenant domain |

## Pilot Mailboxes

| User | UPN |
|---|---|
| Emma Wilson | emma.wilson@summitridge-mfg.com |
| Olivia Brown | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | sophia.martinez@summitridge-mfg.com |

## Exchange Online Protection Baseline

The following EOP baseline areas were exported:

| Policy Area | Evidence |
|---|---|
| Inbound anti-spam policies | Exported |
| Inbound anti-spam rules | Exported |
| Outbound spam policies | Exported |
| Outbound spam rules | Exported |
| Anti-malware policies | Exported |
| Anti-malware rules | Exported |
| Connection filter policies | Exported without IP allow/block lists |

## Defender for Office 365 Policy Inventory

The following Defender policy areas were exported:

| Policy Area | Evidence |
|---|---|
| Anti-phishing policies | Exported |
| Anti-phishing rules | Exported |
| Safe Links policies | Exported |
| Safe Links rules | Exported |
| Safe Attachments policies | Exported |
| Safe Attachments rules | Exported |

## Mail Flow Inventory

The following mail flow areas were exported:

| Area | Evidence |
|---|---|
| Transport rules | Exported |
| Inbound connectors | Exported without IP fields |
| Outbound connectors | Exported without IP fields |
| Mail flow baseline note | Created |

## Privacy-Safe Evidence Handling

The following fields were intentionally excluded:

- IpAddress
- Location
- City
- State
- CountryOrRegion
- SenderIPAddresses
- IPAddresses
- IPAllowList
- IPBlockList

Screenshots must be cropped or blurred if they show public IP address, message routing headers, mailbox content, connector IP details, device details, or session metadata.

## Batch 2 Safety Decisions

This batch did not:

- Change mail security policies
- Create Defender policies
- Modify anti-spam settings
- Modify anti-malware settings
- Modify anti-phishing settings
- Modify Safe Links settings
- Modify Safe Attachments settings
- Send phishing simulations
- Use real malware
- Perform quarantine actions
- Export public IP or location fields

## Business Risk

Changing email security policies without first capturing the current baseline can disrupt mail flow, block legitimate messages, quarantine business email, or create inaccurate portfolio documentation.

## Risk Treatment

The project reduced risk by exporting the current Exchange Online, EOP, Defender, connector, and mail flow state before policy changes.

## Business Value

This batch establishes the baseline needed before configuring Defender for Office 365 protections.

It proves that the tenant, accepted domain, pilot mailboxes, EOP policies, Defender policies, transport rules, and connectors were reviewed before implementing new email security controls.
