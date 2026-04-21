# Implementation Notes

## Batch 2 Scope
This batch deploys the Azure infrastructure hosting layer for the hybrid identity lab.

Resources deployed:
- Resource group
- Virtual network
- Subnet
- Network security group
- Two Windows Server VMs

Resources not yet configured:
- Active Directory Domain Services
- DNS design validation
- Domain join
- Microsoft Entra Connect Sync
- Microsoft 365 identity controls

## Batch 3 Notes
ADC-01 was promoted as the first domain controller in a new forest.
The internal Active Directory domain name is corp.democompany1016.local.
DNS was installed during promotion.
The Azure virtual network was reconfigured to use ADC-01 as the custom DNS server so that later member-server domain joins use Active Directory-integrated name resolution.

## Batch 4 Notes
MGMT-01 was joined to corp.democompany1016.local as a member server.
The server was then used as the first remote administration host rather than performing all management directly from the domain controller.
Remote Server Administration Tools were installed to support AD, DNS, and Group Policy administration from MGMT-01.
This separates service hosting from routine administration and better reflects an operational model than a single-box-only lab.

## Deployment Principle
The Azure subscription is used only to host infrastructure.
The identity target remains the Microsoft 365 tenant democompany1016.onmicrosoft.com.
The lab used constrained VM sizing due to subscription and free-trial limits.
This was an intentional cost-control decision and did not change the core identity architecture being demonstrated.
