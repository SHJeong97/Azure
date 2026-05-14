
# Anti-Phishing and EOP Protection Baseline

## Purpose

This document records the anti-phishing configuration, anti-spam review, anti-malware review, spoof intelligence review, and Tenant Allow/Block List review for Project 08.

## Project Context

Project 08 builds a Microsoft Defender for Office 365 email security baseline for Summit Ridge Manufacturing Group.

Batch 3 focuses on configuring a pilot anti-phishing policy and reviewing Exchange Online Protection controls without using real phishing emails or malware.

## Pilot Users

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Anti-Phishing Policy

| Item | Value |
|---|---|
| Policy name | P08-Pilot-AntiPhishing |
| Rule name | P08-Pilot-AntiPhishing-Rule |
| Scope | Pilot users only |
| Protected domain | summitridge-mfg.com |
| Tenant-wide expansion | No |
| Real phishing sent | No |

## Anti-Phishing Controls

The pilot anti-phishing policy was configured or confirmed with controls for:

- Targeted user protection
- Targeted domain protection
- Organization domain protection
- Mailbox intelligence
- Mailbox intelligence protection
- Spoof intelligence
- Unauthenticated sender indicators
- Quarantine actions for phishing-related detections

## Anti-Spam Review

Anti-spam settings were reviewed only.

No anti-spam policy settings were changed in this batch.

The review documented:

- Spam action
- High-confidence spam action
- Phish spam action
- High-confidence phish action
- Bulk spam action
- Bulk threshold
- Quarantine retention period
- End-user spam notification settings

## Anti-Malware Review

Anti-malware settings were reviewed only.

No anti-malware policy settings were changed in this batch.

The review documented:

- Malware action
- Common attachment/file filter state
- File type configuration
- Notification configuration
- Quarantine tag

## Spoof Intelligence Review

Spoof intelligence was reviewed in both PowerShell and the Microsoft Defender portal.

The Defender portal showed:

| Item | Result |
|---|---|
| Spoofed domains over past 7 days | 0 |
| Spoofed sender entries | No data available |
| Action required | No |

This result is acceptable for a small lab tenant because there may be little or no real inbound spoofing activity.

## Tenant Allow/Block List Review

Tenant Allow/Block List summary was exported for:

- Sender
- URL
- File hash

Detailed sender, URL, file hash, and IP entries were not exported for public evidence.

## Privacy-Safe Evidence Handling

The following fields and values were intentionally excluded:

- IpAddress
- Location
- City
- State
- CountryOrRegion
- SendingInfrastructure
- Tenant Allow/Block List IP entries
- Detailed URL values
- Detailed file hash values
- Private sender infrastructure

Screenshots must be cropped or blurred if they show public IP address, message routing details, sender infrastructure, private sender information, or mailbox content.

## Safety Decisions

This batch did not:

- Send real phishing emails
- Use real malware
- Change anti-spam policies
- Change anti-malware policies
- Expand anti-phishing protection tenant-wide
- Export source IP or location fields
- Export spoof sending infrastructure
- Export Tenant Allow/Block List IP entries

## Business Risk

Email security controls can disrupt legitimate mail if they are configured too aggressively or applied tenant-wide without validation.

Anti-phishing, anti-spam, and anti-malware controls must be tested carefully using pilot scope and safe evidence.

## Risk Treatment

The project reduced risk by using a pilot anti-phishing policy, reviewing anti-spam and anti-malware settings without changing them, avoiding real phishing and malware, and sanitizing spoof intelligence evidence.

## Business Value

This batch demonstrates practical Microsoft Defender for Office 365 and Exchange Online Protection administration.

It establishes anti-phishing protection for pilot users while safely documenting anti-spam, anti-malware, spoof intelligence, and Tenant Allow/Block List posture.
