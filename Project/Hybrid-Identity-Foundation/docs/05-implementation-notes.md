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

## Batch 5 Notes
An alternate UPN suffix of democompany1016.onmicrosoft.com was added to the on-prem AD forest to prepare for hybrid synchronization.
A staged pilot identity population was created rather than a full 75-user import.
The directory was structured with separate OUs for users, groups, admins, servers, workstations, and service accounts.
Security groups were separated into department, licensing, and role groups.
Named privileged accounts were created separately from standard user accounts.
Emergency access accounts were intentionally not created in on-prem AD and remain a future cloud-only task.

## Batch 6 Notes
Microsoft Entra Connect Sync was installed on MGMT-01 using a custom installation.
Password Hash Synchronization was selected as the sign-in method.
OU-based filtering was used to scope the pilot to Employees, Groups, and Admins.
Synchronization was not started automatically at the end of the wizard.
The first synchronization cycle was triggered manually using Start-ADSyncSyncCycle -PolicyType Initial.
Pilot users and groups were then validated in the target tenant democompany1016.onmicrosoft.com.

## Deployment Principle
The Azure subscription is used only to host infrastructure.
The identity target remains the Microsoft 365 tenant democompany1016.onmicrosoft.com.
The lab used constrained VM sizing due to subscription and free-trial limits.
This was an intentional cost-control decision and did not change the core identity architecture being demonstrated.
