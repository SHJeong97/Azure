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

## Deployment Principle
The Azure subscription is used only to host infrastructure.
The identity target remains the Microsoft 365 tenant democompany1016.onmicrosoft.com.
