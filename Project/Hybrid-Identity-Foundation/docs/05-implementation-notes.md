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

## Batch 7 Notes
Two cloud-only emergency access accounts were created and assigned the Global Administrator role.
Usage location was set for the synced pilot users before license assignment.
Microsoft 365 E3 was assigned to the synced E3 pilot licensing group.
Microsoft 365 E5 was assigned to the synced privileged pilot licensing group.
Least-privilege role assignments were applied to the named admin accounts instead of using Global Administrator broadly.

## Batch 8 Notes
A cloud-only SSPR pilot group was created because the portal currently supports one selected group for SSPR scope.
Microsoft Authenticator and mobile phone methods were enabled for authentication and reset scenarios.
Self-service password reset was enabled for the CA-SSPR-Pilot group.
Password writeback was enabled both in Microsoft Entra Connect and in Entra Password reset on-premises integration.
Two Conditional Access policies were created to require MFA for administrators and pilot users, with emergency access accounts excluded.
Policies were first tested in Report-only mode and then enabled after sign-in log validation.
An end-to-end password reset test confirmed that a cloud-initiated password reset was written back to on-prem AD.

## Deployment Principle
The Azure subscription is used only to host infrastructure.
The identity target remains the Microsoft 365 tenant democompany1016.onmicrosoft.com.
The lab used constrained VM sizing due to subscription and free-trial limits.
This was an intentional cost-control decision and did not change the core identity architecture being demonstrated.
