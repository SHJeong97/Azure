# Batch 4 Validation - Mover Workflow

## Build Scope
This batch implemented the mover workflow by updating user department values, removing legacy department access, assigning new department access, and changing shared mailbox permissions to match the users' new roles.

## Business Outcome
The company now has a repeatable mover process that reduces privilege creep by proving old access can be removed and replacement access can be assigned in a controlled sequence.

## Validation Results
- Olivia Park was moved from Finance to Operations
- Sophia Brooks was moved from Sales to HR
- Old department group access was removed
- New department group access was assigned
- Both movers were added to SG-MOVER-PILOT for tracking
- Shared mailbox access was removed from the old department mailbox and granted to the new department mailbox
- Baseline Microsoft 365 E3 licensing remained in place

## Validation Evidence
- `evidence/screenshots/user-olivia-park-department-post-move.png`
- `evidence/screenshots/user-sophia-brooks-department-post-move.png`
- `evidence/screenshots/group-sg-dept-finance-members-post-move.png`
- `evidence/screenshots/group-sg-dept-operations-members-post-move.png`
- `evidence/screenshots/group-sg-dept-sales-members-post-move.png`
- `evidence/screenshots/group-sg-dept-hr-members-post-move.png`
- `evidence/screenshots/group-sg-mover-pilot-members-project2.png`
- `evidence/screenshots/exchange-finance-shared-permissions-post-move.png`
- `evidence/screenshots/exchange-operations-shared-permissions-olivia-project2.png`
- `evidence/screenshots/exchange-sales-shared-permissions-post-move.png`
- `evidence/screenshots/exchange-hr-shared-permissions-sophia-project2.png`
- `evidence/screenshots/user-olivia-park-license-post-move.png`
- `evidence/screenshots/user-sophia-brooks-license-post-move.png`
- `evidence/cli-output/mover-department-update-results.csv`
- `evidence/cli-output/mover-group-update-results.csv`
- `evidence/cli-output/mover-membership-export.csv`

## Issues Encountered
- None / document actual issues here

## Reviewer Notes
This batch proves the project can handle internal role and department changes without leaving users with unnecessary legacy access.
