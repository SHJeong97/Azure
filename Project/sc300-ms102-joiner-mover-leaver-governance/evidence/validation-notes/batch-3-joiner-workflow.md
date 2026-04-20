# Batch 3 Validation - Joiner Workflow

## Build Scope
This batch implemented the joiner workflow by creating two new-hire accounts, assigning baseline group memberships, validating group-based licensing, and granting shared mailbox access aligned to department.

## Business Outcome
The company now has a repeatable onboarding pattern where new hires can receive identity, license, department access, and shared resource access in a defined sequence instead of through inconsistent manual setup.

## Validation Results
- Chloe Adams was created as a Sales joiner
- Jackson Reed was created as an Operations joiner
- Both joiners were added to SG-LIC-M365-E3
- Both joiners were added to the correct department group
- Both joiners were added to SG-JOINER-PILOT for tracking and validation
- Both joiners inherited Microsoft 365 E3
- Shared mailbox access was granted according to department

## Validation Evidence
- `evidence/screenshots/user-chloe-adams-overview.png`
- `evidence/screenshots/user-jackson-reed-overview.png`
- `evidence/screenshots/user-chloe-adams-license-project2.png`
- `evidence/screenshots/user-jackson-reed-license-project2.png`
- `evidence/screenshots/group-sg-joiner-pilot-members-project2.png`
- `evidence/screenshots/group-sg-dept-sales-members-post-joiner-project2.png`
- `evidence/screenshots/group-sg-dept-operations-members-post-joiner-project2.png`
- `evidence/screenshots/exchange-sales-shared-permissions-chloe-project2.png`
- `evidence/screenshots/exchange-operations-shared-permissions-jackson-project2.png`
- `evidence/cli-output/joiner-users-created.csv`
- `evidence/cli-output/joiner-membership-results.csv`
- `evidence/cli-output/joiner-membership-export.csv`

## Issues Encountered
- None / document actual issues here

## Reviewer Notes
This batch proves the company can onboard new hires through a standard identity lifecycle model that includes both directory access and business resource access.
