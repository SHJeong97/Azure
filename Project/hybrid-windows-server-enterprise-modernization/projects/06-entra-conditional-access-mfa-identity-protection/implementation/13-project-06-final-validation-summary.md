# Project 06 Final Validation Summary

## Purpose

This document records the final validation result for Project 06: Microsoft Entra Conditional Access, MFA, and Identity Protection Baseline.

## Project Context

Project 04 synchronized selected on-premises Active Directory users into Microsoft Entra ID.

Project 05 activated Microsoft 365 services for those synchronized users by assigning licenses, provisioning Exchange Online mailboxes, and standardizing primary SMTP addresses.

Project 06 protects Microsoft 365 access by implementing a controlled Conditional Access and MFA pilot without requiring Intune or device compliance.

## Environment

| Area | Value |
|---|---|
| Microsoft 365 tenant | democompany1016.onmicrosoft.com |
| Verified public domain | summitridge-mfg.com |
| Identity source | On-premises AD synced through Microsoft Entra Cloud Sync |
| Conditional Access pilot group | GRP-CA-Pilot-Users |
| Break-glass exclusion group | GRP-CA-Excluded-BreakGlass |
| Emergency access account | emergency.access01@democompany1016.onmicrosoft.com |
| Intune dependency | None |
| Compliant-device requirement | None |

## Pilot Users

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Final Conditional Access Policies

| Policy | Purpose | Final State |
|---|---|---|
| CA001-Require-MFA-Pilot-Users | Require MFA for pilot users | Enabled |
| CA002-Block-Legacy-Authentication | Block legacy authentication | Enabled or report-only based on legacy-auth review |
| CA004-SignIn-Risk-MFA | Require MFA for medium/high sign-in risk | Planned only |
| CA005-User-Risk-Password-Change | Require password change for high user risk | Planned only |

## Final Validation Performed

Final validation included:

- Microsoft Graph connection
- Final Conditional Access policy state export
- Final Conditional Access policy configuration export
- Final pilot group membership validation
- Final break-glass group membership validation
- Final MFA readiness export
- Final sanitized sign-in log export
- Final sanitized Conditional Access result export
- Final Identity Protection state export
- Final technical validation summary
- Final architecture summary
- Final policy outcome summary
- Final pilot user result summary
- Final validation checklist
- Privacy-safe evidence note
- README preparation note

## Final Technical Result

The project successfully implemented a Conditional Access pilot baseline that:

- Targets only approved pilot users
- Excludes emergency access
- Requires MFA for pilot users
- Blocks or prepares to block legacy authentication based on review
- Plans Identity Protection risk policies separately
- Avoids Intune dependency
- Avoids compliant-device requirements
- Provides rollback and monitoring controls
- Protects public IP/location privacy in evidence

## Privacy-Safe Evidence Handling

The following fields were intentionally excluded from final sign-in and Conditional Access evidence:

```text
IpAddress
Location
City
State
CountryOrRegion
```

Screenshots must be sanitized before GitHub upload if they show public IP address, location, device details, browser details, session metadata, QR codes, phone numbers, or authenticator device details.

## Rollback and Monitoring

Rollback scripts were created to return CA001 and CA002 to report-only mode.

Monitoring scripts were created to review:

- Conditional Access policy state
- Pilot group membership
- Break-glass exclusion membership
- Sanitized sign-in results
- Emergency access sign-ins
- Conditional Access policy changes

## Safety Decisions

The project did not:

- Target all users
- Remove break-glass exclusions
- Require Intune
- Require compliant devices
- Export public IP address fields
- Export location fields
- Enforce Identity Protection risk policies

## Business Value

Project 06 establishes a practical identity security baseline for Microsoft 365 access.

It demonstrates a controlled Conditional Access rollout using pilot groups, MFA readiness validation, report-only testing, break-glass protection, pilot enforcement, rollback planning, monitoring controls, and privacy-safe evidence handling.
