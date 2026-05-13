# CA002 — Block Legacy Authentication

## Purpose

This document records the creation and validation of the second Microsoft Entra Conditional Access policy for Project 06.

## Policy Name

```text
CA002-Block-Legacy-Authentication
```

## Policy Goal

Block legacy authentication for the Conditional Access pilot users after validating impact in report-only mode.

## Policy State

```text
Report-only
```

## Included Group

```text
GRP-CA-Pilot-Users
```

## Excluded Group

```text
GRP-CA-Excluded-BreakGlass
```

## Pilot Users

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Emergency Access Exclusion

The break-glass exclusion group contains the emergency access account:

```text
emergency.access01@democompany1016.onmicrosoft.com
```

This account is excluded from Conditional Access enforcement to reduce administrator lockout risk.

## Target Resources

The policy targets:

```text
All cloud apps
```

## Client Apps

The policy applies to legacy authentication client types:

```text
Exchange ActiveSync
Other clients
```

## Grant Control

The policy grant control is:

```text
Block access
```

## Device Compliance

This policy does not require:

```text
Compliant device
Hybrid joined device
Intune enrollment
Device compliance state
```

## Validation Performed

Validation included:

- Microsoft Graph connection
- Pilot and break-glass groups loaded
- Pilot group membership validated
- Break-glass exclusion group membership validated
- Existing Conditional Access policies exported before CA002
- CA002 policy design summary created
- CA002 created in report-only mode
- CA002 full configuration exported
- CA002 validated in Microsoft Entra admin center
- Pilot modern sign-in tests performed
- Recent pilot sign-in logs exported
- CA002 report-only evaluation reviewed
- Legacy authentication sign-ins exported
- CA002 legacy authentication impact summary created
- CA002 sign-in log review note created

## Expected Report-Only Behavior

Because the policy is in report-only mode:

```text
The policy evaluates matching legacy authentication sign-ins.
The policy does not block access.
The policy does not affect normal browser sign-ins unless they match policy conditions.
```

## Legacy Authentication Result Interpretation

Modern browser sign-ins usually use modern authentication and may not match this policy.

If no legacy authentication sign-ins appear, that is a clean result for the current review window.

Expected clean lab result:

```text
No legacy authentication activity observed.
```

## Safety Decisions

This batch did not:

- Enable CA002 enforcement
- Target all users
- Require compliant devices
- Depend on Intune
- Block any users
- Remove break-glass exclusions

## Business Risk

Legacy authentication does not support modern security controls like MFA and can increase account compromise risk.

However, blocking legacy authentication without review can disrupt older applications or protocols.

## Risk Treatment

The project reduces risk by using pilot group scoping, break-glass exclusions, report-only mode, sign-in log review, and staged enforcement.

## Business Value

CA002 creates a controlled baseline for blocking legacy authentication while allowing impact review before enforcement.
