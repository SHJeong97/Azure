# Batch 2 Validation - Baseline Identity and Resource Build

## Build Scope
This batch created the baseline workforce model for the project by creating 12 users, creating core security groups, assigning department and license-group memberships, applying Microsoft 365 E3 through group-based licensing, and creating shared mailboxes for later lifecycle governance testing.

## Business Outcome
The company now has a standardized starting state for identity lifecycle management. Department access, baseline licensing, and shared resource objects are in place so joiner, mover, and leaver events can be handled consistently instead of manually.

## Validation Results
- 12 baseline users were created successfully
- Core department, license, and workflow groups were created successfully
- Department memberships were assigned based on the defined access matrix
- Microsoft 365 E3 was assigned through SG-LIC-M365-E3
- Four department shared mailboxes were created for later access lifecycle testing

## Validation Evidence
- `evidence/screenshots/users-all-users-project2.png`
- `evidence/screenshots/groups-all-groups-project2.png`
- `evidence/screenshots/group-sg-lic-m365-e3-license-project2.png`
- `evidence/screenshots/group-sg-dept-finance-members-project2.png`
- `evidence/screenshots/group-sg-dept-operations-members-project2.png`
- `evidence/screenshots/user-olivia-park-license-project2.png`
- `evidence/screenshots/user-sophia-brooks-license-project2.png`
- `evidence/screenshots/user-mason-lee-license-project2.png`
- `evidence/screenshots/exchange-shared-mailboxes-list-project2.png`
- `evidence/screenshots/exchange-hr-shared-overview-project2.png`
- `evidence/cli-output/baseline-users-created.csv`
- `evidence/cli-output/baseline-groups-created.csv`
- `evidence/cli-output/baseline-membership-results.csv`

## Issues Encountered
- None / document actual issues here

## Reviewer Notes
This batch established the baseline state required for joiner, mover, and leaver governance. Later lifecycle events will now be validated against a consistent department, licensing, and resource model.
