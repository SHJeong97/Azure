# Admin Access and License Checklist

## Purpose

This checklist confirms the administrative access and licensing needed for Project 03.

## Required Admin Portals

| Portal | Purpose |
|---|---|
| Microsoft 365 admin center | Add and verify custom domain |
| Microsoft Entra admin center | Validate custom domain and users |
| Exchange admin center | Plan email addresses and mail flow |
| Public DNS host / registrar | Add DNS verification and service records |

## Required Domain

```text
summitridge-mfg.com
```

## Current Tenant

```text
democompany1016.onmicrosoft.com
```

## Required Licenses

The lab can use existing trial licenses:

| License | Purpose |
|---|---|
| Office 365 E3 trial | Microsoft 365 users and Exchange Online |
| Office 365 E5 trial | Advanced Microsoft 365 / Exchange features |
| EMS E5 trial | Entra ID and identity/security features |

## Access Checklist

- [ ] Can access Microsoft 365 admin center
- [ ] Can access Microsoft Entra admin center
- [ ] Can access Exchange admin center
- [ ] Can access public DNS host for summitridge-mfg.com
- [ ] Can edit TXT records
- [ ] Can edit MX records
- [ ] Can edit CNAME records
- [ ] Can edit SPF/DKIM/DMARC TXT records
- [ ] Can validate DNS records from PowerShell
- [ ] Can sign in as a global administrator or equivalent test admin

## Important Safety Rule

Do not change MX records until Exchange Online mailbox readiness and rollback planning are complete.

## Business Value

Confirming admin access before changes prevents delays and reduces the risk of incomplete domain verification or failed mail flow changes.
