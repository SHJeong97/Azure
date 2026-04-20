# Batch 2 Validation - Pilot Identity and Admin Foundation

## Build Scope
This batch created the Project 3 pilot users, created the pilot groups, assigned baseline memberships, applied Microsoft 365 E5 through a dedicated license group, established emergency access exclusion membership, and assigned the initial active admin roles required for later PIM and Identity Protection work.

## Business Outcome
The tenant now has a controlled pilot foundation for privileged access governance and identity-risk controls. Emergency recovery accounts, privileged administrators, read-only oversight, and risk-test users are now separated into intentional access paths.

## Validation Results
- 8 pilot users were created successfully
- core pilot groups were created successfully
- 6 pilot users were added to SG-LIC-M365-E5-PILOT
- break-glass accounts were added to SG-EXCLUDE-EMERGENCY-ACCESS
- privileged and security-related pilot users were grouped correctly
- Microsoft 365 E5 was applied to the pilot license group
- Global Administrator was restricted to emergency access accounts
- Privileged Role Administrator, Security Administrator, and Global Reader were assigned to pilot admin accounts

## Validation Evidence
- `evidence/screenshots/users-all-users-project3.png`
- `evidence/screenshots/groups-all-groups-project3.png`
- `evidence/screenshots/group-sg-lic-m365-e5-pilot-license-project3.png`
- `evidence/screenshots/group-sg-exclude-emergency-access-members-project3.png`
- `evidence/screenshots/group-sg-pilot-priv-admins-members-project3.png`
- `evidence/screenshots/group-sg-pilot-risk-users-members-project3.png`
- `evidence/screenshots/group-sg-pilot-pim-eligible-members-project3.png`
- `evidence/screenshots/user-ava-foster-license-project3.png`
- `evidence/screenshots/user-emma-reed-license-project3.png`
- `evidence/screenshots/user-breakglass-01-overview-project3.png`
- `evidence/screenshots/role-global-administrator-members-project3.png`
- `evidence/screenshots/role-privileged-role-administrator-members-project3.png`
- `evidence/screenshots/role-security-administrator-members-project3.png`
- `evidence/screenshots/role-global-reader-members-project3.png`
- `evidence/cli-output/pilot-users-created.csv`
- `evidence/cli-output/pilot-groups-created.csv`
- `evidence/cli-output/pilot-membership-results.csv`
- `evidence/cli-output/pilot-membership-export.csv`

## Issues Encountered
- None / document actual issues here

## Reviewer Notes
This batch established the pilot identity, licensing, and role structure required for later just-in-time privileged access and identity-risk policy validation.
