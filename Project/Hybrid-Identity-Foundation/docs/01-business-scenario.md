# Business Scenario

DemoCompany is a 75-user organization using Microsoft 365 for email, collaboration, and productivity, but it still has operational dependence on traditional directory services for identity administration, department-based organization, and legacy access patterns.

The company has these departments:
- Executive
- IT
- HR
- Finance
- Sales
- Operations

Current problems:
- User onboarding is inconsistent.
- Admin privileges are too broad.
- Password resets create helpdesk overhead.
- Identity exists in too many places without a clean authority model.
- The company wants stronger Microsoft 365 security without fully abandoning on-prem-style administration patterns.

Project goal:
Build a hybrid identity foundation where on-prem AD is the authoritative source for core employee identities, Microsoft Entra ID extends those identities into Microsoft 365, and security controls reduce admin overexposure and sign-in risk.

Success criteria:
- On-prem users sync successfully to Microsoft Entra ID.
- Department and role structure is reflected in identity objects.
- Selected users receive Microsoft 365 licenses through group-based assignment.
- Admin roles are segmented by function.
- MFA and Conditional Access protect privileged access.
- Self-service password reset is enabled with hybrid writeback.
- Validation evidence proves the environment works end to end.
