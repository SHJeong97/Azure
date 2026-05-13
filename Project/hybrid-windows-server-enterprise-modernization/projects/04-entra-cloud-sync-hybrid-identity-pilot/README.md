# Project 04 — Microsoft Entra Cloud Sync for Hybrid Identity Pilot

## Introduction

This project implements a controlled Microsoft Entra Cloud Sync pilot for Summit Ridge Manufacturing Group, a simulated 250-user hybrid organization using on-premises Active Directory and Microsoft 365.

Project 03 created the Microsoft 365 custom domain foundation and changed selected on-premises AD pilot users to the verified public UPN suffix:

```text
summitridge-mfg.com
```

However, those AD changes did not automatically create Microsoft 365 cloud users. Project 04 solves that identity gap by configuring Microsoft Entra Cloud Sync to synchronize selected on-premises AD users into Microsoft Entra ID.

The project uses a scoped pilot approach instead of full-directory synchronization to reduce business risk.

---

## Objectives

- Deploy Microsoft Entra Cloud Sync for a hybrid identity pilot
- Install the Microsoft Entra provisioning agent on MGMT01
- Resolve KDS/gMSA prerequisites required for provisioning agent setup
- Configure scoped AD-to-Microsoft Entra ID synchronization
- Limit synchronization scope to a pilot security group
- Validate pilot users in on-premises AD before sync
- Validate synchronized users in Microsoft Entra ID after sync
- Confirm UPN, attribute, and sync status behavior
- Validate password hash sync readiness
- Prepare users for future Microsoft 365 licensing
- Defer Exchange Online mailbox enablement to the next project
- Document rollback, monitoring, and operational controls

---

## Full Implementation

Project 04 was implemented in eight batches:

| Batch | Focus |
|---|---|
| Batch 1 | Project scope, sync design decision, licensing, and folder structure |
| Batch 2 | Pre-sync AD health and pilot OU readiness |
| Batch 3 | Microsoft Entra provisioning agent installation on MGMT01 |
| Batch 4 | Scoped Cloud Sync configuration from AD to Microsoft Entra ID |
| Batch 5 | Pilot sync execution and cloud user creation validation |
| Batch 6 | UPN, attribute, license, and sign-in readiness validation |
| Batch 7 | Sync risk controls, rollback, and operational monitoring |
| Batch 8 | Final validation and README package |

---

## Implementation Walkthrough

### Business Scenario

Summit Ridge Manufacturing Group needed a controlled way to synchronize selected on-premises AD users into Microsoft Entra ID.

The company already had:

| Component | Value |
|---|---|
| Internal AD DS domain | corp.democompany1016.local |
| Microsoft 365 tenant | democompany1016.onmicrosoft.com |
| Verified public domain | summitridge-mfg.com |
| Pilot UPN suffix | summitridge-mfg.com |
| Sync method selected | Microsoft Entra Cloud Sync |

The business problem was that on-premises AD pilot users had professional UPNs, but they did not exist in Microsoft 365 until identity synchronization was configured.

---

### Architecture

```text
+------------------------------+
| On-Premises Active Directory |
| corp.democompany1016.local   |
+---------------+--------------+
                |
                |
                v
+------------------------------+
| Pilot Sync Group             |
| GRP-EntraCloudSync-Pilot     |
| Direct members only          |
+---------------+--------------+
                |
                |
                v
+------------------------------+
| MGMT01                       |
| Microsoft Entra              |
| Provisioning Agent           |
+---------------+--------------+
                |
                |
                v
+------------------------------+
| Microsoft Entra ID           |
| democompany1016.onmicrosoft.com |
| summitridge-mfg.com users    |
+------------------------------+
```

---

### Pilot Users

| User | Department | Synced UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

The pilot users were selected to represent business, sensitive, and technical departments.

---

### Sync Design Decision

Microsoft Entra Cloud Sync was selected instead of full Microsoft Entra Connect Sync because the project needed a lightweight, modern, cloud-managed synchronization approach.

The design avoided:

- Full-directory synchronization
- Broad OU synchronization
- Nested group scoping
- Unnecessary attribute mapping customization
- Early license assignment
- Early mailbox enablement

The pilot scope used one AD security group:

```text
GRP-EntraCloudSync-Pilot
```

Only direct user members were used because nested group members are not included in Cloud Sync group scoping.

---

### Pre-Sync Validation

Before installing or configuring sync, the AD environment was validated.

Validation included:

- Admin session context
- AD domain health
- AD forest and UPN suffix
- Domain controller inventory
- AD replication health
- Internal DNS resolution
- Microsoft cloud endpoint resolution
- Pilot user existence
- Pilot user enabled state
- Pilot group direct membership
- Existing Microsoft Entra cloud-user conflict check

The verified public UPN suffix was confirmed:

```text
summitridge-mfg.com
```

