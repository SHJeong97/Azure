# Enterprise App SSO and Lifecycle Provisioning for a 75-User Company

## Introduction

This project simulates a 75-user company extending its hybrid identity foundation into enterprise application access management. After building core hybrid identity in Project 1, the next requirement was to onboard a SaaS-style business application into Microsoft Entra so that access could be controlled through synced groups, delegated ownership, and centralized single sign-on.

The project used:
- existing hybrid users and groups from on-prem AD
- Microsoft Entra enterprise applications
- SAML single sign-on
- group-based app assignment
- lifecycle testing for joiners, movers, and leavers

This project intentionally distinguishes three different control layers:
- SSO
- Microsoft Entra assignment
- downstream application account lifecycle

## Objectives

- Create app-specific access groups in on-prem AD
- Synchronize those groups to Microsoft Entra ID
- Add and configure an enterprise application
- Delegate application ownership
- Use group-based assignment instead of direct one-off user assignment
- Configure SAML single sign-on
- Validate standard-user and admin-user access
- Document provisioning capability honestly
- Test joiner, mover, and leaver access lifecycle behavior

## Full Implementation

### 1. App access model creation
- Created `OU=Apps` under `OU=Groups` in on-prem AD
- Created:
  - `GG-App-BusinessPortal-Users`
  - `GG-App-BusinessPortal-Admins`
  - `GG-App-BusinessPortal-Audit`
- Synchronized those groups to Microsoft Entra ID

### 2. Enterprise app onboarding
- Added `BusinessPortal - Entra SAML Toolkit` from the Microsoft Entra gallery
- Assigned enterprise app owners:
  - `adm.olivia.kim`
  - `adm.ethan.park`
- Enabled:
  - user sign-in
  - user visibility
  - assignment required

### 3. Assignment model
- Assigned synced app access groups to the enterprise app
- Used group-based assignment instead of direct per-user assignment
- Separated standard-user, admin, and audit access paths

### 4. SAML SSO configuration
- Configured the enterprise app for SAML
- Downloaded the raw certificate
- copied Entra SAML values into the Toolkit
- copied Toolkit SP/ACS values back into Entra
- validated sign-in for both a standard user and an admin user

### 5. Provisioning readiness review
- Reviewed the Provisioning blade
- Determined that out-of-the-box automatic provisioning was not supported for this app in this lab
- Documented lifecycle scope and attribute mapping instead of falsely claiming automatic provisioning

### 6. Joiner, mover, leaver validation
- Joiner:
  - added Liam Brooks to the Users app group
  - validated the new app access path
- Mover:
  - moved Emma Reed from Users to Audit
  - validated access through the new group path
- Leaver:
  - removed Zoe Turner from all app groups
  - validated loss of My Apps visibility and Entra assignment path
  - documented that direct Toolkit access could still succeed because downstream deprovisioning was not automated

## Implementation Walkthrough

### Identity reuse decisions
The project reused the hybrid identity foundation built earlier instead of rebuilding users and groups in the cloud. This made the app access model more realistic because the source of authority remained on-prem AD with Microsoft Entra as the assignment and SSO control plane.

### Access model decisions
App-specific security groups were created first so application onboarding would follow a scalable access pattern. This avoided the weak lab pattern of assigning users directly to an enterprise app one by one.

### Ownership decisions
Application ownership was delegated to named admin accounts rather than relying on one broad administrator. This better reflects least-privilege administration and operational separation.

### SSO decisions
SAML was used because it is a common enterprise app integration pattern and because the Microsoft Entra SAML Toolkit provides a controlled validation target.

### Provisioning decisions
Provisioning was reviewed but not enabled because the target app did not support out-of-the-box automatic provisioning in this lab. The project therefore documented provisioning readiness and lifecycle behavior honestly rather than pretending downstream automation existed.

### Lifecycle decisions
Joiner, mover, and leaver testing was still valuable even without automatic provisioning because Microsoft Entra assignment remained the access control point. This let the project prove how app access changes when synced group membership changes.

## Results & Validation

### App access model results
- App-specific on-prem groups were created successfully
- Groups synchronized successfully to Microsoft Entra ID
- The enterprise app used group-based assignment successfully

### SSO results
- SAML trust was configured successfully
- Emma Reed could sign in as a standard user
- adm.olivia.kim could sign in as an admin user
- Assigned users could see the app in My Apps

### Assignment enforcement results
- Unassigned users did not receive My Apps visibility
- Assignment-required behavior worked at the Entra layer

### Provisioning results
- Provisioning support was reviewed
- Out-of-the-box automatic provisioning was not available for this lab app
- Attribute mapping and lifecycle design were documented instead

### Lifecycle results
- Liam Brooks gained app access after group membership change
- Emma Reed retained access through a new group path after a role change
- Zoe Turner lost My Apps visibility after removal from all app groups
- Direct Toolkit access for Zoe could still succeed because the application retained its own local account model

## Validation Walkthrough

### Key validation checks performed
- Validated synced app groups in on-prem AD and Entra
- Validated enterprise app ownership
- Validated app properties including assignment required
- Validated SAML sign-in for assigned users
- Validated My Apps visibility for assigned users
- Validated unassigned-user restriction at the Entra assignment layer
- Reviewed the Provisioning blade and documented the unsupported automatic provisioning outcome
- Validated joiner, mover, and leaver changes through synced group membership

### Evidence locations
- App access model: `docs/04-app-access-model.md`
- Provisioning readiness: `docs/07-provisioning-readiness.md`
- Lifecycle plan: `docs/08-lifecycle-test-plan.md`
- Attribute mapping plan: `docs/09-attribute-mapping-plan.md`
- Final validation summary: `docs/10-final-validation-summary.md`
- Evidence index: `evidence/evidence-index.md`

## Key Takeaways

- Enterprise app access should be built on groups, not direct user assignment
- SSO success does not automatically mean downstream provisioning exists
- Microsoft Entra assignment control and target-application account lifecycle are different things
- Joiner, mover, and leaver changes can still be validated meaningfully even when downstream provisioning is not supported
- Honest documentation of product limitations makes the portfolio stronger, not weaker
- Delegated app ownership and least-privilege design improve operational realism
