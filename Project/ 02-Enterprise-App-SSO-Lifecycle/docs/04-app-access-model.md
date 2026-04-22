# App Access Model

## App Pattern
The project uses one business application access model with separate group paths for:
- standard users
- app administrators
- audit/reviewer access

## Pilot Access Groups
- GG-App-BusinessPortal-Users
- GG-App-BusinessPortal-Admins
- GG-App-BusinessPortal-Audit

## Access Logic
- Standard business users receive normal application access
- Admin users receive elevated administrative access
- Audit users are reserved for review/reporting scenarios if needed

## Identity Source
On-prem Active Directory remains the source of authority for access groups.
Microsoft Entra ID receives the synchronized group objects and uses them for enterprise app assignment.

## Lifecycle Logic
- Joiner: add user to the correct app group
- Mover: remove old group membership, add new group membership
- Leaver: remove app group membership or disable source account
