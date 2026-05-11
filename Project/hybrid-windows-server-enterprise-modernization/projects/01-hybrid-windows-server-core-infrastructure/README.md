# Project 01 — Hybrid Windows Server Core Infrastructure Foundation

## Introduction

This project builds the reusable hybrid Windows Server foundation for **Summit Ridge Manufacturing Group**, a simulated 250-user company modernizing from traditional Windows Server administration into a secure Microsoft hybrid environment.

The company needs a reliable identity, DNS, network, and management foundation before implementing Microsoft Entra hybrid identity, Microsoft 365 domain migration, file server modernization, Entra Application Proxy, Azure Arc, backup, disaster recovery, and Intune endpoint management.

This project focuses heavily on **AZ-800** and **AZ-801** skills while preparing the environment for later **SC-300**, **MS-102**, and **MD-102** scenarios.

---

## Objectives

- Build a cost-controlled Azure-hosted Windows Server lab environment
- Create a reusable virtual network and subnet design
- Deploy two Windows Server domain controllers
- Configure Active Directory Domain Services
- Configure AD-integrated internal DNS
- Configure a management server for RSAT, DNS, and Group Policy administration
- Create a realistic OU, user, group, admin account, and service account structure
- Add a future public UPN suffix for hybrid identity readiness
- Separate internal AD DNS from future public DNS
- Document technical decisions using business risk and business value reasoning

---

## Full Implementation

This project was implemented in eight batches:

1. **Business scenario, architecture, subscription/license checklist, and cost-control setup**
2. **Azure resource group, virtual network, subnets, and NSG baseline**
3. **Deployment of DC01, DC02, and MGMT01**
4. **AD DS, DNS, and forest/domain deployment**
5. **MGMT01 domain join, RSAT, DNS validation, and management access**
6. **OU model, users, groups, admin accounts, and service account baseline**
7. **Hybrid-ready UPN suffix, naming standards, and baseline documentation**
8. **Final validation and GitHub-ready documentation package**

---

## Implementation Walkthrough

### Batch 1 — Business Scenario and Cost-Control Foundation

The project began with a business scenario for **Summit Ridge Manufacturing Group**, a simulated 250-user company that needs a stable Windows Server foundation before modernizing identity, storage, application access, endpoint management, monitoring, and disaster recovery.

Current Microsoft cloud tenant:

```text
democompany1016.onmicrosoft.com
```

Internal AD DS domain selected for the lab:

```text
corp.democompany1016.local
```

Future public business domain selected for Microsoft 365 sign-in and email:

```text
summitridge-mfg.com
```

The design intentionally avoids renaming the internal AD DS domain later. Instead, the public domain is added as a future UPN suffix and will be verified in Microsoft 365 during a later project.

This reduces operational risk while still allowing users to eventually sign in and send email with a professional public domain.

---

### Batch 2 — Azure Network Foundation

The Azure network foundation was created in:

```text
rg-srmg-hybrid-core
```

The virtual network is:

```text
vnet-srmg-hybrid-eastus - 10.10.0.0/16
```

Subnets were created for domain controllers, management systems, member servers, and workstation testing:

```text
snet-domain-controllers - 10.10.1.0/24
snet-management         - 10.10.2.0/24
snet-member-servers     - 10.10.3.0/24
snet-workstations       - 10.10.4.0/24
```

Network security groups were associated with each subnet:

```text
nsg-srmg-domain-controllers
nsg-srmg-management
nsg-srmg-member-servers
nsg-srmg-workstations
```

The baseline design allows internal communication during the foundation phase so AD DS, DNS, Kerberos, LDAP, SMB, SYSVOL, and Group Policy can function correctly.

Security hardening will be applied progressively in later projects after the core services are validated.

---

### Batch 3 — Windows Server VM Deployment

Three Windows Server VMs were deployed:

