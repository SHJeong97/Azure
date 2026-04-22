# Business Scenario

DemoCompany is a 75-user organization using Microsoft 365 for email, collaboration, and productivity. The company wants a stronger identity and access management model, but it still has practical need for traditional directory-based administration and hybrid identity.

The company has these departments:
- Executive
- IT
- HR
- Finance
- Sales
- Operations

Current pain points:
- User onboarding is inconsistent
- Administrative access is too broad
- Password reset processes are inefficient
- Identity authority is unclear
- Microsoft 365 security is underused
- The company wants better operational control without paying for a full enterprise data center design

Project goal:
Build an on-premises-style Active Directory environment hosted in Azure infrastructure, then synchronize identities into the Microsoft 365 tenant democompany1016.onmicrosoft.com to create a hybrid identity foundation.

Scope boundaries:
- Azure infrastructure is hosted in a personal Azure subscription used only for lab infrastructure
- Microsoft 365 identity, security, and administration are performed in the company tenant
- The project demonstrates hybrid identity architecture, role segmentation, Microsoft 365 administration, and security controls for a 50–100 user business

Success criteria:
- On-prem users are created in structured OUs
- Selected users sync successfully to Microsoft Entra ID
- Group and department structure are reflected in identity design
- Admin accounts are separated from normal user accounts
- Microsoft 365 admin responsibilities are segmented
- Security controls such as MFA, Conditional Access, and SSPR are prepared for later implementation
- Validation evidence proves the identity flow and admin model
