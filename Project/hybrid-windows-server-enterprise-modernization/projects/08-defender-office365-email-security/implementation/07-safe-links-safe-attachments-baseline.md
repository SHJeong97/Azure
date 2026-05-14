# Safe Links and Safe Attachments Baseline

## Purpose

This document records the pilot Safe Links, Safe Attachments, and preset security policy review for Project 08.

## Project Context

Project 08 builds a Microsoft Defender for Office 365 email security baseline for Summit Ridge Manufacturing Group.

Batch 4 focuses on configuring pilot-scoped Safe Links and Safe Attachments policies without expanding protection tenant-wide.

## Pilot Users

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Safe Links Configuration

| Item | Value |
|---|---|
| Policy name | P08-Pilot-SafeLinks |
| Rule name | P08-Pilot-SafeLinks-Rule |
| Scope | Pilot users only |
| Tenant-wide expansion | No |
| Real phishing links used | No |

## Safe Links Controls

The pilot Safe Links policy was configured or confirmed with controls for:

- Email link protection
- Microsoft Teams link protection
- Office app link protection
- URL scanning
- Click tracking
- Internal sender protection
- Message delivery after scan
- No user click-through for unsafe links

## Safe Attachments Configuration

| Item | Value |
|---|---|
| Policy name | P08-Pilot-SafeAttachments |
| Rule name | P08-Pilot-SafeAttachments-Rule |
| Scope | Pilot users only |
| Action | Dynamic Delivery |
| Tenant-wide expansion | No |
| Real malware used | No |

## Safe Attachments Controls

The pilot Safe Attachments policy was configured or confirmed with controls for:

- Attachment detonation
- Dynamic delivery
- Error handling
- No redirection mailbox
- Pilot-only recipient scope

## Preset Security Policies Review

Preset security policies were reviewed in the Microsoft Defender portal.

| Preset Policy | Batch 4 Decision |
|---|---|
| Built-in protection | Reviewed |
| Standard protection | Reviewed only |
| Strict protection | Reviewed only |

No tenant-wide Standard or Strict preset security policy expansion was performed in this batch.

## Why Custom Pilot Policies Were Used

Custom pilot policies were used because they allow controlled testing with specific users before expanding protection across the tenant.

This reduces the risk of legitimate mail disruption, attachment delay, unexpected URL blocking, or broad policy impact.

## Validation Performed

Validation included:

- Safe Links state before changes
- Safe Links policy creation or confirmation
- Safe Links rule creation or confirmation
- Safe Links policy and rule after-state export
- Safe Links configuration summary
- Safe Attachments state before changes
- Safe Attachments policy creation or confirmation
- Safe Attachments rule creation or confirmation
- Safe Attachments policy and rule after-state export
- Safe Attachments configuration summary
- Preset security policy portal review
- Pilot protection summary

## Privacy-Safe Evidence Handling

The following fields were not exported:

- IpAddress
- Location
- City
- State
- CountryOrRegion

Screenshots must be cropped or blurred if they show:

- Public IP address
- Location
- Message headers
- URL details
- Private mailbox content
- Device details
- Session metadata

## Safety Decisions

This batch did not:

- Use real phishing links
- Use real malware
- Enable tenant-wide Standard preset security policy
- Enable tenant-wide Strict preset security policy
- Expand Safe Links tenant-wide
- Expand Safe Attachments tenant-wide
- Export public IP address fields
- Export location fields

## Business Risk

Safe Links and Safe Attachments can affect user experience if enabled broadly without validation.

Potential risks include blocked legitimate URLs, delayed attachment delivery, blocked business attachments, and user confusion.

## Risk Treatment

The project reduced risk by configuring policies for pilot users only, validating policy/rule state after creation, reviewing preset security policies without enabling tenant-wide expansion, and avoiding real phishing or malware tests.

## Business Value

This batch demonstrates practical Microsoft Defender for Office 365 protection configuration.

It shows how to deploy Safe Links and Safe Attachments safely using pilot scope, validate policy state, and preserve mail-flow stability before broader rollout.
