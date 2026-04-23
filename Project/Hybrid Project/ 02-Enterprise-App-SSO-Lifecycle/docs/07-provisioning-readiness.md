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
- Automatic provisioning supported: No or not practical for this lab
- Configured in this project: No
- Lifecycle model used in this project: Manual access lifecycle with group-based assignment and app-side account dependency

## Notes
The enterprise app was used successfully for SAML SSO and group-based assignment.
However, automatic downstream account provisioning was not implemented in this project.
Lifecycle control remains strong on the Microsoft Entra side through app assignment, while app-side account creation and deactivation remain dependent on the target application capability.

## Evidence
The Provisioning blade reported:
"Out of the box automatic provisioning to BusinessPortal - Entra SAML Toolkit is not supported today."

## Notes
If automatic provisioning is not available, access lifecycle will still be enforced through Microsoft Entra assignment plus manual or app-local account handling.
