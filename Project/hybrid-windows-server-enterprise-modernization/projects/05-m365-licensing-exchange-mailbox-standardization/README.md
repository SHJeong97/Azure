
# Project 05 — Microsoft 365 Licensing, Exchange Online Mailbox Enablement, and Address Standardization

## Introduction

This project activates Microsoft 365 services for the synchronized pilot users created in Project 04.

Project 04 synchronized selected on-premises Active Directory users into Microsoft Entra ID using Microsoft Entra Cloud Sync. Project 05 continues that lifecycle by assigning Microsoft 365 licenses, validating Exchange Online mailbox provisioning, standardizing primary SMTP addresses, validating mail-flow readiness, and documenting rollback/monitoring controls.

The project uses a controlled pilot approach with three synchronized users instead of broad tenant-wide licensing.

---

## Objectives

- Validate synced pilot users before Microsoft 365 license assignment
- Confirm UsageLocation and license readiness
- Export available Microsoft 365 tenant license SKUs
- Create a dedicated pilot licensing group
- Assign Microsoft 365 licenses using group-based licensing
- Validate Exchange Online mailbox provisioning
- Standardize primary SMTP addresses with `summitridge-mfg.com`
- Validate mailbox aliases and proxy addresses
- Validate MX, SPF, DMARC, and Autodiscover readiness
- Test or document Outlook on the web and mail-flow readiness
- Review message trace and mailbox statistics
- Document rollback and monitoring controls

---

## Full Implementation

Project 05 was implemented in eight batches:

| Batch | Focus |
|---|---|
| Batch 1 | Project scope, licensing/mailbox design, and folder structure |
| Batch 2 | Pre-license validation for synced pilot users |
| Batch 3 | Create licensing group and assign Microsoft 365 license |
| Batch 4 | Validate mailbox provisioning in Exchange Online |
| Batch 5 | Standardize primary SMTP and aliases |
| Batch 6 | Mail-flow validation and Outlook/Autodiscover readiness |
| Batch 7 | License/mailbox rollback, risk controls, and monitoring |
| Batch 8 | Final validation and GitHub-ready README package |

---

## Implementation Walkthrough

### Business Scenario

Summit Ridge Manufacturing Group completed a hybrid identity pilot in Project 04. The pilot users existed in Microsoft Entra ID, but they did not yet have Microsoft 365 service access or Exchange Online mailboxes.

Project 05 activates those cloud services while keeping the rollout limited to a controlled pilot group.

| Area | Value |
|---|---|
| Microsoft 365 tenant | `democompany1016.onmicrosoft.com` |
| Verified public domain | `summitridge-mfg.com` |
| Identity source | On-premises AD synced through Microsoft Entra Cloud Sync |
| Licensing method | Group-based licensing |
| Pilot licensing group | `GRP-M365-E5-Pilot-License` |
| Mail platform | Exchange Online |

---

### Architecture

```text
+------------------------------+
| On-Premises Active Directory |
| corp.democompany1016.local   |
+---------------+--------------+
                |
                | Microsoft Entra Cloud Sync
                v
+------------------------------+
| Microsoft Entra ID           |
| Synced pilot identities      |
+---------------+--------------+
                |
                | Group-based licensing
                v
+------------------------------+
| GRP-M365-E5-Pilot-License    |
| Three pilot users only       |
+---------------+--------------+
                |
                | Microsoft 365 license assignment
                v
+------------------------------+
| Exchange Online              |
| User mailboxes provisioned   |
+---------------+--------------+
                |
                | Standardized SMTP
                v
+------------------------------+
| first.last@summitridge-mfg.com |
+------------------------------+
```

---

### Pilot Users

| User | Department | UPN | Primary SMTP |
|---|---|---|---|
| Emma Wilson | HR | `emma.wilson@summitridge-mfg.com` | `emma.wilson@summitridge-mfg.com` |
| Olivia Brown | Finance | `olivia.brown@summitridge-mfg.com` | `olivia.brown@summitridge-mfg.com` |
| Sophia Martinez | IT | `sophia.martinez@summitridge-mfg.com` | `sophia.martinez@summitridge-mfg.com` |

