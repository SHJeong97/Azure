# Batch 3 Validation - Admin Role Separation and Emergency Access

## Build Scope
This batch implemented the first administrative control model for the tenant by creating emergency access accounts, assigning limited daily admin roles, and reserving Global Administrator for recovery-only accounts.

## Business Outcome
The company now has a safer administrative operating model that reduces daily use of high privilege while preserving tenant recovery capability.

## Validation Results
- Two cloud-only emergency access accounts were created.
- Both emergency access accounts were added to the Conditional Access exclusion group.
- Ava Foster was assigned the Identity Administrator role.
- Ethan Walker was assigned the Helpdesk Administrator role.
- Global Administrator was restricted to the two emergency access accounts for this batch.
- Break-glass accounts were kept out of the standard employee E3 license group.

## Risk Reduction Achieved
- Reduced standing use of Global Administrator
- Reduced blast radius for daily admin work
- Reduced chance of tenant lockout during future Conditional Access rollout
- Improved separation of duties for support and identity administration

## Validation Evidence
- `evidence/screenshots/user-breakglass-01-overview.png`
- `evidence/screenshots/user-breakglass-02-overview.png`
- `evidence/screenshots/group-sg-exclude-emergency-access-members.png`
- `evidence/screenshots/role-identity-administrator-members.png`
- `evidence/screenshots/role-helpdesk-administrator-members.png`
- `evidence/screenshots/role-global-administrator-members.png`
- `evidence/screenshots/user-ava-foster-role.png`
- `evidence/screenshots/user-ethan-walker-role.png`

## Issues Encountered
- None / document actual issues here

## Reviewer Notes
This batch proves the tenant can support least-privilege administration and emergency recovery planning before broader security controls are enforced.
