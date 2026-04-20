# Secure Identity and Access Baseline for a 75-User Microsoft 365 Company

## Introduction
This project implements a secure, scalable identity and access baseline for a fictional 75-user company named Northstar Health Advisors using Microsoft Entra ID and Microsoft 365.

The goal was to move the company away from inconsistent manual administration and toward a repeatable operating model for identity, licensing, authentication, password recovery, and privileged access.

The implementation used a 12-user pilot to represent a 75-user organization while keeping the lab manageable and realistic.

## Objectives
- Standardize user onboarding with structured department-based identity assignment
- Reduce manual license assignment through group-based licensing
- Separate daily administrative duties from high-privilege emergency access
- Introduce multifactor authentication through a controlled pilot rollout
- Enable self-service password reset for pilot users
- Preserve tenant recovery through excluded emergency access accounts
- Produce validation evidence for each major configuration area

## Full Implementation
The project was built in six major stages.

First, the business scenario, access model, license strategy, and validation plan were documented before configuration began.

Second, a 12-user pilot was created to represent a 75-user company across HR, Finance, Sales, Operations, IT, and Executive departments. Security groups were created for departments, licensing, pilot authentication scope, emergency exclusion, and admin role organization.

Third, Microsoft 365 E3 was assigned through the `SG-LIC-M365-E3` group to standardize license delivery and reduce manual per-user assignment.

Fourth, emergency access accounts were created and reserved for tenant recovery. These accounts were placed into `SG-EXCLUDE-EMERGENCY-ACCESS`, and Global Administrator was restricted to those recovery accounts. Daily operational roles were separated by assigning Ava Foster as User Administrator and Ethan Walker as Helpdesk Administrator.

Fifth, authentication controls were introduced through a pilot approach. Six users were added to `SG-PILOT-CA-MFA`. Authentication methods were scoped for pilot use, self-service password reset was enabled for the pilot group, and a Conditional Access policy targeting Office 365 was first deployed in Report-only mode.

Finally, the policy was moved into enforcement. Pilot users completed MFA prompts, self-service password reset was validated, sign-in logs were reviewed, and emergency access exclusion was confirmed.

## Implementation Walkthrough

### 1. Planned the business scenario and technical model
The project began by defining the company structure, risk profile, access model, licensing approach, and validation standards before any technical deployment was performed.

### 2. Built pilot users and groups
Twelve pilot users were planned and created to simulate a mid-size company. Department groups, licensing groups, pilot authentication groups, admin helper groups, and emergency exclusion groups were created to support structured administration.

### 3. Standardized license assignment
Instead of assigning licenses one user at a time, Microsoft 365 E3 was assigned through the `SG-LIC-M365-E3` security group. This created a repeatable onboarding model and reduced manual license inconsistency.

### 4. Implemented least-privilege administration
Administrative access was separated by function:
- `ava.foster@democompany1016.onmicrosoft.com` was assigned **User Administrator**
- `ethan.walker@democompany1016.onmicrosoft.com` was assigned **Helpdesk Administrator**
- `breakglass-01@democompany1016.onmicrosoft.com` and `breakglass-02@democompany1016.onmicrosoft.com` were assigned **Global Administrator**

This reduced daily dependence on Global Administrator and improved tenant recovery planning.

### 5. Enabled the authentication pilot
Six users were added to `SG-PILOT-CA-MFA` to support a controlled rollout. Microsoft Authenticator and SMS were enabled for the pilot, SSPR was scoped to the pilot group, and the first Conditional Access policy was created for Office 365.

### 6. Validated enforced controls
The Conditional Access policy was moved from Report-only to On. MFA sign-in behavior was tested with pilot users, SSPR was tested end to end, sign-in logs were reviewed, and emergency access exclusion was verified.

## Results & Validation

### Identity and Group Results
- 12 pilot users were created successfully
- Department groups were created successfully
- License, pilot, exclusion, and admin helper groups were created successfully
- Group memberships were assigned based on department and operational role

### Licensing Results
- Microsoft 365 E3 was assigned through `SG-LIC-M365-E3`
- Pilot employee accounts inherited licensing through group membership
- Emergency access accounts were intentionally excluded from normal employee license assignment

### Administrative Security Results
- Global Administrator was restricted to recovery-only accounts
- Daily administrative work was split between User Administrator and Helpdesk Administrator
- Emergency accounts were prepared for Conditional Access exclusion

### Authentication Results
- Pilot users were scoped for MFA
- SSPR was enabled for the pilot group
- `CA01 - Pilot - Require MFA for Office 365` was created and later enforced
- Emma Reed and Olivia Chen successfully completed MFA-based sign-in validation
- Emma Reed successfully completed SSPR after registration remediation
- Break-glass exclusion was validated

### Evidence Files
Key evidence for this project is stored in:
- `evidence/screenshots/`
- `evidence/cli-output/`
- `evidence/validation-notes/`

Representative evidence includes:
- `group-sg-lic-m365-e3-license.png`
- `user-ava-foster-license.png`
- `role-user-administrator-members.png`
- `role-helpdesk-administrator-members.png`
- `role-global-administrator-members.png`
- `group-sg-pilot-ca-mfa-members.png`
- `ca01-policy-enabled-state.png`
- `signin-emma-ca-details-enforced.png`
- `signin-olivia-ca-details-enforced.png`
- `emma-sspr-password-reset-success.png`
- `ca-whatif-breakglass-excluded.png`

## Validation Walkthrough

### User and group validation
User creation and group creation were validated through Microsoft Graph PowerShell output and portal screenshots. Group membership was checked for department groups, license groups, and pilot groups.

### License validation
Sample users were reviewed to confirm that Microsoft 365 E3 was inherited through the licensing group instead of assigned manually.

### Admin role validation
Administrative assignments were checked through the Entra role membership views to confirm that:
- Ava held User Administrator
- Ethan held Helpdesk Administrator
- breakglass-01 and breakglass-02 held Global Administrator

### MFA and Conditional Access validation
Pilot users signed in through Office 365 and generated successful MFA challenge events. Sign-in logs confirmed the Conditional Access policy evaluation and enforcement path.

### SSPR validation
The first SSPR test failed because Emma Reed had not completed required method registration. This was remediated through an admin password reset followed by user registration of security information. After remediation, SSPR was successfully completed. This validated both the technical control and the operational reality that SSPR rollout depends on completed user registration.

### Emergency access validation
Emergency accounts were confirmed as members of the exclusion group, and Conditional Access exclusion was validated through policy scope review or What If testing.

## Key Takeaways
- Group-based identity and license assignment creates a cleaner onboarding and offboarding model
- Least-privilege administration reduces operational risk compared to daily use of Global Administrator
- Conditional Access should be introduced through a pilot-first rollout
- SSPR success depends not only on policy scope but also on successful user registration
- Emergency access design is essential before broad authentication enforcement