---

### Licensing Design

The project used group-based licensing instead of broad direct-user licensing.

Licensing group:

```text
GRP-M365-E5-Pilot-License
```

The group contained only the three pilot users.

Target license preference order:

```text
ENTERPRISEPREMIUM
SPE_E5
ENTERPRISEPACK
```

This approach reduces the risk of accidentally licensing unrelated users and provides a scalable model for future rollout.

---

### Pre-License Validation

Before assigning licenses, the project validated:

- Pilot users existed in Microsoft Entra ID
- Users were synchronized from on-premises AD
- UsageLocation was set to `US`
- Users were enabled
- Assigned license count was checked
- Available Microsoft 365 SKUs were exported
- The target pilot SKU was selected
- Exchange Online accepted domain was validated
- Pre-license mailbox state was checked
- Recipient address conflicts were reviewed

Expected pre-license state:

```text
CloudUserFound = Yes
OnPremisesSyncEnabled = True
UsageLocation = US
AssignedLicenseCount = 0
MailboxFound = No
```

---

### Exchange Online Connection Method

The lab server experienced a WAM/MSAL broker issue with the default Exchange Online connection method.

Device-code authentication was used:

```powershell
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -Device -ShowBanner:$false
```

This became the standard Exchange Online PowerShell connection method for the rest of Project 05.

---

### License Assignment

The pilot licensing group was created in Microsoft Entra ID / Microsoft 365:

```text
GRP-M365-E5-Pilot-License
```

The three pilot users were added to the group.

The selected Microsoft 365 license was assigned to the group through Microsoft 365 admin center group-based licensing.

Validation confirmed:

- The group had an assigned license
- Pilot users inherited the license
- Pilot users showed an assigned license count
- Service plan details were exported
- Exchange-related service plans were present

---

### Mailbox Provisioning Validation

After license assignment, Exchange Online mailbox provisioning was validated.

Validation included:

- Pilot mailbox lookup
- Recipient validation
- Mailbox statistics export
- Primary SMTP export
- EmailAddresses/proxy address export
- Accepted domain and mailbox readiness summary

Expected mailbox result:

```text
RecipientTypeDetails = UserMailbox
```

New mailboxes may show:

```text
ItemCount = 0
LastLogonTime = blank
```

That is expected until the user signs in, sends mail, or receives mail.

---

### Primary SMTP and Alias Standardization

Because the pilot users are synchronized from on-premises Active Directory, the project treated AD as the source of authority for mail-related attributes.

The following AD attributes were updated:

```text
mail
proxyAddresses
```

Target primary SMTP format:

```text
first.last@summitridge-mfg.com
```

Alias strategy:

| Address Type | Format |
|---|---|
| Primary SMTP | `SMTP:first.last@summitridge-mfg.com` |
| Tenant alias | `smtp:first.last@democompany1016.onmicrosoft.com` |

The internal AD domain was not added as an SMTP proxy address.

Cloud Sync was restarted after the AD address update so Microsoft Entra ID and Exchange Online could reflect the standardized values.

---

### Mail DNS and Client Readiness

The project checked mail-related DNS readiness for:

| Record | Purpose |
|---|---|
| MX | Routes inbound mail to Microsoft 365 |
| SPF | Authorizes Microsoft 365 to send mail for the domain |
| DMARC | Provides domain-level email authentication monitoring |
| Autodiscover | Supports Outlook and Exchange client discovery |

DKIM was documented as a future action unless selector CNAME records are created and DKIM is enabled.

Missing DKIM selector records were not treated as a mailbox provisioning failure.

---

### Mail-Flow Validation

The project created a mail-flow test plan:

| Test ID | Sender | Recipient | Purpose |
|---|---|---|---|
| MF-001 | `emma.wilson@summitridge-mfg.com` | `olivia.brown@summitridge-mfg.com` | Internal pilot mail flow |
| MF-002 | `olivia.brown@summitridge-mfg.com` | `emma.wilson@summitridge-mfg.com` | Reverse internal pilot mail flow |
| MF-003 | Admin mailbox | `sophia.martinez@summitridge-mfg.com` | Admin-to-pilot readiness |

