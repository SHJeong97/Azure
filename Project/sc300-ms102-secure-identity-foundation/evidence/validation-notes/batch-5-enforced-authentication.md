# Batch 5 Validation - Enforced Authentication Pilot

## Build Scope
This batch moved the pilot authentication design into real enforcement by enabling the Conditional Access MFA policy, validating pilot user sign-in behavior, validating self-service password reset, and confirming emergency access exclusion.

## Business Outcome
The company now has working evidence that password-only access is no longer sufficient for the pilot population and that standard users can recover access through self-service workflows instead of relying entirely on help desk intervention.

## Validation Results
- The pilot Conditional Access policy was changed from Report-only to On.
- Emma Reed successfully completed MFA and accessed Office 365.
- Olivia Chen successfully completed MFA and accessed Office 365.
- Sign-in logs confirmed Conditional Access evaluation for pilot users.
- Emma Reed successfully completed self-service password reset and signed in with the new password.
- Break-glass exclusion was validated through Conditional Access simulation or exclusion-path evidence.

## Validation Evidence
- `evidence/screenshots/ca01-policy-enabled-overview.png`
- `evidence/screenshots/ca01-policy-enabled-state.png`
- `evidence/screenshots/emma-mfa-prompt.png`
- `evidence/screenshots/emma-office365-success.png`
- `evidence/screenshots/olivia-mfa-prompt.png`
- `evidence/screenshots/olivia-office365-success.png`
- `evidence/screenshots/signin-emma-ca-details-enforced.png`
- `evidence/screenshots/signin-olivia-ca-details-enforced.png`
- `evidence/screenshots/emma-sspr-verification.png`
- `evidence/screenshots/emma-sspr-password-reset-success.png`
- `evidence/screenshots/emma-post-sspr-login-success.png`
- `evidence/screenshots/ca-whatif-breakglass-excluded.png`
- or fallback evidence:
  - `evidence/screenshots/ca01-policy-excluded-group.png`
  - `evidence/screenshots/group-sg-exclude-emergency-access-members-final.png`

## Issues Encountered
- None / document actual issues here

## Reviewer Notes
This batch proves the pilot security design works operationally: MFA is enforced for intended users, self-service recovery works, and tenant recovery accounts remain outside the pilot control path.
