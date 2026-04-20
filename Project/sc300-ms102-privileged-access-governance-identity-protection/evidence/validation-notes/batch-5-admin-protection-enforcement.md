# Batch 5 Validation - Admin Protection Enforcement

## Build Scope
This batch moved the protected-admin Conditional Access policy from Report-only into enforcement, validated sign-in behavior for privileged users, validated PIM activation under the enforced model, and confirmed emergency access exclusion.

## Business Outcome
The company now has enforced sign-in protection for privileged admin roles while preserving a recoverable emergency-access path.

## Validation Results
- CA04 was moved from Report-only to On
- Ava Foster completed protected privileged sign-in validation
- Ethan Walker completed protected PIM activation validation
- Conditional Access sign-in logs showed policy evaluation for the pilot admins
- Emergency access exclusion was confirmed

## Validation Evidence
- `evidence/screenshots/user-ava-foster-security-info-project3.png`
- `evidence/screenshots/user-ethan-walker-security-info-project3.png`
- `evidence/screenshots/user-rachel-kim-security-info-project3.png`
- `evidence/screenshots/user-mason-lee-security-info-project3.png`
- `evidence/screenshots/ca04-whatif-breakglass-excluded-project3.png`
- `evidence/screenshots/ca04-admin-strong-mfa-enabled-overview-project3.png`
- `evidence/screenshots/ca04-admin-strong-mfa-enabled-state-project3.png`
- `evidence/screenshots/ava-admin-mfa-prompt-project3.png`
- `evidence/screenshots/ava-admin-portal-success-project3.png`
- `evidence/screenshots/ethan-admin-signin-protected-project3.png`
- `evidence/screenshots/pim-ethan-activation-under-ca04-project3.png`
- `evidence/screenshots/pim-ethan-active-after-enforcement-project3.png`


## Issues Encountered
- Initial CA04 enforcement blocked Ava Foster with “Additional sign-in methods are required to access this resource.”
- Root cause: the protected-admin policy required an authentication strength stronger than the pilot admin’s registered methods.
- Remediation: CA04 was adjusted to Require multifactor authentication for the pilot phase.
- After policy adjustment, admin sign-in and validation testing proceeded successfully.

## Reviewer Notes
This batch proves the tenant can enforce stronger privileged-user protection without breaking the just-in-time admin model.