The pilot users were confirmed in AD with the correct UPN format.

---

### Provisioning Agent Installation

The Microsoft Entra provisioning agent was installed on:

```text
MGMT01
```

During setup, the installer could not create the required gMSA because the KDS Root Key was missing or not ready.

The issue was resolved by validating and creating the KDS Root Key on DC01.

Key remediation actions included:

```powershell
Get-Service KdsSvc
Start-Service KdsSvc
Set-Service KdsSvc -StartupType Automatic
Get-KdsRootKey
Add-KdsRootKey -EffectiveTime ((Get-Date).AddHours(-10))
```

After the KDS/gMSA issue was resolved, the provisioning agent setup completed successfully.

The gMSA used for the provisioning agent was documented as:

```text
corp.democompany1016.local\provAgentgMSA
```

---

### Scoped Cloud Sync Configuration

The Cloud Sync configuration was created in Microsoft Entra admin center.

Configuration details:

| Setting | Value |
|---|---|
| Sync direction | Active Directory to Microsoft Entra ID |
| AD domain | corp.democompany1016.local |
| Provisioning agent | MGMT01 |
| Scope method | Selected security group |
| Pilot group | GRP-EntraCloudSync-Pilot |
| Password hash sync | Enabled |
| Exchange hybrid writeback | Disabled |

The configuration status was validated as healthy.

---

### On-Demand Provisioning Test

Before enabling the scoped sync configuration, on-demand provisioning was tested with Emma Wilson.

The exact AD Distinguished Name was required:

```text
CN=Emma Wilson,OU=HR,OU=Users,OU=SRMG,DC=corp,DC=democompany1016,DC=local
```

This confirmed that the project used the real AD OU structure instead of assuming all users were directly under `OU=Users`.

After the on-demand test, the scoped configuration was enabled.

---

### Pilot Sync Validation

After Cloud Sync was enabled, the pilot users were validated in Microsoft Entra ID using Microsoft Graph PowerShell.

Validation checked:

- Cloud user existence
- UserPrincipalName
- AccountEnabled
- OnPremisesSyncEnabled
- OnPremisesImmutableId
- UsageLocation
- Department
- JobTitle
- Assigned license count

Expected successful result:

```text
CloudUserFound = Yes
OnPremisesSyncEnabled = True
UserPrincipalName = first.last@summitridge-mfg.com
```

---

### License and Sign-In Readiness

UsageLocation was validated and set to:

```text
US
```

Licenses were intentionally not assigned in Project 04.

License assignment was deferred to:

```text
Project 05 — Microsoft 365 Licensing, Exchange Online Mailbox Enablement, and Address Standardization
```

This separation avoids creating mailboxes or enabling Microsoft 365 services before identity synchronization is validated.

---

### Rollback and Monitoring

Rollback and monitoring controls were documented.

Rollback strategy:

1. Disable the Cloud Sync configuration.
2. Confirm provisioning stops.
3. Review provisioning logs.
4. Confirm pilot group membership.
5. Remove users from the pilot sync group only if needed.
6. Avoid deleting cloud users until impact is understood.
7. Restore pilot membership if the issue is resolved.

Rollback helper scripts created:

```text
scripts/powershell/remove-pilot-users-from-sync-group.ps1
scripts/powershell/restore-pilot-users-to-sync-group.ps1
```

Operational monitoring included:

- Provisioning agent service health
- AD replication health
- Pilot sync group membership
- Nested group validation
- Synced user validation
- Provisioning logs
- Configuration health
- Accidental-delete protection

---

## Results & Validation

### Final Technical Result

Project 04 successfully configured a scoped Microsoft Entra Cloud Sync pilot.

| Validation Area | Result |
|---|---|
| Provisioning agent | Installed on MGMT01 |
| KDS/gMSA issue | Resolved |
| Cloud Sync configuration | Created and enabled |
| Configuration status | Healthy |
| Password hash sync | Enabled |
| Exchange hybrid writeback | Disabled |
| Sync scope | GRP-EntraCloudSync-Pilot |
| Nested groups | Not used |
| Pilot users | Synchronized to Microsoft Entra ID |
| UsageLocation | Validated/set to US |
| Licensing | Deferred to Project 05 |
| Mailbox enablement | Deferred to Project 05 |
| Rollback controls | Documented |
| Monitoring controls | Documented |

---

### Final Synced Identity Result

| User | AD UPN | Microsoft Entra UPN | Result |
|---|---|---|---|
| Emma Wilson | emma.wilson@summitridge-mfg.com | emma.wilson@summitridge-mfg.com | Synced |
| Olivia Brown | olivia.brown@summitridge-mfg.com | olivia.brown@summitridge-mfg.com | Synced |
| Sophia Martinez | sophia.martinez@summitridge-mfg.com | sophia.martinez@summitridge-mfg.com | Synced |

