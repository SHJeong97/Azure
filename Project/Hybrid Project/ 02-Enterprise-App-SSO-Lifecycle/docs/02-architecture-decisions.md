# Architecture Decisions

## Decision 1: Reuse the existing hybrid identity foundation
Reason:
Project 1 already created the authoritative identity platform.

Business outcome:
Avoids duplicated effort and makes this project look like a realistic phase 2 instead of an isolated lab.

## Decision 2: Use group-based app access instead of direct per-user assignment
Reason:
Application access should be manageable at scale.

Business outcome:
Faster onboarding, cleaner offboarding, better auditability.

## Decision 3: Separate standard-user access and app-admin access
Reason:
Administrative access to an app should not use the same identity path as normal user access.

Business outcome:
Lower blast radius and better least-privilege alignment.

## Decision 4: Use a Microsoft Entra enterprise application instance as the control point
Reason:
Enterprise apps are the correct place to configure SSO, assignment, and provisioning behavior.

Business outcome:
Centralized identity control for the business application.

## Decision 5: Start with a repeatable SAML app pattern
Reason:
The project needs a controlled SSO implementation path before provisioning complexity is added.

Business outcome:
Reduces troubleshooting scope and creates a clean validation sequence.

## Final Production Gap Notes

This project intentionally used Microsoft Entra SAML Toolkit as a controlled test application rather than a live third-party production SaaS platform.
That choice made SAML validation practical, but it also meant downstream automatic provisioning was not available out of the box in this lab.
The project therefore focused on correct app onboarding, assignment, delegated ownership, SSO validation, and honest lifecycle documentation.