| Server | Role | Subnet | Private IP |
|---|---|---|---|
| DC01 | Primary domain controller and DNS | snet-domain-controllers | 10.10.1.10 |
| DC02 | Secondary domain controller and DNS | snet-domain-controllers | 10.10.1.11 |
| MGMT01 | Management server | snet-management | 10.10.2.10 |

Due to B-series quota limitations, **Standard_D2s_v3** was selected for the initial VM deployment.

Domain controllers were not assigned public IP addresses. MGMT01 was used as the management access point.

This design reduces the attack surface by avoiding direct public exposure of domain controllers.

---

### Batch 4 — AD DS, DNS, and Forest Deployment

DC01 was promoted as the first domain controller in a new forest:

```text
corp.democompany1016.local
```

The NetBIOS name is:

```text
CORP
```

DNS was installed as an AD-integrated DNS service.

DC02 was then joined to the domain and promoted as a second domain controller with DNS installed.

The Azure VNet DNS servers were updated to:

```text
10.10.1.10
10.10.1.11
```

This design provides redundancy for authentication and internal DNS resolution.

Internal DNS runs on DC01 and DC02 because AD DS depends heavily on DNS for:

- Domain controller discovery
- Kerberos authentication
- LDAP lookup
- Global Catalog discovery
- Domain join
- Group Policy processing
- SYSVOL and NETLOGON access

A separate standalone internal DNS server was not used because it would add cost and management overhead without enough business value for a 250-user baseline environment.

---

### Batch 5 — MGMT01 Domain Join and Management Tooling

MGMT01 was configured to use DC01 and DC02 for DNS, then joined to:

```text
corp.democompany1016.local
```

RSAT tools were installed for:

- Active Directory administration
- DNS administration
- Group Policy administration

MGMT01 was validated using:

- Active Directory Users and Computers
- DNS Manager
- Group Policy Management
- AD PowerShell module
- SYSVOL access test
- NETLOGON access test

This reduces the need to perform routine administration directly from domain controllers.

---

### Batch 6 — OU, Users, Groups, Admin Accounts, and Service Accounts

A structured OU model was created under:

```text
OU=SRMG,DC=corp,DC=democompany1016,DC=local
```

Final OU structure:

```text
SRMG
├── Admin
│   ├── Tier0
│   ├── Tier1
│   └── Tier2
├── Groups
│   ├── Department
│   ├── FileAccess
│   ├── Admin
│   └── Licensing
├── Service Accounts
├── Users
│   ├── Executives
│   ├── HR
│   ├── Finance
│   ├── IT
│   ├── Sales
│   └── Operations
├── Workstations
├── Servers
│   ├── Management
│   ├── Member Servers
│   └── Application Servers
├── Disabled Objects
└── Staging
```

Department groups were created:

```text
GG-Dept-Executives
GG-Dept-HR
GG-Dept-Finance
GG-Dept-IT
GG-Dept-Sales
GG-Dept-Operations
```

File access groups were created for future file server and Azure Files work:

```text
GG-FS-HR-RW
GG-FS-HR-RO
GG-FS-Finance-RW
GG-FS-Finance-RO
GG-FS-IT-RW
GG-FS-IT-RO
GG-FS-Sales-RW
GG-FS-Sales-RO
GG-FS-Operations-RW
GG-FS-Operations-RO
GG-FS-Public-Modify
```

Admin groups were created:

```text
GG-Admin-Tier0-DomainAdmins
GG-Admin-Tier1-ServerAdmins
GG-Admin-Tier2-Helpdesk
GG-Admin-DNSAdmins
GG-Admin-GPOAdmins
```

Future Microsoft cloud licensing groups were created:

```text
GG-LIC-O365-E3
GG-LIC-O365-E5
GG-LIC-EMS-E5
```

Sample users were created across the following departments:

- Executives
- HR
- Finance
- IT
- Sales
- Operations

Dedicated admin accounts were created:

