
# Policy Rollout Plan

## Purpose

This document defines the rollout plan for Microsoft Entra Conditional Access policies in the Summit Ridge identity security pilot.

## Rollout Strategy

Conditional Access policies will be deployed in stages.

The project will start with report-only mode before enforcing any access control.

## Rollout Phases

| Phase | Action | Purpose |
|---|---|---|
| Phase 1 | Create pilot groups | Define controlled user scope |
| Phase 2 | Create break-glass exclusion group | Prevent administrator lockout |
| Phase 3 | Validate authentication methods | Confirm users can register MFA |
| Phase 4 | Create policies in report-only mode | Review policy impact safely |
| Phase 5 | Review sign-in logs | Confirm expected policy behavior |
| Phase 6 | Enable selected pilot policies | Enforce only after validation |
| Phase 7 | Monitor results | Confirm no unexpected access issues |

## Pilot Users

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Pilot Groups

| Group | Purpose |
|---|---|
| GRP-CA-Pilot-Users | Users included in Conditional Access testing |
| GRP-CA-Excluded-BreakGlass | Emergency access accounts excluded from CA enforcement |
| GRP-CA-Policy-Readers | Optional group for documentation/review access |

## Planned Policies

| Policy ID | Policy Name | Purpose | Initial State |
|---|---|---|---|
| CA001 | CA001-Require-MFA-Pilot-Users | Require MFA for pilot users | Report-only |
| CA002 | CA002-Block-Legacy-Authentication | Block legacy authentication | Report-only |
| CA003 | CA003-Require-MFA-For-Admin-Portals | Protect admin portal access | Report-only |
| CA004 | CA004-SignIn-Risk-MFA | Require MFA for risky sign-ins | Report-only / planning |
| CA005 | CA005-User-Risk-Password-Change | Require password change for risky users | Report-only / planning |

## Report-Only Validation

Report-only mode will be used before enforcement.

Validation will include:

- Policy impact review
- Sign-in log review
- User coverage validation
- Exclusion validation
- Grant control validation
- Legacy authentication impact review

## Enforcement Rules

A policy can move from report-only to enabled only after:

- Pilot users are correctly scoped
- Break-glass exclusions are confirmed
- Report-only results match expectations
- Sign-in logs show no unexpected lockout risk
- Rollback steps are documented

## No Intune Requirement

This project intentionally does not require:

- Compliant device
- Hybrid joined device
- Intune enrollment
- Device compliance status

## Business Risk

Conditional Access enforcement can cause user or administrator access problems if scoped incorrectly.

## Risk Treatment

The project reduces risk by using pilot groups, break-glass exclusions, report-only validation, and staged enforcement.

## Business Value

A staged Conditional Access rollout helps protect Microsoft 365 access while reducing the chance of accidental lockout or production disruption.