Message trace was reviewed using Exchange Online PowerShell:

```powershell
Get-MessageTraceV2
```

Message trace results may take several minutes to appear after messages are sent.

---

### Rollback and Monitoring

Rollback and monitoring controls were created before expanding the rollout.

Rollback helper scripts:

```text
scripts/powershell/remove-pilot-users-from-license-group.ps1
scripts/powershell/restore-pilot-users-to-license-group.ps1
```

Monitoring helper scripts:

```text
scripts/powershell/monitor-pilot-license-state.ps1
scripts/powershell/monitor-pilot-mailbox-state.ps1
```

Rollback principles:

1. Confirm the issue.
2. Export current license and mailbox state.
3. Remove only the affected user from the licensing group if needed.
4. Wait for license assignment state to update.
5. Validate mailbox state.
6. Restore the user to the licensing group if rollback was temporary.
7. Document the final state.

The project did not delete cloud users, delete mailboxes, or remove licenses during rollback planning.

---

## Results & Validation

### Final Technical Result

Project 05 successfully licensed the three synchronized pilot users, provisioned Exchange Online mailboxes, standardized primary SMTP addresses, and validated mail readiness.

| Validation Area | Result |
|---|---|
| Pilot licensing group | Created |
| Group-based licensing | Implemented |
| Pilot users licensed | Completed |
| Exchange Online mailbox provisioning | Validated |
| Recipient type | `UserMailbox` |
| Primary SMTP standard | `first.last@summitridge-mfg.com` |
| AD source attributes | `mail` and `proxyAddresses` updated |
| MX readiness | Checked |
| SPF readiness | Checked |
| DMARC readiness | Checked |
| Autodiscover readiness | Checked |
| Mail-flow plan | Created |
| Message trace | Reviewed or documented |
| Rollback controls | Created |
| Monitoring controls | Created |

---

### Final Pilot User Results

| User | License State | Mailbox State | Primary SMTP | Final Status |
|---|---|---|---|---|
| Emma Wilson | Licensed | UserMailbox | `emma.wilson@summitridge-mfg.com` | Completed |
| Olivia Brown | Licensed | UserMailbox | `olivia.brown@summitridge-mfg.com` | Completed |
| Sophia Martinez | Licensed | UserMailbox | `sophia.martinez@summitridge-mfg.com` | Completed |

---

### Final Architecture Summary

| Component | Configuration | Result |
|---|---|---|
| Microsoft 365 tenant | `democompany1016.onmicrosoft.com` | Validated |
| Verified mail domain | `summitridge-mfg.com` | Validated |
| Identity source | On-prem AD synced through Microsoft Entra Cloud Sync | Validated |
| Pilot licensing group | `GRP-M365-E5-Pilot-License` | Created and validated |
| License assignment method | Group-based licensing | Implemented |
| Pilot users | Emma, Olivia, Sophia | Licensed |
| Exchange Online mailbox state | UserMailbox | Validated |
| Primary SMTP format | `first.last@summitridge-mfg.com` | Standardized |
| Tenant alias format | `first.last@democompany1016.onmicrosoft.com` | Documented |
| MX record | `summitridge-mfg.com` MX | Validated |
| SPF record | Single SPF record | Validated |
| DMARC record | Monitoring record | Validated |
| Autodiscover record | `autodiscover.summitridge-mfg.com` | Validated |
| DKIM selector records | Future action if not configured | Documented |
| Rollback controls | License group removal and restore scripts | Created |
| Monitoring controls | License and mailbox monitoring scripts | Created |

---

## Validation Walkthrough

### Evidence Folders

Evidence was stored under:

```text
C:\LabEvidence\Project05\Batch01
C:\LabEvidence\Project05\Batch02
C:\LabEvidence\Project05\Batch03
C:\LabEvidence\Project05\Batch04
C:\LabEvidence\Project05\Batch05
C:\LabEvidence\Project05\Batch06
C:\LabEvidence\Project05\Batch07
C:\LabEvidence\Project05\Batch08
```

GitHub evidence was organized under:

```text
projects/05-m365-licensing-exchange-mailbox-standardization/evidence/
```