```text
adm.cloudadmin
adm.serveradmin
adm.helpdesk
```

Disabled service account placeholders were created:

```text
svc-entra-connect
svc-azure-file-sync
svc-app-proxy
```

The service account placeholders were intentionally disabled until needed in later projects.

This structure supports later projects involving Group Policy, delegated administration, file share permissions, Azure Files, Entra Connect, Microsoft 365 licensing, and endpoint management.

---

### Batch 7 — Hybrid-Ready UPN Suffix and Naming Standards

The future public domain was added as an alternate UPN suffix:

```text
summitridge-mfg.com
```

No users were migrated to this suffix during Project 01.

Current user UPN format:

```text
first.last@corp.democompany1016.local
```

Future user UPN format:

```text
first.last@summitridge-mfg.com
```

The user migration is intentionally delayed until a later project because the public domain must first be:

1. Purchased
2. Added to Microsoft 365
3. Verified through public DNS
4. Configured for Exchange Online
5. Tested with pilot users
6. Documented with rollback steps

The internal AD DS domain will remain stable.

This avoids the risk of AD domain rename while still supporting a professional Microsoft 365 sign-in and email domain.

---

### Batch 8 — Final Validation

Final validation confirmed:

- Domain and forest configuration
- DC01 and DC02 availability
- AD-integrated DNS functionality
- DNS resolution for domain controllers and MGMT01
- LDAP and Kerberos SRV records
- AD replication
- Domain controller health checks
- OU structure
- Users and groups
- File access group membership
- MGMT01 management tool access
- SYSVOL and NETLOGON access
- Future UPN suffix readiness

---

## Results & Validation

### Final Architecture

```text
Azure Subscription
└── rg-srmg-hybrid-core
    └── vnet-srmg-hybrid-eastus - 10.10.0.0/16
        │
        ├── snet-domain-controllers - 10.10.1.0/24
        │   ├── DC01 - 10.10.1.10
        │   │   ├── AD DS
        │   │   ├── DNS
        │   │   └── Global Catalog
        │   │
        │   └── DC02 - 10.10.1.11
        │       ├── AD DS
        │       ├── DNS
        │       └── Global Catalog
        │
        ├── snet-management - 10.10.2.0/24
        │   └── MGMT01 - 10.10.2.10
        │       ├── Domain joined
        │       ├── RSAT AD DS tools
        │       ├── DNS Manager
        │       └── Group Policy Management
        │
        ├── snet-member-servers - 10.10.3.0/24
        │   ├── FS01 - Future file server
        │   └── APP01 - Future internal app server
        │
        └── snet-workstations - 10.10.4.0/24
            └── WIN11-CL01 - Future endpoint validation
```

### Domain and DNS Results

| Item | Result |
|---|---|
| AD DS domain | corp.democompany1016.local |
| NetBIOS name | CORP |
| Primary domain controller | DC01 |
| Secondary domain controller | DC02 |
| Internal DNS model | AD-integrated DNS |
| Internal DNS servers | 10.10.1.10, 10.10.1.11 |
| Future public UPN suffix | summitridge-mfg.com |
| Management server | MGMT01 |

### OU and Identity Results

| Area | Result |
|---|---|
| Root OU | SRMG |
| Department users | Created |
| Department groups | Created |
| File access groups | Created |
| Admin groups | Created |
| Licensing groups | Created |
| Dedicated admin accounts | Created |
| Service account placeholders | Created and disabled |
| MGMT01 computer object | Moved to Management Servers OU |

### Key Validation Commands

Domain validation:

```powershell
Get-ADDomain
Get-ADForest
```

Domain controller validation:

```powershell
Get-ADDomainController -Filter *
```

DNS validation:

```powershell
Resolve-DnsName DC01.corp.democompany1016.local
Resolve-DnsName DC02.corp.democompany1016.local
Resolve-DnsName MGMT01.corp.democompany1016.local
Resolve-DnsName microsoft.com
```

