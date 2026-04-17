# Batch 4 Validation - Authentication Baseline Pilot

## Build Scope
This batch configured the pilot authentication baseline for a selected set of users by enabling authentication methods, verifying combined registration, enabling SSPR for the pilot group, and creating the first Conditional Access policy in Report-only mode.

## Business Outcome
The company now has a staged authentication rollout model that improves account security while controlling deployment risk. Password-only access is being phased out for pilot users, and self-service recovery capability is being introduced to reduce help desk load.

## Validation Results
- SG-PILOT-CA-MFA was populated with pilot users from multiple departments.
- Microsoft Authenticator was enabled for the pilot group.
- SMS was enabled as a backup method for the pilot group.
- Combined registration was verified.
- SSPR was enabled for the pilot group.
- A Conditional Access policy targeting Office 365 was created in Report-only mode.
- Pilot sign-ins were generated to validate policy evaluation behavior.

## Validation Evidence
- `evidence/screenshots/group-sg-pilot-ca-mfa-members.png`
- `evidence/screenshots/auth-methods-microsoft-authenticator-policy.png`
- `evidence/screenshots/auth-methods-sms-policy.png`
- `evidence/screenshots/user-settings-combined-registration.png`
- `evidence/screenshots/sspr-properties-selected-group.png`
- `evidence/screenshots/sspr-authentication-methods.png`
- `evidence/screenshots/sspr-registration-settings.png`
- `evidence/screenshots/ca01-policy-overview.png`
- `evidence/screenshots/ca01-policy-users.png`
- `evidence/screenshots/ca01-policy-target-resources.png`
- `evidence/screenshots/ca01-policy-grant.png`
- `evidence/screenshots/ca01-policy-report-only.png`
- `evidence/screenshots/signin-emma-conditional-access.png`
- `evidence/screenshots/signin-olivia-conditional-access.png`

## Issues Encountered
- None / document actual issues here

## Reviewer Notes
This batch proves the tenant can support a controlled authentication modernization path: selected users can be prepared for MFA and SSPR, while Conditional Access impact is evaluated before enforcement.
