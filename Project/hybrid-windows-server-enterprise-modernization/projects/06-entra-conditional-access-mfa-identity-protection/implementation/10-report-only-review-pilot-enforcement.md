# Report-Only Review and Pilot Enforcement

## Purpose

This document records the report-only review, enforcement readiness checks, pilot enforcement, and post-enforcement validation for Project 06 Conditional Access policies.

## Project Context

Project 06 builds a Microsoft Entra Conditional Access, MFA, and Identity Protection baseline for Summit Ridge Manufacturing Group.

This batch moved selected pilot policies from report-only validation into controlled pilot enforcement.

## Policies Reviewed

| Policy | Purpose | Initial State | Final Pilot State |
|---|---|---|---|
| CA001-Require-MFA-Pilot-Users | Require MFA for pilot users | Report-only | Enabled |
| CA002-Block-Legacy-Authentication | Block legacy authentication | Report-only | Enabled or intentionally skipped based on legacy authentication review |

## Pilot Group

```text
GRP-CA-Pilot-Users
```

## Break-Glass Exclusion Group

```text
GRP-CA-Excluded-BreakGlass
```

## Pilot Users

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Emergency Access Account

```text
emergency.access01@democompany1016.onmicrosoft.com
```

The emergency access account was validated before pilot enforcement.

## Pre-Enforcement Validation

Before enabling enforcement, the project validated:

- CA001 and CA002 current policy states
- Pilot group membership
- Break-glass exclusion group membership
- Recent pilot sign-in logs
- Report-only Conditional Access evaluations
- Legacy authentication activity
- Enforcement readiness summary
- Enforcement decision note

## Enforcement Decision

CA001 was enabled for pilot enforcement because:

- Pilot users were scoped through GRP-CA-Pilot-Users
- Break-glass account was excluded
- MFA registration readiness was validated in Batch 3
- Report-only behavior was reviewed in Batch 4
- No Intune or compliant-device requirement was used

CA002 was enabled only if legacy authentication review showed no observed dependency.

If legacy authentication activity was present, CA002 enforcement was skipped and documented.

## Post-Enforcement Validation

Post-enforcement validation included:

- Policy state export
- Pilot user MFA sign-in testing
- Post-enforcement sign-in log export
- Post-enforcement Conditional Access result export
- Pilot enforcement result summary

## Privacy Handling

Public IP address and location data were not exported in this batch.

The following fields were intentionally excluded from command outputs and CSV evidence:

```text
IpAddress
Location
City
State
CountryOrRegion
```

Screenshots must be cropped or blurred to avoid exposing:

- Public IP address
- Geographic location
- Device identifiers
- Browser/session metadata
- Personal authenticator details

## Expected Result

CA001 expected result:

```text
Pilot users are prompted for MFA.
After successful MFA, pilot users can access Microsoft 365.
```

CA002 expected result:

```text
Legacy authentication is blocked if enforcement is enabled.
Modern browser sign-ins should continue working.
```

## Rollback Principle

If pilot enforcement causes unexpected access issues, the first rollback action is to return the affected policy to:

```text
Report-only
```

Rollback helper scripts already created:

```text
rollback-ca001-to-report-only.ps1
rollback-ca002-to-report-only.ps1
```

## Safety Decisions

This batch did not:

- Target all users
- Remove break-glass exclusions
- Require compliant devices
- Use Intune
- Export public IP address data
- Export location data
- Enforce risk-based Conditional Access policies

## Business Risk

Conditional Access enforcement can cause sign-in disruption if policy scope, exclusions, MFA registration, or legacy application dependencies are not validated first.

## Risk Treatment

The project reduced risk by using report-only validation, pilot-only scope, break-glass exclusions, sanitized sign-in evidence, and rollback scripts.

## Business Value

This batch demonstrates a controlled transition from Conditional Access report-only validation to pilot enforcement while preserving emergency access and rollback readiness.
