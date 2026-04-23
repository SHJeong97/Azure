# Implementation Notes

## Batch 1 Scope
This batch defines the project structure, app access model, and app-specific access groups.

## Existing Foundation Reused
- Hybrid AD
- Microsoft Entra Connect
- Synced users
- Named admin accounts
- Existing licensing and governance baseline

## New Scope for Project 2
- App-specific access group design
- Enterprise application onboarding
- SSO and lifecycle access model

## Batch 2 Notes
An enterprise application instance named BusinessPortal - Entra SAML Toolkit was added from the Microsoft Entra gallery.
Two named admin accounts were assigned as enterprise application owners.
The application was configured to remain visible to users and to require assignment.
Three synced on-prem access groups were assigned to the application using Default Access.
This established a controlled access boundary before SSO configuration.

## Batch 3 Notes
SAML single sign-on was configured for BusinessPortal - Entra SAML Toolkit.
Direct members were added to the synced app access groups and synchronized to Microsoft Entra ID.
Initial SAML values were entered in Microsoft Entra, the raw certificate was downloaded, and the Login URL, Microsoft Entra Identifier, and Logout URL were copied into the Toolkit application.
The Toolkit-generated SP Initiated Login URL and ACS URL were then copied back into Microsoft Entra to complete the SAML trust.
SSO was validated for a standard user and an admin user.
An unassigned user was also tested to validate assignment enforcement.

## Batch 4 Notes
The Provisioning blade was reviewed to determine whether the enterprise application supported a practical automatic provisioning path for this lab.
Provisioning scope was documented around assigned users and groups only.
A downstream attribute-mapping plan was documented so lifecycle behavior could be tied to predictable identity data.
A baseline export of current app-group membership was captured before joiner, mover, and leaver testing.
A lifecycle change script was prepared for the next batch.
