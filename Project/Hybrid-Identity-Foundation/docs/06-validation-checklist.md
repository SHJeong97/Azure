# Validation Checklist

## Batch 2 Validation
- Resource group created
- Virtual network created
- Subnet created
- NSG created
- ADC-01 deployed
- MGMT-01 deployed
- Both VMs reachable by RDP
- Both VMs renamed correctly if needed
- Static private IP assigned to ADC-01
- VM roles documented
- Screenshots collected

## Batch 4 Validation
- MGMT-01 joined to corp.democompany1016.local
- MGMT-01 restarted successfully after join
- Domain sign-in works on MGMT-01
- RSAT tools installed on MGMT-01
- Active Directory Users and Computers opens from MGMT-01
- DNS Manager opens from MGMT-01
- Group Policy Management opens from MGMT-01
- Get-ADDomain works from MGMT-01
- Name resolution from MGMT-01 to ADC-01 works

## Batch 5 Validation
- Alternate UPN suffix added
- OU structure created
- Department groups created
- Licensing groups created
- Role groups created
- Pilot employee users created
- Named admin accounts created
- User UPNs use democompany1016.onmicrosoft.com
- Standard users are members of department and licensing groups
- Admin users are members of role and privileged licensing groups

## Batch 6 Notes
Microsoft Entra Connect Sync was installed on MGMT-01 using a custom installation.
Password Hash Synchronization was selected as the sign-in method.
OU-based filtering was used to scope the pilot to Employees, Groups, and Admins.
Synchronization was not started automatically at the end of the wizard.
The first synchronization cycle was triggered manually using Start-ADSyncSyncCycle -PolicyType Initial.
Pilot users and groups were then validated in the target tenant democompany1016.onmicrosoft.com.
