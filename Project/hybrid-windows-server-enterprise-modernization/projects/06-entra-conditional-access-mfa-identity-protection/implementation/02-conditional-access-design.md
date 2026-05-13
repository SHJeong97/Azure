
# Conditional Access Design

## Purpose

This document defines the Microsoft Entra Conditional Access design for the Summit Ridge identity security pilot.

## Management Platform

```text
Microsoft Entra Conditional Access
```

## No Intune Dependency

This project intentionally does not use Intune.

The project will not require:

- Compliant device
- Hybrid joined device
- Intune enrollment
- Device compliance state

## Pilot Scope

| Item | Value |
|---|---|
| Pilot group | GRP-CA-Pilot-Users |
| Pilot users | Emma Wilson, Olivia Brown, Sophia Martinez |
| Break-glass exclusion group | GRP-CA-Excluded-BreakGlass |
| Policy mode first | Report-only |
| Enforcement method | Controlled pilot enablement |

## Planned Conditional Access Policies

| Policy Name | Purpose | Initial State |
|---|---|---|
| CA001-Require-MFA-Pilot-Users | Require MFA for pilot users | Report-only |
| CA002-Block-Legacy-Authentication | Block legacy authentication | Report-only |
| CA003-Require-MFA-For-Admin-Portals | Protect admin portal access | Report-only |
| CA004-SignIn-Risk-MFA | Require MFA for risky sign-ins | Report-only / planning |
| CA005-User-Risk-Password-Change | Require password change for risky users | Report-only / planning |

## Licensing Notes

Conditional Access requires Microsoft Entra ID P1 or P2.

Risk-based Conditional Access requires Microsoft Entra ID Protection, which is a Microsoft Entra ID P2 feature.

## Report-Only Rollout

Policies will first be created in report-only mode.

Report-only mode allows policy impact review before enforcement.

## Break-Glass Account Protection

At least one emergency access or break-glass account should be excluded from Conditional Access enforcement.

The break-glass account should be:

- Cloud-only
- Protected with a strong password
- Monitored
- Excluded from Conditional Access lockout scenarios
- Used only for emergency administrative recovery

## Safety Decisions

The project will not:

- Target all users immediately
- Enforce policies before report-only review
- Require compliant devices
- Depend on Intune
- Block administrators without exclusions
- Combine user risk and sign-in risk in the same policy
- Disable emergency access

## Business Risk

Conditional Access changes can cause:

- User sign-in interruption
- Admin lockout
- MFA registration issues
- Legacy app failures
- Helpdesk tickets
- Misinterpreted report-only results

## Risk Treatment

The project reduces risk by using pilot groups, break-glass exclusions, report-only mode, sign-in log review, and staged enforcement.

## Business Value

Conditional Access creates a scalable identity security baseline for Microsoft 365 access and helps the organization move toward Zero Trust access control.
