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
