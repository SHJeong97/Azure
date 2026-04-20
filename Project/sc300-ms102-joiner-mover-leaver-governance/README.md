# Joiner-Mover-Leaver Access Governance for a 100-User Microsoft 365 Company

**Platform:** Microsoft Entra ID + Microsoft 365  
**Focus Areas:** SC-300, MS-102, Identity Lifecycle, Group-Based Licensing, Access Governance, Joiner-Mover-Leaver Operations

## Introduction
This project implements a joiner-mover-leaver access governance model for a fictional 100-user company named Crestview Manufacturing Services using Microsoft Entra ID and Microsoft 365.

The goal was to build a repeatable identity lifecycle process that standardizes onboarding, internal role changes, and offboarding. The project focused on ensuring that user access follows business role changes and that access is removed in a controlled way when employment ends.

The implementation used a pilot workforce model with baseline users, joiners, movers, and leavers to demonstrate how identity, licensing, groups, and shared resources can be governed across the user lifecycle.

## Objectives
- Standardize new-hire onboarding through group-based assignment
- Ensure movers lose old access and gain new access in a controlled sequence
- Ensure leavers are disabled, de-licensed, and removed from access paths
- Use group-based licensing instead of per-user manual assignment
- Govern shared mailbox access as part of lifecycle operations
- Produce validation evidence for every major lifecycle event
- Connect access lifecycle decisions to business risk reduction and auditability

## Project Review Guide
A reviewer can validate this project quickly by checking these items first:

1. `diagrams/jml-process-architecture.md`
2. `docs/10-business-risk-value-analysis.md`
3. `evidence/validation-notes/batch-5-leaver-workflow.md`
4. `evidence/screenshots/group-sg-joiner-pilot-members-project2.png`
5. `evidence/screenshots/group-sg-mover-pilot-members-project2.png`
6. `evidence/screenshots/group-sg-leaver-pilot-members-project2.png`
7. `docs/11-interview-talk-track.md`

## Full Implementation
The project was built in six major stages.

First, the company scenario, lifecycle governance model, access matrix, license strategy, resource plan, and validation standards were documented before implementation.

Second, a 12-user baseline workforce was created across HR, Finance, Sales, Operations, IT, and Executive departments. Department groups, lifecycle tracking groups, and a baseline Microsoft 365 E3 license group were created. Shared mailboxes were also created for HR, Finance, Sales, and Operations.

Third, the joiner workflow was implemented. Two new users were created, assigned to the correct department groups, added to the Microsoft 365 E3 licensing group, added to the joiner tracking group, and granted department-aligned shared mailbox access.

Fourth, the mover workflow was implemented. Two existing users changed departments. Their department attributes were updated, old department groups were removed, new department groups were assigned, old shared mailbox access was removed, and new shared mailbox access was granted.

Fifth, the leaver workflow was implemented. Two users were disabled, their sessions were revoked, their licensed-group membership was removed, their department and workflow access paths were removed, their shared mailbox access was removed, and they were added to a leaver tracking group for validation.

Finally, all evidence was organized into screenshots, CLI output, and validation notes so the lifecycle process could be reviewed as a complete governance implementation rather than just a set of disconnected admin tasks.

## Implementation Walkthrough

### 1. Planned the lifecycle governance model
The project began by defining how onboarding, internal transfers, and offboarding should work. The company scenario, access matrix, resource model, and validation standards were documented before any accounts or groups were created.

### 2. Built the baseline identity and resource foundation
Twelve baseline users were created across six departments. Department groups and lifecycle tracking groups were created, and Microsoft 365 E3 was assigned through the `SG-LIC-M365-E3` group. Shared mailboxes were created for the departments that would be used in later lifecycle testing.

### 3. Implemented the joiner workflow
Two new users were created:
- `chloe.adams@democompany1016.onmicrosoft.com`
- `jackson.reed@democompany1016.onmicrosoft.com`

Each joiner received:
- `SG-LIC-M365-E3`
- the correct department group
- `SG-JOINER-PILOT`
- department-aligned shared mailbox access

This proved that onboarding could follow a standard access pattern instead of one-off manual setup.

### 4. Implemented the mover workflow
Two existing users were changed to new departments:
- Olivia Park moved from Finance to Operations
- Sophia Brooks moved from Sales to HR

