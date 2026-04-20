# Batch 5 Validation - Leaver Workflow

## Build Scope
This batch implemented the leaver workflow by disabling two user accounts, revoking sign-in sessions, removing group-based access, removing group-based licensing paths, removing shared mailbox permissions, and preserving the accounts in a disabled state for validation.

## Business Outcome
The company now has a repeatable offboarding pattern that prioritizes immediate access containment and entitlement cleanup without relying on ad hoc manual steps.

## Validation Results
- Sophia Brooks was disabled and removed from active access paths
- Jackson Reed was disabled and removed from active access paths
- Sign-in sessions were revoked
- Group-based license inheritance was removed by removing licensed-group membership
- Department and workflow group memberships were removed
- Shared mailbox permissions were removed
- Both users were added to SG-LEAVER-PILOT for evidence tracking
- Accounts were preserved in a disabled state instead of being deleted

## Validation Evidence
- `evidence/screenshots/user-sophia-brooks-blocked-post-leaver.png`
- `evidence/screenshots/user-jackson-reed-blocked-post-leaver.png`
- `evidence/screenshots/user-sophia-brooks-license-removed-post-leaver.png`
- `evidence/screenshots/user-jackson-reed-license-removed-post-leaver.png`
- `evidence/screenshots/group-sg-leaver-pilot-members-project2.png`
- `evidence/screenshots/group-sg-dept-hr-members-post-leaver.png`
- `evidence/screenshots/group-sg-dept-operations-members-post-leaver.png`
- `evidence/screenshots/group-sg-joiner-pilot-members-post-leaver.png`
- `evidence/screenshots/group-sg-mover-pilot-members-post-leaver.png`
- `evidence/screenshots/exchange-hr-shared-permissions-post-leaver.png`
- `evidence/screenshots/exchange-operations-shared-permissions-post-leaver.png`
- `evidence/cli-output/leaver-disable-results.csv`
- `evidence/cli-output/leaver-access-removal-results.csv`
- `evidence/cli-output/leaver-state-export.csv`

## Issues Encountered
- None / document actual issues here

## Reviewer Notes
This batch proves the project can deprovision users in a controlled order: contain sign-in first, remove entitlements second, and preserve evidence throughout the offboarding process.
