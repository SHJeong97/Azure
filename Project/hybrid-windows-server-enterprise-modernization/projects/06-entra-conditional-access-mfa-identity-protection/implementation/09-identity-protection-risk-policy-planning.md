# Identity Protection and Risk-Based Conditional Access Planning

## Purpose

This document records Microsoft Entra Identity Protection readiness, risky user review, risk detection export, and risk-based Conditional Access planning for Project 06.

## Project Context

Project 06 builds a Microsoft Entra Conditional Access, MFA, and Identity Protection baseline for Summit Ridge Manufacturing Group.

This batch focuses on risk-based access planning only.

No risk-based Conditional Access policy was enforced in this batch.

## Required Licensing

Risk-based Conditional Access requires Microsoft Entra ID Protection / Microsoft Entra ID P2 licensing.

The tenant license SKU state was exported to validate whether the lab tenant has P2-capable licensing through Microsoft 365 E5, EMS E5, or equivalent licensing.

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

## Risk Review Performed

The following Identity Protection areas were reviewed:

- Tenant license readiness
- Conditional Access pilot group membership
- Break-glass exclusion group membership
- Risky users
- Pilot risky user state
- Risk detections
- Identity Protection portal overview
- Risky users portal view
- Risky sign-ins portal view
- Risk detections portal view

## Expected Clean Lab Result

In a controlled lab tenant, it is normal to see:

```text
No risky users found
No risk detections found
No risky sign-ins found
```

This is not a failure.

It means no current risk activity was observed during the review window.

## Planned Risk-Based Policies

Two separate risk-based Conditional Access policies were planned.

| Policy | Risk Type | Risk Level | Planned Control | Initial Mode |
|---|---|---|---|---|
| CA004-SignIn-Risk-MFA | Sign-in risk | Medium and High | Require MFA | Report-only planned |
| CA005-User-Risk-Password-Change | User risk | High | Require password change | Report-only planned |

## Risk Policy Separation Decision

Sign-in risk and user risk are planned as separate policies.

The project does not combine user risk and sign-in risk in the same Conditional Access policy.

## Sign-In Risk Response

Sign-in risk evaluates the risk of a specific authentication attempt.

Planned response:

```text
Medium sign-in risk = Require MFA
High sign-in risk = Require MFA
```

## User Risk Response

User risk evaluates the probability that the user account itself is compromised.

Planned response:

```text
High user risk = Require password change
```

## Report-Only Strategy

Risk-based policies should first be created in report-only mode.

Report-only validation should include:

- Sign-in log review
- Report-only policy result review
- Pilot user impact review
- Break-glass exclusion validation
- Risky user review
- Risk detection review

## Safety Decisions

This batch did not:

- Enforce sign-in risk policy
- Enforce user risk policy
- Block any users
- Require password change
- Require compliant devices
- Use Intune
- Remove break-glass exclusions
- Combine user risk and sign-in risk in one policy

## Business Risk

Risk-based access controls can disrupt users if they are enforced without reviewing risk events, policy scope, exclusions, and user readiness.

## Risk Treatment

The project reduces risk by validating Identity Protection readiness, documenting clean-lab risk results, separating risk policy types, and planning report-only deployment before enforcement.

## Business Value

Identity Protection planning prepares the organization to respond to risky sign-ins and potentially compromised users without immediately disrupting the pilot environment.