---

### Final Architecture Summary

| Component | Configuration | Result |
|---|---|---|
| AD DS domain | corp.democompany1016.local | Validated |
| Public UPN suffix | summitridge-mfg.com | Validated |
| Provisioning agent server | MGMT01 | Installed and validated |
| Sync method | Microsoft Entra Cloud Sync | Configured |
| Sync direction | Active Directory to Microsoft Entra ID | Configured |
| Pilot scope method | Selected security group | Configured |
| Pilot sync group | GRP-EntraCloudSync-Pilot | Validated |
| Nested groups | Not used | Validated |
| Password hash sync | Enabled | Validated |
| Pilot cloud users | Three users synchronized | Validated |
| Licensing | Deferred to Project 05 | Documented |
| Exchange mailbox enablement | Deferred to Project 05 | Documented |
| Rollback controls | Documented | Completed |
| Monitoring controls | Documented | Completed |

---

## Validation Walkthrough

### Evidence Folders

Evidence was stored under:

```text
C:\LabEvidence\Project04\Batch01
C:\LabEvidence\Project04\Batch02
C:\LabEvidence\Project04\Batch03
C:\LabEvidence\Project04\Batch04
C:\LabEvidence\Project04\Batch05
C:\LabEvidence\Project04\Batch06
C:\LabEvidence\Project04\Batch07
C:\LabEvidence\Project04\Batch08
```

GitHub evidence was organized under:

```text
projects/04-entra-cloud-sync-hybrid-identity-pilot/evidence/
```

---

### Key Validation Outputs

| Evidence File | Purpose |
|---|---|
| batch-02-pilot-ad-user-validation.csv | Validated pilot users in AD |
| batch-02-cloud-user-conflict-check.csv | Confirmed no direct cloud UPN conflicts before sync |
| batch-03-kds-root-key-validation.txt | Confirmed KDS Root Key readiness |
| batch-03-provisioning-agent-services-after-install.txt | Validated provisioning agent service state |
| batch-04-cloud-pilot-user-lookup-after-enable.csv | Checked cloud users after enabling sync |
| batch-05-ad-to-cloud-pilot-comparison.csv | Compared AD users to cloud users |
| batch-06-final-license-readiness-decision.csv | Documented license readiness and deferral |
| batch-07-final-operational-readiness-summary.txt | Documented monitoring and rollback readiness |
| project-04-final-synced-pilot-users.csv | Final synced pilot user validation |
| project-04-final-ad-to-cloud-validation.csv | Final AD-to-cloud comparison |
| project-04-final-validation-checklist.csv | Final validation checklist |
| project-04-final-architecture-summary.csv | Final architecture summary |

---

### Validation Commands

Example AD validation:

```powershell
Import-Module ActiveDirectory

Get-ADGroupMember "GRP-EntraCloudSync-Pilot" |
Select-Object Name,SamAccountName,objectClass,DistinguishedName
```

Example Microsoft Entra validation:

```powershell
Connect-MgGraph -Scopes "User.Read.All","Directory.Read.All","Domain.Read.All"

Get-MgUser -Filter "userPrincipalName eq 'emma.wilson@summitridge-mfg.com'" `
  -Property DisplayName,UserPrincipalName,AccountEnabled,OnPremisesSyncEnabled,UsageLocation
```

Example provisioning agent validation:

```powershell
Get-Service |
Where-Object {
    $_.Name -like "*AAD*" -or
    $_.DisplayName -like "*Microsoft Entra*" -or
    $_.DisplayName -like "*Azure AD*" -or
    $_.DisplayName -like "*Provisioning*"
} |
Select-Object Name,DisplayName,Status,StartType
```

Example AD replication validation:

```powershell
repadmin /replsummary
```

---

## Key Takeaways

- Microsoft Entra Cloud Sync solved the AD-to-cloud identity gap identified in Project 03.
- A scoped pilot sync was safer than full-directory synchronization.
- The provisioning agent required KDS/gMSA readiness before installation could complete.
- The actual AD Distinguished Name mattered during on-demand provisioning.
- The pilot group used direct users only because nested groups are not included in Cloud Sync group scoping.
- Password hash sync was enabled to prepare users for Microsoft 365 sign-in readiness.
- UsageLocation was validated before future license assignment.
- Licensing and mailbox enablement were intentionally deferred to Project 05.
- Rollback and monitoring controls were documented before expanding the sync scope.

---

## Business Value

This project created a controlled hybrid identity foundation for Summit Ridge Manufacturing Group.

The company can now synchronize selected on-premises AD users into Microsoft Entra ID using professional UPNs:

```text
first.last@summitridge-mfg.com
```

This enables future Microsoft 365 licensing, Exchange Online mailbox provisioning, Intune enrollment, Conditional Access, Identity Protection, and Zero Trust access controls with a validated identity baseline.
