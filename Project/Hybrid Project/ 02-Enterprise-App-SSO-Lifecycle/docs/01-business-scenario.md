# Business Scenario

DemoCompany has already established a hybrid identity foundation using on-premises Active Directory, Microsoft Entra ID, and Microsoft 365.

The next business need is controlled access to a SaaS business application. The company wants:
- Microsoft Entra single sign-on
- group-based app assignment
- separate standard-user and admin access paths
- lifecycle control for onboarding, role changes, and offboarding
- a design that can later support automatic provisioning and deprovisioning

Primary business problem:
Application access is often managed manually, which creates inconsistency, weak auditability, and slower onboarding and offboarding.

Project goal:
Design and implement an enterprise application access model using Microsoft Entra enterprise applications, with a synced on-prem group model that supports SSO and future lifecycle provisioning.

Scope for this project:
- create app-specific access groups in on-prem AD
- sync those groups to Microsoft Entra ID
- add an enterprise application in Microsoft Entra
- assign owners and access groups
- configure SAML SSO
- prepare for or implement lifecycle provisioning depending on target app support

Success criteria:
- app access groups exist in on-prem AD and sync to Entra
- enterprise app instance exists in the tenant
- users can be assigned through groups instead of direct one-off assignment
- standard and admin access paths are separated
- the project documents how provisioning and deprovisioning should work for joiners, movers, and leavers