Each mover received:
- department attribute update
- removal from old department group
- addition to new department group
- addition to `SG-MOVER-PILOT`
- removal of old shared mailbox access
- addition of new shared mailbox access

This proved that access follows the role and that legacy access can be removed in a controlled way.

### 5. Implemented the leaver workflow
Two users were offboarded:
- Sophia Brooks
- Jackson Reed

Each leaver was processed by:
- disabling the account
- revoking sessions
- removing licensed-group membership
- removing department and workflow group memberships
- removing shared mailbox access
- adding the user to `SG-LEAVER-PILOT`

The accounts were preserved in a disabled state so the post-offboarding condition could be validated without relying on deletion.

### 6. Organized validation evidence
Each lifecycle phase produced screenshots, PowerShell/Graph output, and validation notes. This made the project reviewable from both a technical and audit perspective.

## Results & Validation

### Baseline Results
- 12 baseline users were created successfully
- department groups and lifecycle groups were created successfully
- Microsoft 365 E3 was assigned through `SG-LIC-M365-E3`
- shared mailboxes were created for HR, Finance, Sales, and Operations

### Joiner Results
- Chloe Adams was onboarded into Sales
- Jackson Reed was onboarded into Operations
- both joiners inherited Microsoft 365 E3 through group-based licensing
- both joiners were added to correct department groups and `SG-JOINER-PILOT`
- both joiners received appropriate shared mailbox access

### Mover Results
- Olivia Park moved from Finance to Operations
- Sophia Brooks moved from Sales to HR
- old department access was removed
- new department access was assigned
- old shared mailbox access was removed
- new shared mailbox access was granted
- both movers remained licensed with Microsoft 365 E3

### Leaver Results
- Sophia Brooks and Jackson Reed were disabled
- active sessions were revoked
- licensed-group membership was removed
- department and workflow group memberships were removed
- shared mailbox access was removed
- both users were added to `SG-LEAVER-PILOT`

### Evidence Files
Key evidence for this project is stored in:
- `evidence/screenshots/`
- `evidence/cli-output/`
- `evidence/validation-notes/`

Representative evidence includes:
- `users-all-users-project2.png`
- `group-sg-lic-m365-e3-license-project2.png`
- `exchange-shared-mailboxes-list-project2.png`
- `group-sg-joiner-pilot-members-project2.png`
- `exchange-sales-shared-permissions-chloe-project2.png`
- `group-sg-mover-pilot-members-project2.png`
- `exchange-hr-shared-permissions-sophia-project2.png`
- `user-sophia-brooks-blocked-post-leaver.png`
- `user-jackson-reed-license-removed-post-leaver.png`
- `group-sg-leaver-pilot-members-project2.png`

## Validation Walkthrough

### Baseline validation
The baseline build was validated by confirming:
- 12 users existed
- each department group had the expected members
- `SG-LIC-M365-E3` held the workforce license path
- sample users inherited Microsoft 365 E3
- the four shared mailboxes existed in Exchange admin center

### Joiner validation
The joiner process was validated by confirming:
- the two new accounts existed
- each joiner was in the correct department group
- each joiner inherited Microsoft 365 E3
- each joiner was added to `SG-JOINER-PILOT`
- each joiner received the correct shared mailbox access

### Mover validation
The mover process was validated by confirming:
- the two users showed updated department values
- old department group membership was removed
- new department group membership was added
- each user was added to `SG-MOVER-PILOT`
- old shared mailbox access was removed
- new shared mailbox access was granted
- E3 licensing remained in place

### Leaver validation
The leaver process was validated by confirming:
- the two user accounts were disabled
- active sessions were revoked
- `SG-LIC-M365-E3` membership was removed
- department and workflow group membership was removed
- shared mailbox access was removed
- both users were added to `SG-LEAVER-PILOT`

### Validation approach
Every major lifecycle event produced at least one screenshot and one written validation note. PowerShell and Graph output were also exported to support technical review and audit-style evidence.

## Key Takeaways
- Identity lifecycle governance is more than account creation; it requires control over access changes across the full employment lifecycle
- Group-based licensing makes joiner and leaver processing more consistent and easier to validate
- Mover workflows are critical for preventing privilege creep
- Offboarding should prioritize sign-in containment before entitlement cleanup
- Shared resources must be governed alongside groups and licenses
- Business-aligned IAM work should always produce reviewable evidence, not just completed configuration
