
# Risk and Rollback Plan

## Purpose

This document defines the risk and rollback plan for Microsoft Entra Conditional Access, MFA, and Identity Protection policies.

## Key Risks

| Risk | Impact | Treatment |
|---|---|---|
| Admin lockout | Tenant administration blocked | Use break-glass exclusion group |
| Wrong users targeted | Unexpected MFA or blocking | Use pilot group scope |
| Policy enforced too early | User disruption | Start in report-only mode |
| Legacy authentication blocked unexpectedly | App or protocol failures | Review sign-in logs before enforcement |
| MFA registration incomplete | Users cannot satisfy MFA | Validate authentication methods first |
| Risk policy misconfigured | Incorrect user challenge or password reset | Plan risk policies carefully |
| Break-glass account missing | Emergency recovery unavailable | Create and document emergency access |
| Exclusions not validated | Critical accounts affected | Validate excluded users/groups |

## Break-Glass Principle

At least one emergency access account must be excluded from Conditional Access enforcement.

The emergency account should be:

- Cloud-only
- Highly protected
- Excluded from Conditional Access policies
- Monitored
- Used only for emergency recovery

## Rollback Principle

Rollback should be fast and controlled.

The first rollback action is usually to switch the affected Conditional Access policy back to:

```text
Report-only
```

or:

```text
Off
```

## Rollback Order

Recommended rollback order:

1. Identify the affected policy.
2. Confirm impacted users from sign-in logs.
3. Change policy state from On to Report-only or Off.
4. Confirm user sign-in is restored.
5. Review policy assignments, conditions, and grant controls.
6. Fix the policy.
7. Re-test in report-only mode.
8. Re-enable only after validation.

## Policy-Specific Rollback

| Policy | Rollback Action |
|---|---|
| CA001-Require-MFA-Pilot-Users | Set policy to Report-only or Off |
| CA002-Block-Legacy-Authentication | Set policy to Report-only or Off |
| CA003-Require-MFA-For-Admin-Portals | Confirm admin exclusions, then set Report-only or Off |
| CA004-SignIn-Risk-MFA | Set Report-only or disable risk policy |
| CA005-User-Risk-Password-Change | Set Report-only or disable risk policy |

## Monitoring Areas

The project will monitor:

- Sign-in logs
- Conditional Access policy result
- Report-only policy result
- MFA registration status
- Legacy authentication sign-ins
- Risky users
- Risky sign-ins
- Break-glass account activity

## Safety Decisions

The project will not:

- Enforce policies tenant-wide at the start
- Target all users immediately
- Require compliant devices
- Depend on Intune
- Block administrators without exclusions
- Enforce risk policies before planning and validation

## Business Risk

Poor Conditional Access rollout can interrupt access to Microsoft 365, block administrators, disrupt legacy applications, and generate helpdesk tickets.

## Risk Treatment

The project reduces risk by using report-only mode, pilot groups, emergency access exclusions, and rollback documentation before enforcement.

## Business Value

A rollback-aware Conditional Access deployment improves security while preserving administrative recovery and operational continuity.
