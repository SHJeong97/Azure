# Pilot Sync Cloud User Validation

## Purpose

This document records the Microsoft Entra Cloud Sync pilot user validation result.

## Sync Configuration

| Item | Value |
|---|---|
| Sync direction | Active Directory to Microsoft Entra ID |
| AD domain | corp.democompany1016.local |
| Tenant | democompany1016.onmicrosoft.com |
| Provisioning agent server | MGMT01 |
| Scope method | Selected security group |
| Pilot group | GRP-EntraCloudSync-Pilot |

## Pilot Users

| User | Expected Cloud UPN |
|---|---|
| Emma Wilson | emma.wilson@summitridge-mfg.com |
| Olivia Brown | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | sophia.martinez@summitridge-mfg.com |

## Validation Performed

Validation included:

- AD pilot group membership validation
- AD pilot user UPN validation
- Cloud Sync restart from Microsoft Entra admin center
- Microsoft Graph pilot user lookup
- Microsoft Entra provisioning log review
- AD-to-cloud identity comparison
- Scope validation for users with summitridge-mfg.com UPNs

## Expected Successful Result

Each pilot user should exist in Microsoft Entra ID with:

```text
first.last@summitridge-mfg.com
```

and should show as synchronized from on-premises Active Directory.

## Scope Safety

Only the pilot group was used for Cloud Sync scope.

The full directory was not synchronized.

Nested groups were not used.

## Business Risk

Sync validation is important because incorrect scoping or provisioning errors can cause:

- Missing cloud users
- Duplicate cloud users
- Wrong UPNs
- Licensing confusion
- Helpdesk impact
- Accidental broad synchronization

## Risk Treatment

The project reduced risk by:

- Using a three-user pilot
- Validating AD users before sync
- Checking for cloud conflicts before sync
- Testing provisioning before broader validation
- Reviewing provisioning logs
- Comparing AD and cloud identity state after sync

## Business Value

This pilot confirms that Summit Ridge can synchronize selected on-premises AD users into Microsoft Entra ID using professional UPNs before expanding sync to more users.