AD service record validation:

```powershell
Resolve-DnsName -Type SRV _ldap._tcp.dc._msdcs.corp.democompany1016.local
Resolve-DnsName -Type SRV _kerberos._tcp.corp.democompany1016.local
```

Replication validation:

```powershell
repadmin /replsummary
repadmin /showrepl
```

Domain controller health validation:

```powershell
dcdiag /s:DC01
dcdiag /s:DC02
```

SYSVOL and NETLOGON validation:

```powershell
Test-Path "\\corp.democompany1016.local\SYSVOL"
Test-Path "\\corp.democompany1016.local\NETLOGON"
```

UPN suffix validation:

```powershell
Get-ADForest | Select-Object Name,RootDomain,UPNSuffixes
```

---

## Validation Walkthrough

Validation evidence was collected throughout the project instead of only at the end.

Evidence was captured for:

- Azure budget and cost-control setup
- Resource group creation
- VNet and subnet creation
- NSG creation and subnet association
- VM deployment
- Static private IP assignment
- AD DS and DNS installation
- Forest and domain creation
- DNS forwarder configuration
- AD DNS SRV record validation
- DC02 promotion as an additional domain controller
- Azure VNet custom DNS configuration
- AD replication validation
- dcdiag health checks
- MGMT01 domain join
- RSAT tool installation
- ADUC, DNS Manager, and GPMC access from MGMT01
- SYSVOL and NETLOGON access
- OU structure
- Department groups
- File access groups
- Admin groups
- Licensing groups
- Sample users
- Dedicated admin accounts
- Disabled service account placeholders
- Future UPN suffix configuration
- Final domain, forest, DNS, replication, OU, user, and group exports

Evidence folders:

```text
evidence/screenshots/
evidence/command-outputs/
evidence/validation-notes/
```

Data exports:

```text
data/
```

Implementation notes:

```text
implementation/
```

Important evidence files include:

```text
batch-04-repadmin-replsummary.txt
batch-04-dcdiag-dc01.txt
batch-04-dcdiag-dc02.txt
batch-05-mgmt01-rsat-installed.txt
batch-06-ou-export.csv
batch-06-group-export.csv
batch-06-user-export.csv
batch-07-future-upn-migration-plan.csv
project-01-final-ou-export.csv
project-01-final-group-export.csv
project-01-final-user-export.csv
project-01-final-computer-export.csv
project-01-final-domain-controller-export.csv
```

---

## Key Takeaways

This project created a reusable Windows Server hybrid foundation for a realistic 250-user company.

The project demonstrates more than basic server deployment. It connects infrastructure design to business outcomes.

Key technical outcomes:

- Reliable authentication through two domain controllers
- Resilient internal DNS using AD-integrated DNS
- Reduced public attack surface by avoiding public domain controller exposure
- Cleaner administration through MGMT01 and RSAT
- Scalable identity structure through OUs and security groups
- Future file share readiness through file access groups
- Future Microsoft 365 readiness through licensing groups
- Hybrid identity readiness through a future public UPN suffix
- Lower operational risk by avoiding AD domain rename
- Better cost discipline through budget-aware resource design

Business value created:

- Improves authentication reliability
- Reduces infrastructure confusion
- Creates a clean operating model for a 250-user company
- Supports future Microsoft cloud integration
- Prepares for secure file access and storage modernization
- Reduces risk from poor AD structure and privilege sprawl
- Creates portfolio-ready evidence for Windows Server hybrid administration

This foundation supports the next portfolio projects:

1. Internal and external DNS architecture
2. Custom public domain and Microsoft 365 domain verification
3. UPN and email migration
4. AD DS delegation and Group Policy baseline
5. Hybrid identity synchronization
6. File server to Azure Files migration
7. Entra Application Proxy
8. Azure Arc and monitoring
9. Backup and disaster recovery
10. Intune and endpoint integration
