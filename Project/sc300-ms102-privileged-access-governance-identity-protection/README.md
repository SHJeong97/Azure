# Privileged Access Governance and Risk-Based Identity Protection for a 250-User Microsoft 365 Company

**Platform:** Microsoft Entra ID + Microsoft 365 E5  
**Focus Areas:** SC-300, MS-102, PIM, Identity Protection, Risk-Based Conditional Access, Least Privilege, Admin Security

## Introduction
This project implements a privileged access governance and risk-based identity protection model for a fictional 250-user company named Northstar Advisory Group using Microsoft Entra ID and Microsoft 365 E5.

The goal was to reduce standing administrative privilege, create a safer privileged-access model, and define how the company responds to risky identities and risky sign-ins.

The implementation used a controlled E5 pilot with emergency access accounts, privileged admin users, security-response users, and risk-test standard users so advanced identity controls could be validated without applying them to the whole tenant.

## Objectives
- Reduce standing privileged access through Privileged Identity Management
- Separate emergency recovery access from daily admin access
- Apply Microsoft 365 E5 to a controlled pilot for Entra ID P2-backed controls
- Configure identity-risk response policies for risky users and risky sign-ins
- Protect privileged administrators with stronger Conditional Access controls
- Validate just-in-time activation and admin sign-in protection with evidence
- Produce reviewable screenshots, outputs, and validation notes for every major control

## Project Review Guide
A reviewer can validate this project quickly by checking these items first:

1. `diagrams/privileged-access-risk-architecture.md`
2. `docs/13-business-risk-value-analysis.md`
3. `evidence/validation-notes/batch-5-admin-protection-enforcement.md`
4. `evidence/screenshots/pim-user-administrator-eligible-assignment-project3.png`
5. `evidence/screenshots/pim-ethan-activation-success-project3.png`
6. `evidence/screenshots/ca04-admin-strong-mfa-enabled-state-fixed-project3.png`
7. `docs/14-interview-talk-track.md`

## Full Implementation
The project was built in six major stages.

First, the company scenario, privileged-access governance model, admin role matrix, risk-based protection strategy, license scope, and validation plan were documented before implementation.

Second, a Project 3 pilot foundation was created. Eight pilot users were built, pilot groups were created, Microsoft 365 E5 was assigned through a dedicated group for the licensed pilot users, emergency access accounts were excluded from selected controls, and the initial active administrative roles were assigned.

Third, the just-in-time access model was implemented through Privileged Identity Management. Ethan Walker was assigned User Administrator as an eligible role instead of a standing active role. Activation settings were configured to require MFA, justification, and a one-hour maximum activation period.

Fourth, risk-based identity protection controls were configured. Separate Conditional Access policies were created for user risk and sign-in risk, and a protected-admin Conditional Access policy was created in Report-only mode. Identity Protection reports were reviewed as part of the response model.

Fifth, the protected-admin policy was moved from Report-only into enforcement. Ava Foster successfully validated protected privileged sign-in, Ethan Walker successfully validated PIM activation under the enforced admin-protection model, and emergency access exclusion was confirmed.

Finally, the project captured evidence across screenshots and validation notes so the outcome could be reviewed as a complete privileged-access and identity-protection implementation rather than a disconnected set of admin tasks.

## Implementation Walkthrough

### 1. Planned the privileged access and identity-risk model
The project started by defining the business problem, privileged-role design, risk-based protection strategy, pilot scope, and validation standard before any technical deployment was performed.

### 2. Built the pilot identity and admin foundation
Eight pilot users were created:
- two emergency access accounts
- four privileged/security-related pilot users
- two risk-test standard users

Five core groups were also created:
- `SG-LIC-M365-E5-PILOT`
- `SG-PILOT-PRIV-ADMINS`
- `SG-PILOT-RISK-USERS`
- `SG-EXCLUDE-EMERGENCY-ACCESS`
- `SG-PILOT-PIM-ELIGIBLE`

Microsoft 365 E5 was assigned through `SG-LIC-M365-E5-PILOT`, and the foundational admin roles were assigned so later PIM and Identity Protection work could be performed safely.

### 3. Implemented PIM-based eligible access
Ethan Walker was prepared as the pilot just-in-time admin user.

Instead of assigning User Administrator as permanent active access, the project assigned Ethan as:
- **Eligible** for **User Administrator**

PIM settings for that role required:
- MFA for activation
- justification
- one-hour maximum activation duration

Ethan then activated the role through **My roles**, proving the tenant could move from standing privilege to controlled, time-bound elevation.

### 4. Implemented identity-risk policy design
Two risk-test users were prepared:
- `emma.reed@democompany1016.onmicrosoft.com`
- `olivia.chen@democompany1016.onmicrosoft.com`

The project then created:
- `CA02 - User Risk - Require Password Change`
- `CA03 - Sign-in Risk - Require MFA`

These policies were intentionally separated so user risk and sign-in risk could follow different remediation paths.

The project also created:
- `CA04 - Admins - Require Strong MFA`

This policy targeted privileged directory roles while excluding emergency access accounts.

### 5. Enforced protected-admin access
The protected-admin policy was first staged in Report-only mode, then moved into enforcement.

