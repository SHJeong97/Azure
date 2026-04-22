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

## Batch 6 Validation
- Microsoft Entra Connect installed on MGMT-01
- ADSync service present
- Scheduler present
- Staging mode disabled
- Password Hash Sync selected
- Pilot OU filtering configured
- Initial sync triggered manually
- Pilot users appear in Microsoft Entra ID
- Pilot groups appear in Microsoft Entra ID
- No emergency access account synchronized from on-prem AD

## Batch 7 Notes
Two cloud-only emergency access accounts were created and assigned the Global Administrator role.
Usage location was set for the synced pilot users before license assignment.
Microsoft 365 E3 was assigned to the synced E3 pilot licensing group.
Microsoft 365 E5 was assigned to the synced privileged pilot licensing group.
Least-privilege role assignments were applied to the named admin accounts instead of using Global Administrator broadly.
