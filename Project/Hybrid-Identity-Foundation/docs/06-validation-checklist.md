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

## Batch 7 Validation
- Two cloud-only emergency access accounts created
- Emergency access accounts assigned Global Administrator
- Pilot synced users have Usage location set
- E3 license assigned to GG-Lic-M365-E3-Pilot
- E5 license assigned to GG-Lic-M365-E5-Privileged-Pilot
- Emma Reed inherits E3
- Named admin accounts inherit E5
- Hybrid Identity Administrator assigned to adm.olivia.kim
- License Administrator assigned to adm.ethan.park
- Password Administrator assigned to adm.isabella.chen

- ## Batch 8 Validation
- CA-SSPR-Pilot cloud group created
- Break-glass accounts excluded from SSPR pilot and CA policies
- Microsoft Authenticator enabled
- Mobile phone enabled for fallback/reset
- SSPR enabled for selected pilot group
- Password writeback enabled in Entra Connect
- Password writeback enabled in Password reset on-premises integration
- Admin MFA CA policy created and validated
- Pilot user MFA CA policy created and validated
- Report-only results confirmed in sign-in logs
- Both CA policies enabled
- Emma Reed completed SSPR
- Emma Reed password reset wrote back to on-prem AD