During enforcement validation:
- Ava Foster completed privileged admin sign-in under the protected policy
- Ethan Walker activated User Administrator through PIM under the same protected-admin model
- sign-in logs confirmed Conditional Access evaluation
- emergency access exclusion was validated

### 6. Troubleshot and corrected an authentication-strength mismatch
The first enforcement attempt for Ava Foster failed because the protected-admin policy required a stronger authentication strength than the pilot admin’s registered methods could satisfy.

The project corrected this by changing the protected-admin grant control from an authentication-strength requirement to:
- **Require multifactor authentication**

That adjustment preserved the pilot’s business objective while aligning the enforcement method with the authentication methods actually deployed for the pilot users.

## Results & Validation

### Pilot Foundation Results
- 8 pilot users were created successfully
- pilot groups were created successfully
- 6 pilot users inherited Microsoft 365 E5 through `SG-LIC-M365-E5-PILOT`
- emergency access accounts were added to `SG-EXCLUDE-EMERGENCY-ACCESS`
- foundational active admin roles were assigned correctly

### PIM Results
- Ethan Walker was assigned User Administrator as an eligible role
- PIM activation settings required MFA and justification
- maximum activation duration was limited to one hour
- Ethan successfully activated the eligible role
- the resulting privileged access was time-bound instead of permanently active

### Identity Protection Results
- Emma Reed and Olivia Chen were prepared as remediation-ready risk-test users
- a user risk policy was created for the risk pilot
- a sign-in risk policy was created for the risk pilot
- user risk and sign-in risk were intentionally separated into different policies
- Identity Protection report views were reviewed and captured

### Protected Admin Results
- `CA04 - Admins - Require Strong MFA` was created and enforced for the pilot
- Ava Foster successfully completed protected admin sign-in validation
- Ethan Walker successfully completed protected PIM activation validation
- break-glass accounts remained excluded from selected controls
- sign-in log evidence confirmed Conditional Access evaluation

### Implementation Issue and Remediation
- Initial enforcement failed for Ava Foster because the protected-admin policy required a stronger authentication strength than the pilot admin methods could satisfy
- The issue was remediated by changing the admin-protection grant control to **Require multifactor authentication**
- After the adjustment, protected-admin validation testing completed successfully

### Evidence Files
Key evidence for this project is stored in:
- `evidence/screenshots/`
- `evidence/validation-notes/`

Representative evidence includes:
- `group-sg-lic-m365-e5-pilot-license-project3.png`
- `role-global-administrator-members-project3.png`
- `role-privileged-role-administrator-members-project3.png`
- `pim-user-administrator-eligible-assignment-project3.png`
- `pim-ethan-activation-success-project3.png`
- `ca02-user-risk-overview-project3.png`
- `ca03-signin-risk-overview-project3.png`
- `ca04-admin-strong-mfa-enabled-state-fixed-project3.png`
- `ava-admin-blocked-auth-strength-mismatch-project3.png`
- `ava-admin-portal-success-project3.png`
- `signin-ava-ca04-details-project3.png`
- `signin-ethan-ca04-details-project3.png`

## Validation Walkthrough

### Foundation validation
The pilot foundation was validated by confirming:
- all eight pilot users existed
- pilot groups existed and contained the expected members
- E5 was inherited by the licensed pilot users
- emergency access accounts were excluded from the normal employee license path
- initial role assignments matched the planned role model

### PIM validation
The PIM model was validated by confirming:
- Ethan had an eligible User Administrator assignment
- activation required MFA and justification
- the role could be activated successfully
- the active assignment was temporary and not permanently active

### Identity Protection validation
The identity-risk model was validated by confirming:
- Emma and Olivia were in `SG-PILOT-RISK-USERS`
- the user risk policy targeted user risk only
- the sign-in risk policy targeted sign-in risk only
- Identity Protection report views were accessible and captured

### Protected-admin validation
The protected-admin model was validated by confirming:
- `CA04` targeted privileged directory roles
- emergency access accounts remained excluded
- Ava could complete protected admin sign-in
- Ethan could complete protected sign-in and PIM activation
- sign-in logs showed Conditional Access evaluation for the pilot admins

### Validation approach
Every major control in the project was validated with screenshots and written notes. The project also preserved the initial authentication-strength mismatch as evidence of real troubleshooting and control tuning.

## Key Takeaways
- Least privilege becomes operationally meaningful when privileged access is eligible and time-bound instead of permanently active
- Emergency access design must exist before enforcing stronger privileged-access controls
- Identity Protection policies should separate user risk from sign-in risk
- Advanced controls must be aligned with the authentication methods users actually have registered
- Report-only testing is valuable, but final proof requires live enforcement and successful validation
- Strong IAM portfolio work should show design, implementation, validation, and troubleshooting together

  ## Skills Demonstrated
- Microsoft Entra ID administration
- Microsoft 365 E5 administration
- Privileged Identity Management (PIM)
- Just-in-time privileged access design
- Identity Protection policy design
- Risk-based Conditional Access
- Least-privilege admin modeling
- Emergency access design
- Conditional Access troubleshooting
- Business-aligned IAM documentation
