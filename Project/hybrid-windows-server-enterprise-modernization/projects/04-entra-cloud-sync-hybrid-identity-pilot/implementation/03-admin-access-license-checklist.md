# Admin Access and License Checklist

## Purpose

This checklist confirms the administrative access, licensing, and infrastructure required for the Microsoft Entra Cloud Sync pilot.

## Required Portals

| Portal | Purpose |
|---|---|
| Microsoft Entra admin center | Configure Cloud Sync and validate synchronized users |
| Microsoft 365 admin center | Validate users, domains, and licenses |
| Active Directory Users and Computers | Validate pilot users and OU placement |
| MGMT01 / Windows Server tools | Run AD validation and install/manage agent if needed |

## Required Tenant

```text
democompany1016.onmicrosoft.com
```

## Verified Public Domain

```text
summitridge-mfg.com
```

## Required Licenses

| License | Purpose |
|---|---|
| Office 365 E3 trial | Microsoft 365 user/mailbox readiness |
| Office 365 E5 trial | Advanced Microsoft 365 service validation |
| EMS E5 trial | Microsoft Entra identity/security features |

## Required Admin Roles

Recommended admin role:

```text
Hybrid Identity Administrator
```

Acceptable lab role:

```text
Global Administrator
```

## Required On-Premises Access

| Requirement | Status |
|---|---|
| Domain admin or delegated AD admin access | Required |
| Access to MGMT01 | Required |
| Access to DC01/DC02 validation tools | Required |
| Ability to read AD users, OUs, and attributes | Required |
| Ability to install provisioning agent later | Required |

## Access Checklist

- [ ] Can access Microsoft Entra admin center
- [ ] Can access Microsoft 365 admin center
- [ ] Can access MGMT01
- [ ] Can run Active Directory PowerShell
- [ ] Can validate pilot users in AD
- [ ] Can validate summitridge-mfg.com in Microsoft Entra ID
- [ ] Can download Microsoft Entra provisioning agent later
- [ ] Can install agent on approved Windows Server
- [ ] Can create scoped Cloud Sync configuration
- [ ] Can validate synchronized users in Microsoft Entra ID

## Safety Rule

Do not sync the full directory during the pilot.

Start with a narrow pilot scope only.

## Business Value

Confirming access and licensing before sync reduces deployment risk and prevents a failed or incomplete Cloud Sync configuration.