---

### Key Validation Outputs

| Evidence File | Purpose |
|---|---|
| `batch-02-pre-license-pilot-user-validation.csv` | Validated synced users before licensing |
| `batch-02-available-tenant-license-skus.csv` | Exported available tenant SKUs |
| `batch-03-license-group-members.csv` | Confirmed pilot users in licensing group |
| `batch-03-pilot-user-license-validation.csv` | Validated user license assignment |
| `batch-03-pilot-license-service-plan-details.csv` | Exported service plan status |
| `batch-04-pilot-mailbox-validation.csv` | Validated Exchange Online mailboxes |
| `batch-04-pilot-mailbox-email-addresses.csv` | Exported mailbox address state |
| `batch-05-ad-mail-proxyaddresses-updated.csv` | Confirmed AD mail/proxyAddresses update |
| `batch-05-post-sync-mailbox-address-state.csv` | Validated Exchange mailbox address state after sync |
| `batch-06-mail-flow-dns-readiness.csv` | Checked MX/SPF/DMARC/Autodiscover readiness |
| `batch-06-message-trace-result-summary.csv` | Summarized message trace results |
| `batch-07-current-license-group-members.csv` | Validated operational licensing group membership |
| `batch-07-current-pilot-mailbox-state.csv` | Exported mailbox monitoring baseline |
| `project-05-final-validation-checklist.csv` | Final checklist |
| `project-05-final-architecture-summary.csv` | Final architecture summary |
| `project-05-final-pilot-user-results.csv` | Final pilot user outcome |

---

### Example Validation Commands

Validate Microsoft Graph context:

```powershell
Get-MgContext
```

Validate pilot license state:

```powershell
Get-MgUser `
  -Filter "userPrincipalName eq 'emma.wilson@summitridge-mfg.com'" `
  -Property DisplayName,UserPrincipalName,UsageLocation,AssignedLicenses,OnPremisesSyncEnabled
```

Validate Exchange Online connection:

```powershell
Get-ConnectionInformation
```

Validate mailbox state:

```powershell
Get-Mailbox -Identity emma.wilson@summitridge-mfg.com |
Select-Object DisplayName,UserPrincipalName,PrimarySmtpAddress,RecipientTypeDetails
```

Validate mailbox statistics:

```powershell
Get-MailboxStatistics -Identity emma.wilson@summitridge-mfg.com
```

Validate accepted domain:

```powershell
Get-AcceptedDomain |
Where-Object { $_.DomainName -eq "summitridge-mfg.com" }
```

Validate mail DNS readiness:

```powershell
Resolve-DnsName summitridge-mfg.com -Type MX
Resolve-DnsName summitridge-mfg.com -Type TXT
Resolve-DnsName _dmarc.summitridge-mfg.com -Type TXT
Resolve-DnsName autodiscover.summitridge-mfg.com -Type CNAME
```

---

## Key Takeaways

- Project 04 created the synced Microsoft Entra identities; Project 05 activated Microsoft 365 services for those users.
- Group-based licensing was safer and more scalable than direct broad user licensing.
- UsageLocation must be validated before Microsoft 365 license assignment.
- Exchange Online mailbox provisioning must be validated after licensing.
- For synced users, mail and proxy address standardization should be handled from the on-premises AD source of authority.
- Primary SMTP addresses were standardized with `summitridge-mfg.com`.
- Outlook/Autodiscover and mail DNS readiness were validated before broader rollout.
- DKIM remains a future email-authentication hardening step if selector records are not configured.
- Rollback and monitoring scripts were created before expanding beyond the pilot group.

---

## Business Value

Project 05 completed the Microsoft 365 service activation layer for the hybrid identity pilot.

The organization now has a validated process to:

- License synchronized Microsoft Entra users
- Provision Exchange Online mailboxes
- Standardize professional email addresses
- Validate mail-flow and client readiness
- Monitor licensing and mailbox health
- Roll back pilot licensing changes safely if needed

This creates a strong foundation for future Microsoft 365 expansion, Intune enrollment, Conditional Access, Defender, Purview, and Zero Trust identity controls.
