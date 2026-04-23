# Lifecycle Test Plan

## Joiner Test
Scenario:
A new user is added to the BusinessPortal Users group.

Expected result:
- User becomes assigned to the enterprise app through group membership
- User can access the app after sync
- If automatic provisioning is available and enabled, app account is created automatically
- If automatic provisioning is not available, app access requires the app-side account path already defined by the application

## Mover Test
Scenario:
A user is removed from the Users group and added to the Audit or Admin group.

Expected result:
- Old access path is removed
- New access path is assigned
- SSO reflects the new assignment state
- Provisioning behavior depends on target app capability

## Leaver Test
Scenario:
A user is removed from all app access groups.

Expected result:
- User loses enterprise app assignment
- User cannot launch the app from My Apps
- If automatic provisioning is available and enabled, the downstream account is disabled or deprovisioned according to app capability
- If automatic provisioning is not available, app-side deactivation remains a manual step
