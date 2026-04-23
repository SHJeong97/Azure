# Provisioning Readiness

## Objective
Determine whether BusinessPortal - Entra SAML Toolkit supports automatic user provisioning in a usable way for this lab.

## Current App State
- Enterprise app exists
- SAML SSO works
- Access is controlled through synced groups
- Assigned users can sign in
- Unassigned users are blocked

## Provisioning Questions
1. Does the app expose a supported provisioning configuration in Microsoft Entra?
2. Does the app require target-side API credentials or SCIM endpoint information?
3. Can provisioning be scoped to assigned users and groups only?
4. What user lifecycle operations are realistic for this app?
   - Create
   - Update
   - Disable / remove
5. What attributes would be required for account matching?

## Decision Outcome
- Automatic provisioning supported: [Yes/No]
- Configured in this project: [Yes/No]
- Lifecycle model used in this project: [Automatic/Manual/JIT-Not Used]

## Notes
If automatic provisioning is not available, access lifecycle will still be enforced through Microsoft Entra assignment plus manual or app-local account handling.
