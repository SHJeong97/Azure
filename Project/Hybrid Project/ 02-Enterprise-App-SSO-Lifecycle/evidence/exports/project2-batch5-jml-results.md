# Project 2 Batch 5 JML Results

## Joiner
User:
- liam.brooks@democompany1016.onmicrosoft.com

Change:
- Added to GG-App-BusinessPortal-Users

Expected:
- Receives enterprise app assignment through group membership
- App becomes visible in My Apps
- Access path is enabled at the Microsoft Entra assignment layer

Observed:
- Liam was added to the synced Users app group
- Group membership synchronized to Microsoft Entra ID
- The app became available through the Entra assignment path

Interpretation:
- Joiner access worked as intended through synced group-based assignment

## Mover
User:
- emma.reed@democompany1016.onmicrosoft.com

Change:
- Removed from GG-App-BusinessPortal-Users
- Added to GG-App-BusinessPortal-Audit

Expected:
- Keeps access through a new assigned group
- Access justification changes without direct per-user reassignment

Observed:
- Emma was removed from the Users group
- Emma was added to the Audit group
- Synced assignment state changed successfully
- Emma retained access through the new app access group

Interpretation:
- Mover access worked as intended through group membership change rather than direct reassignment

## Leaver
User:
- zoe.turner@democompany1016.onmicrosoft.com

Change:
- Removed from all BusinessPortal access groups

Expected:
- Loses enterprise app assignment
- No longer sees the app in My Apps

Observed:
- Zoe was removed from all synced BusinessPortal access groups
- Zoe no longer saw the application in My Apps
- Direct access to the Toolkit application could still succeed

Interpretation:
- Microsoft Entra assignment lifecycle worked correctly
- Downstream app-side deprovisioning did not occur automatically
- The target application retains its own local account model and does not support out-of-the-box automatic provisioning in this lab

## Provisioning Note
Automatic downstream provisioning is not supported for BusinessPortal - Entra SAML Toolkit in this lab.
Lifecycle control therefore occurs at the Microsoft Entra assignment layer, not through downstream account automation.
