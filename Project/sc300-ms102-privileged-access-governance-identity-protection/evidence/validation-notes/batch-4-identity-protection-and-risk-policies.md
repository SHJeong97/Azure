# Batch 4 Validation - Identity Protection and Risk-Based Policies

## Build Scope
This batch configured the Project 3 identity-risk response model by preparing the pilot risk users for remediation, creating separate user risk and sign-in risk Conditional Access policies, creating a protected-admin strong-authentication policy in Report-only mode, and reviewing the core Identity Protection reports.

## Business Outcome
The tenant now has a defined response model for risky users, risky sign-ins, and privileged administrator access. Identity-risk handling is no longer left as an undefined manual process.

## Validation Results
- Emma Reed and Olivia Chen were prepared for remediation-capable authentication
- a user risk policy was created for SG-PILOT-RISK-USERS
- a sign-in risk policy was created for SG-PILOT-RISK-USERS
- the two risk conditions were kept in separate policies
- a protected-admin Conditional Access policy was created in Report-only mode
- emergency access accounts remained excluded from the protected-admin policy
- Identity Protection report views were reviewed and captured

## Validation Evidence
- `evidence/screenshots/user-emma-reed-security-info-project3.png`
- `evidence/screenshots/user-olivia-chen-security-info-project3.png`
- `evidence/screenshots/ca02-user-risk-overview-project3.png`
- `evidence/screenshots/ca02-user-risk-users-project3.png`
- `evidence/screenshots/ca02-user-risk-conditions-project3.png`
- `evidence/screenshots/ca02-user-risk-grant-project3.png`
- `evidence/screenshots/ca02-user-risk-state-project3.png`
- `evidence/screenshots/ca03-signin-risk-overview-project3.png`
- `evidence/screenshots/ca03-signin-risk-users-project3.png`
- `evidence/screenshots/ca03-signin-risk-conditions-project3.png`
- `evidence/screenshots/ca03-signin-risk-grant-project3.png`
- `evidence/screenshots/ca03-signin-risk-state-project3.png`
- `evidence/screenshots/ca04-admin-strong-mfa-overview-project3.png`
- `evidence/screenshots/ca04-admin-strong-mfa-users-project3.png`
- `evidence/screenshots/ca04-admin-strong-mfa-grant-project3.png`
- `evidence/screenshots/ca04-admin-strong-mfa-reportonly-project3.png`
- `evidence/screenshots/idprotection-risky-users-project3.png`
- `evidence/screenshots/idprotection-risky-signins-project3.png`
- `evidence/screenshots/idprotection-risk-detections-project3.png`
- `evidence/screenshots/group-sg-pilot-risk-users-members-project3-final.png`
- `evidence/screenshots/group-sg-exclude-emergency-access-members-project3-final.png`

## Issues Encountered
- None / document actual issues here

## Reviewer Notes
This batch proves the tenant can separate user risk, sign-in risk, and privileged-admin protection into distinct, reviewable controls while preserving emergency recovery paths.
