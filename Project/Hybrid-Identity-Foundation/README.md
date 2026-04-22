# Hybrid Identity Foundation Using Azure-Hosted Lab Infrastructure and a Separate Microsoft 365 Tenant

## Introduction

This project simulates a 75-user company building a hybrid identity foundation using Azure-hosted infrastructure and a separate Microsoft 365 tenant. The goal was to create an on-premises-style Active Directory environment in Azure, synchronize it to Microsoft Entra ID, and implement Microsoft 365 governance and security controls aligned to SC-300 and MS-102 responsibilities.

The design intentionally separated:
- Azure infrastructure hosting in a personal Azure subscription
- Microsoft 365 and Entra administration in `democompany1016.onmicrosoft.com`

This reflects a lab constraint, but still demonstrates the real engineering problem: designing, securing, and validating a hybrid identity platform for a small-to-mid-size organization.

## Objectives

- Build Azure-hosted infrastructure for a hybrid identity lab
- Deploy Active Directory Domain Services and DNS
- Create a structured OU, user, group, and admin model
- Add a cloud-ready UPN strategy for hybrid synchronization
- Install Microsoft Entra Connect and run a pilot sync
- Implement group-based Microsoft 365 licensing
- Create cloud-only emergency access accounts
- Apply least-privilege role assignments
- Enable MFA, SSPR, and password writeback
- Validate business, operational, and security outcomes

## Full Implementation

### 1. Azure infrastructure foundation
- Created `rg-hybrid-identity-lab`
- Deployed `vnet-hybrid-identity` and `snet-core`
- Deployed:
  - `ADC-01` for AD DS and DNS
  - `MGMT-01` for management and Entra Connect
- Restricted RDP access and enabled cost control such as auto-shutdown

### 2. On-prem Active Directory deployment
- Installed AD DS on `ADC-01`
- Created the forest:
  - `corp.democompany1016.local`
- Installed DNS and configured Azure VNet custom DNS to point to `ADC-01`
- Joined `MGMT-01` to the domain
- Installed RSAT on `MGMT-01`

### 3. Directory structure and identity model
- Added alternate UPN suffix:
  - `democompany1016.onmicrosoft.com`
- Created OUs for:
  - Admins
  - Employees
  - Groups
  - Servers
  - Workstations
  - Service Accounts
- Created department, licensing, and role groups
- Created pilot employee identities
- Created separate named privileged admin accounts
- Kept emergency access accounts cloud-only

### 4. Hybrid identity synchronization
- Installed Microsoft Entra Connect on `MGMT-01`
- Used Password Hash Synchronization
- Scoped the pilot sync to:
  - `OU=Employees`
  - `OU=Groups`
  - `OU=Admins`
- Triggered the initial sync manually
- Validated synced users and groups in `democompany1016.onmicrosoft.com`

### 5. Cloud governance and licensing
- Created two cloud-only break-glass accounts
- Assigned Global Administrator to break-glass accounts
- Set usage location for synced pilot users
- Assigned:
  - Microsoft 365 E3 to `GG-Lic-M365-E3-Pilot`
  - Microsoft 365 E5 to `GG-Lic-M365-E5-Privileged-Pilot`
- Assigned least-privilege admin roles:
  - Hybrid Identity Administrator
  - License Administrator
  - Password Administrator

### 6. Security controls
- Enabled Microsoft Authenticator and phone-based fallback methods
- Created `CA-SSPR-Pilot`
- Enabled SSPR for pilot users
- Enabled password writeback in Entra Connect and Entra Password reset
- Created Conditional Access MFA policies for:
  - administrators
  - pilot users
- Excluded cloud break-glass accounts from restrictive policies
- Tested end-to-end password reset with on-prem writeback

## Implementation Walkthrough

### Azure infrastructure decisions
The infrastructure was intentionally minimal to preserve Azure free-trial credit while still supporting a realistic hybrid identity design. A two-server model was enough to separate service hosting from administration without overengineering the lab.

### Active Directory design decisions
A single forest and single domain were used because this is the most realistic low-complexity design for a 75-user company. DNS was hosted on the first domain controller because AD-integrated DNS is required for healthy domain join and hybrid identity operations.

### UPN and synchronization decisions
The on-prem AD forest used a `.local` namespace, which is not appropriate for Microsoft 365 sign-in. To support hybrid sync cleanly, an alternate UPN suffix of `democompany1016.onmicrosoft.com` was added and pilot users were created with cloud-usable UPNs.

### Administrative separation decisions
Normal user accounts and named admin accounts were separated to reduce blast radius and better reflect least-privilege operations. Emergency access accounts were intentionally kept cloud-only so tenant recovery did not depend on on-prem infrastructure.

### Licensing and role design decisions
Licensing was assigned through synced security groups instead of direct user assignment. This creates a cleaner operating model because future adds and removes can happen through group membership changes. Entra admin roles were split by function instead of using Global Administrator broadly.

### Security control decisions
MFA was required through Conditional Access, but policies were validated in Report-only before enforcement. SSPR was enabled only for a pilot group first, and password writeback was enabled so the project would prove real hybrid operational value rather than just cloud-only reset behavior.

## Results & Validation

### Infrastructure results
- Azure infrastructure deployed successfully
- Both VMs reachable and correctly placed in the lab network
- Domain controller and management server roles separated successfully

### Active Directory results
- `corp.democompany1016.local` created successfully
- `MGMT-01` joined the domain successfully
- OU, group, and user structure created successfully

### Hybrid identity results
- Microsoft Entra Connect installed successfully
- Pilot users and groups synchronized into Microsoft Entra ID
- Cloud identities reflected the intended on-prem structure

### Governance results
- Group-based licensing worked for pilot user and privileged admin groups
- Emergency access accounts remained cloud-only
- Least-privilege role assignments were applied successfully

### Security results
- Authentication methods enabled
- SSPR enabled for pilot scope
- Password writeback functioned end to end
- Conditional Access admin and pilot policies validated and enforced
- Password reset attempts that violated on-prem policy were rejected, which confirmed writeback was reaching Active Directory policy controls

## Validation Walkthrough

### Key validation checks performed
- Verified DNS path from `MGMT-01` to `ADC-01`
- Verified domain join and RSAT management
- Verified OU and group structure in ADUC
- Verified pilot users had correct UPN suffixes
- Verified pilot groups and users appeared in Entra ID after sync
- Verified Usage location before licensing
- Verified license inheritance from synced groups
- Verified admin role assignments in Entra
- Verified Report-only Conditional Access evaluation in sign-in logs
- Verified SSPR registration and password writeback behavior

### Evidence locations
- Architecture notes: `docs/02-architecture-decisions.md`
- Final validation summary: `docs/09-final-validation-summary.md`
- Evidence index: `evidence/evidence-index.md`
- Architecture diagram: `diagrams/hybrid-identity-architecture.md`
- Logs and exports: `evidence/logs/` and `evidence/exports/`

## Key Takeaways

- Hybrid identity is not only a sync exercise; it is an operating model decision
- UPN planning matters early, especially when `.local` namespaces are involved
- Group-based licensing and least-privilege admin design create scalable Microsoft 365 administration
- Emergency access accounts should remain cloud-only and outside restrictive access policies
- Password writeback adds real operational value because successful cloud resets can still be governed by on-prem password policy
- A small lab can still demonstrate strong engineering judgment when technical choices are tied to business outcomes, cost constraints, and risk reduction
