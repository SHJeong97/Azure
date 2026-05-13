Paste this entire block:

# CA001 — Require MFA for Pilot Users

## Purpose

This document records the creation and validation of the first Microsoft Entra Conditional Access policy for Project 06.

## Policy Name

```text
CA001-Require-MFA-Pilot-Users
```

## Policy Goal

Require multifactor authentication for the Conditional Access pilot users while validating impact in report-only mode before enforcement.

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

The policy applies to:

```text
Browser
Mobile apps and desktop clients
```

## Grant Control

The policy grant control is:

```text
Require multifactor authentication
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
- CA001 policy design summary created
- CA001 created in report-only mode
- CA001 full configuration exported
- CA001 validated in Microsoft Entra admin center
- Pilot user sign-in tests performed
- Sign-in logs reviewed
- Report-only policy impact exported
- CA001 sign-in log review note created

## Expected Report-Only Behavior

Because the policy is in report-only mode:

```text
The policy evaluates pilot sign-ins.
The policy does not block access.
The policy does not enforce MFA yet.
```

## Safety Decisions

This batch did not:

- Enable CA001 enforcement
- Target all users
- Require compliant devices
- Depend on Intune
- Block any users
- Remove break-glass exclusions

## Business Risk

Conditional Access MFA enforcement can interrupt user access if MFA registration is incomplete or if users are scoped incorrectly.

## Risk Treatment

The project reduces risk by using pilot group scoping, break-glass exclusions, report-only mode, sign-in log review, and staged enforcement.

## Business Value

CA001 establishes the first controlled MFA policy baseline for Microsoft 365 access while allowing impact review before enforcement.
