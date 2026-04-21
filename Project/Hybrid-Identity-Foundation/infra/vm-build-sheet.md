# VM Build Sheet

## Azure Resource Plan
- Resource Group: rg-hybrid-identity-lab
- Region: pick one close to you
- Virtual Network: vnet-hybrid-identity
- Subnet: snet-core
- Network Security Group: nsg-hybrid-identity-management

## Planned VMs
1. ADC-01
   - Role: Active Directory Domain Services, DNS
   - OS: Windows Server
   - Notes: static private IP

2. MGMT-01
   - Role: Management server, RSAT, Microsoft Entra Connect Sync
   - OS: Windows Server
   - Notes: domain joined member server

## Planned Domain
- Internal AD domain: corp.democompany1016.local

## Identity Model
- 1 emergency cloud-only account
- 2 privileged admin accounts
- 1 helpdesk/admin operations account
- 1 licensing/admin operations account
- 50–75 employee identities represented
