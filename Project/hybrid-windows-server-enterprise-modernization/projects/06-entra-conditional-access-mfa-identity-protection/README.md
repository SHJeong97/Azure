
# Project 06 — Microsoft Entra Conditional Access, MFA, and Identity Protection Baseline

## Introduction

This project implements a controlled Microsoft Entra Conditional Access, MFA, and Identity Protection baseline for Summit Ridge Manufacturing Group.

Project 04 synchronized selected on-premises Active Directory users into Microsoft Entra ID using Microsoft Entra Cloud Sync. Project 05 activated Microsoft 365 services for those synchronized users by assigning licenses, provisioning Exchange Online mailboxes, and standardizing primary SMTP addresses. Project 06 builds on that foundation by protecting Microsoft 365 access with Conditional Access controls, MFA enforcement, break-glass protection, report-only validation, pilot enforcement, rollback planning, operational monitoring, and privacy-safe evidence handling.

This project intentionally does not use Intune and does not require compliant-device state.

---

## Objectives

- Create a controlled Conditional Access pilot scope
- Validate Microsoft Entra tenant readiness
- Create a Conditional Access pilot group
- Create and document a break-glass exclusion group
- Create and document an emergency access account
- Validate MFA registration readiness for pilot users
- Create a report-only MFA Conditional Access policy
- Validate report-only impact before enforcement
- Enable MFA enforcement for pilot users
- Create a report-only legacy authentication blocking policy
- Review legacy authentication activity before enforcement
- Plan Identity Protection sign-in risk and user risk policies separately
- Create rollback scripts and monitoring scripts
- Build an operational Conditional Access runbook
- Export final validation evidence using sanitized fields only
- Avoid exporting public IP address or location data

---

## Full Implementation

Project 06 was completed in nine implementation batches.

| Batch | Focus | Result |
|---|---|---|
| Batch 1 | Project scope, licensing, policy design, and folder structure | Project structure and planning documents created |
| Batch 2 | Tenant readiness, pilot groups, break-glass account, and baseline checks | Pilot and exclusion scope prepared |
| Batch 3 | Authentication methods, MFA registration, and pilot readiness | Pilot MFA readiness validated |
| Batch 4 | CA001 Require MFA for pilot users | MFA policy created in report-only mode and validated |
| Batch 5 | CA002 Block legacy authentication | Legacy authentication policy created in report-only mode and reviewed |
| Batch 6 | Identity Protection risk policy planning | Sign-in risk and user risk policies planned separately |
| Batch 7 | Report-only impact review and pilot enforcement | CA001 enabled for pilot enforcement |
| Batch 8 | Rollback, monitoring, and operational controls | Runbook and scripts created |
| Batch 9 | Final validation and README package | Final validation package completed |

---

## Implementation Walkthrough

### Business Scenario

Summit Ridge Manufacturing Group has synchronized Microsoft Entra identities and Microsoft 365 mailboxes for a small pilot user group. The organization needs to improve Microsoft 365 access security without immediately applying tenant-wide policies or creating device compliance dependencies.

The project introduces Conditional Access in a controlled way by using:

- Pilot-only scoping
- Report-only validation
- MFA readiness validation
- Break-glass exclusions
- Legacy authentication review
- Rollback scripts
- Monitoring scripts
- Sanitized evidence exports

### Environment

| Area | Value |
|---|---|
| Microsoft 365 tenant | `democompany1016.onmicrosoft.com` |
| Verified public domain | `summitridge-mfg.com` |
| Identity source | On-premises AD synced through Microsoft Entra Cloud Sync |
| Conditional Access pilot group | `GRP-CA-Pilot-Users` |
| Break-glass exclusion group | `GRP-CA-Excluded-BreakGlass` |
| Emergency access account | `emergency.access01@democompany1016.onmicrosoft.com` |
| Intune dependency | None |
| Compliant-device requirement | None |

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
                | Microsoft 365 licensing from Project 05
                v
+------------------------------+
| Microsoft 365 Services       |
| Exchange Online mailboxes    |
+---------------+--------------+
                |
                | Conditional Access pilot controls
                v
+------------------------------+
| GRP-CA-Pilot-Users           |
| Emma, Olivia, Sophia         |
+---------------+--------------+
                |
                | CA001 / CA002
                v
+------------------------------+
| MFA + Legacy Auth Controls   |
+------------------------------+

Emergency access exclusion:
GRP-CA-Excluded-BreakGlass
```

### Pilot Users

| User | Department | UPN | Conditional Access Scope |
|---|---|---|---|
| Emma Wilson | HR | `emma.wilson@summitridge-mfg.com` | Included in pilot group |
| Olivia Brown | Finance | `olivia.brown@summitridge-mfg.com` | Included in pilot group |
| Sophia Martinez | IT | `sophia.martinez@summitridge-mfg.com` | Included in pilot group |
| Emergency Access 01 | Emergency access | `emergency.access01@democompany1016.onmicrosoft.com` | Excluded from CA enforcement |

### Conditional Access Scope

The project used group-based policy targeting.

Included group:

```text
GRP-CA-Pilot-Users
```

Excluded group:

```text
GRP-CA-Excluded-BreakGlass
```

The pilot group contained only the three approved pilot users. The exclusion group contained the emergency access account.

### Break-Glass Protection

The emergency access account was created and documented to reduce administrator lockout risk.

Emergency access account:

```text
emergency.access01@democompany1016.onmicrosoft.com
```

The account was added to:

```text
GRP-CA-Excluded-BreakGlass
```

The project documented that production environments should maintain at least two emergency access accounts, monitor their usage, and keep them excluded from lockout-prone Conditional Access policies.

### MFA Readiness

Before enforcing MFA, the project validated that pilot users were ready for MFA.

Validation included:

- Authentication methods policy review
- Microsoft Authenticator pilot configuration review
- MFA registration test plan
- Pilot user MFA registration
- Post-registration MFA readiness export
- Authentication method export per pilot user

Expected final readiness:

```text
IsMfaRegistered = True
IsMfaCapable = True
ReadyForMFAEnforcement = Yes
```

### CA001 — Require MFA for Pilot Users

Policy name:

```text
CA001-Require-MFA-Pilot-Users
```

Purpose:

```text
Require multifactor authentication for pilot users.
```

Policy design:

| Setting | Configuration |
|---|---|
| Included users/groups | `GRP-CA-Pilot-Users` |
| Excluded users/groups | `GRP-CA-Excluded-BreakGlass` |
| Target resources | All cloud apps |
| Client apps | Browser, mobile apps, desktop clients |
| Grant control | Require multifactor authentication |
| Initial state | Report-only |
| Pilot enforcement state | Enabled |

CA001 was created in report-only mode first, reviewed in sign-in logs, and then enabled for pilot enforcement after readiness validation.

### CA002 — Block Legacy Authentication

Policy name:

```text
CA002-Block-Legacy-Authentication
```

Purpose:

```text
Block legacy authentication for pilot users after report-only review.
```

Policy design:

| Setting | Configuration |
|---|---|
| Included users/groups | `GRP-CA-Pilot-Users` |
| Excluded users/groups | `GRP-CA-Excluded-BreakGlass` |
| Target resources | All cloud apps |
| Client apps | Exchange ActiveSync, Other clients |
| Grant control | Block access |
| Initial state | Report-only |
| Final state | Enabled or report-only based on legacy-auth review |

The project reviewed recent sign-in activity for legacy authentication indicators before deciding whether to enable CA002. In a clean lab, no legacy authentication activity is usually a good result.

### Identity Protection Planning

Risk-based Conditional Access was planned but not enforced.

Planned policies:

| Policy | Risk Type | Risk Level | Planned Control | Final State |
|---|---|---|---|---|
| `CA004-SignIn-Risk-MFA` | Sign-in risk | Medium and High | Require MFA | Planned only |
| `CA005-User-Risk-Password-Change` | User risk | High | Require password change | Planned only |

The project intentionally separated sign-in risk and user risk into different planned policies.

### Rollback Controls

Rollback helper scripts were created to return policies to report-only mode.

| Script | Purpose |
|---|---|
| `rollback-ca001-to-report-only.ps1` | Returns CA001 to report-only |
| `rollback-ca002-to-report-only.ps1` | Returns CA002 to report-only |
| `rollback-ca-pilot-policies-to-report-only.ps1` | Returns both pilot policies to report-only |

Rollback principle:

```text
If pilot enforcement causes sign-in issues, return the affected policy to report-only mode first.
```

### Monitoring Controls

Operational monitoring scripts were created for policy state, group membership, sanitized sign-in evidence, and emergency access usage.

| Script | Purpose |
|---|---|
| `monitor-ca-policy-operational-state.ps1` | Checks CA001 and CA002 state |
| `monitor-ca-pilot-and-breakglass-groups.ps1` | Checks pilot and break-glass group membership |
| `export-ca-signin-summary-sanitized.ps1` | Exports sign-in evidence without IP/location fields |
| `monitor-breakglass-signins-sanitized.ps1` | Reviews emergency access sign-ins without IP/location fields |
| `validate-pilot-mfa-readiness.ps1` | Validates pilot MFA readiness |
| `validate-identity-protection-baseline.ps1` | Exports Identity Protection baseline state |

### Privacy-Safe Evidence Handling

The project intentionally excluded public IP and location fields from final sign-in evidence.

Excluded fields:

```text
IpAddress
Location
City
State
CountryOrRegion
```

Screenshots must be cropped or blurred if they show:

- Public IP address
- Geographic location
- Device details
- Browser session metadata
- Authenticator device details
- Phone numbers
- QR codes

---

## Results & Validation

### Final Technical Result

Project 06 successfully created a controlled Conditional Access and MFA baseline for pilot Microsoft 365 users.

| Area | Result |
|---|---|
| Conditional Access pilot group | Created and validated |
| Break-glass exclusion group | Created and validated |
| Emergency access account | Created and documented |
| MFA readiness | Validated |
| CA001 Require MFA policy | Created and enabled for pilot enforcement |
| CA002 Block Legacy Authentication policy | Created and validated or documented based on review |
| Identity Protection risk policies | Planned only |
| Rollback scripts | Created |
| Monitoring scripts | Created |
| Operational runbook | Created |
| Public IP/location evidence handling | Sanitized |
| Intune dependency | None |
| Compliant-device requirement | None |

### Final Policy Outcomes

| Policy | Purpose | Final State | Result |
|---|---|---|---|
| `CA001-Require-MFA-Pilot-Users` | Require MFA for pilot users | Enabled | Validated for pilot enforcement |
| `CA002-Block-Legacy-Authentication` | Block legacy authentication | Enabled or report-only based on review | Validated or documented |
| `CA004-SignIn-Risk-MFA` | Require MFA for risky sign-ins | Planned only | Documented |
| `CA005-User-Risk-Password-Change` | Require password change for high-risk users | Planned only | Documented |

### Final Pilot User Results

| User | Conditional Access Scope | MFA Readiness | Final Status |
|---|---|---|---|
| Emma Wilson | Included in `GRP-CA-Pilot-Users` | Validated | Completed |
| Olivia Brown | Included in `GRP-CA-Pilot-Users` | Validated | Completed |
| Sophia Martinez | Included in `GRP-CA-Pilot-Users` | Validated | Completed |
| Emergency Access 01 | Excluded through `GRP-CA-Excluded-BreakGlass` | Not used for daily MFA testing | Protected |

### Final Architecture Summary

| Component | Configuration | Result |
|---|---|---|
| Microsoft Entra tenant | `democompany1016.onmicrosoft.com` | Validated |
| Verified public domain | `summitridge-mfg.com` | Validated |
| Identity source | On-prem AD synced through Microsoft Entra Cloud Sync | Validated |
| Pilot group | `GRP-CA-Pilot-Users` | Created and validated |
| Break-glass exclusion group | `GRP-CA-Excluded-BreakGlass` | Created and validated |
| Emergency access account | `emergency.access01@democompany1016.onmicrosoft.com` | Created and documented |
| MFA readiness | Microsoft Authenticator registration | Validated |
| CA001 policy | Require MFA for pilot users | Enabled |
| CA002 policy | Block legacy authentication | Enabled or report-only based on review |
| Risk policy separation | Sign-in risk and user risk separated | Documented |
| Rollback controls | Rollback scripts created | Validated |
| Monitoring controls | Monitoring scripts created | Validated |
| Privacy-safe evidence | IP and location fields excluded | Implemented |
| Intune dependency | None | Not used |
| Compliant-device requirement | None | Not used |

---

## Validation Walkthrough

### Evidence Folders

Evidence was stored under:

```text
C:\LabEvidence\Project06\Batch01
C:\LabEvidence\Project06\Batch02
C:\LabEvidence\Project06\Batch03
C:\LabEvidence\Project06\Batch04
C:\LabEvidence\Project06\Batch05
C:\LabEvidence\Project06\Batch06
C:\LabEvidence\Project06\Batch07
C:\LabEvidence\Project06\Batch08
C:\LabEvidence\Project06\Batch09
```

GitHub evidence was organized under:

```text
projects/06-entra-conditional-access-mfa-identity-protection/evidence/
```

### Key Validation Outputs

| Evidence File | Purpose |
|---|---|
| `batch-02-pilot-user-readiness.csv` | Validated pilot user readiness |
| `batch-02-ca-pilot-group-members.csv` | Confirmed pilot group membership |
| `batch-02-breakglass-exclusion-group-members.csv` | Confirmed emergency access exclusion |
| `batch-03-pilot-mfa-registration-details-after.csv` | Confirmed MFA registration state |
| `batch-03-pilot-authentication-methods.csv` | Exported registered authentication methods |
| `batch-04-ca001-policy-created-report-only.txt` | Confirmed CA001 report-only creation |
| `batch-04-ca001-report-only-impact-summary.csv` | Summarized CA001 report-only impact |
| `batch-05-ca002-policy-created-report-only.txt` | Confirmed CA002 report-only creation |
| `batch-05-legacy-auth-signins.csv` | Reviewed legacy authentication activity |
| `batch-06-identity-protection-baseline-summary.csv` | Summarized Identity Protection baseline |
| `batch-07-post-enforcement-policy-states.csv` | Confirmed pilot enforcement policy states |
| `batch-07-post-enforcement-ca-results.csv` | Exported sanitized post-enforcement CA results |
| `batch-08-operational-health-summary.csv` | Summarized operational health |
| `project-06-final-ca-policy-states.csv` | Final CA policy state evidence |
| `project-06-final-ca-policy-configurations.csv` | Final CA policy configuration evidence |
| `project-06-final-mfa-readiness.csv` | Final MFA readiness evidence |
| `project-06-final-pilot-signin-summary-sanitized.csv` | Final sanitized sign-in evidence |
| `project-06-final-ca-results-sanitized.csv` | Final sanitized CA result evidence |
| `project-06-final-architecture-summary.csv` | Final architecture summary |
| `project-06-final-policy-outcomes.csv` | Final policy outcomes |
| `project-06-final-validation-checklist.csv` | Final validation checklist |

### Example Validation Commands

Validate Conditional Access policies:

```powershell
Get-MgIdentityConditionalAccessPolicy -All |
Select-Object DisplayName,State,CreatedDateTime,ModifiedDateTime
```

Validate pilot group membership:

```powershell
Get-MgGroupMember -GroupId $CAPilotGroup.Id -All
```

Validate MFA readiness:

```powershell
Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/reports/authenticationMethods/userRegistrationDetails"
```

Export sanitized sign-in summary:

```powershell
Get-MgAuditLogSignIn -Filter "createdDateTime ge $StartTime" -All |
Select-Object CreatedDateTime,UserDisplayName,UserPrincipalName,AppDisplayName,ClientAppUsed,ConditionalAccessStatus,Status
```

Export sanitized Conditional Access results:

```powershell
$FinalCAResults |
Select-Object CreatedDateTime,UserPrincipalName,UserDisplayName,AppDisplayName,ClientAppUsed,ConditionalAccessStatus,PolicyName,PolicyResult,GrantControls
```

---

## Key Takeaways

- Conditional Access should be rolled out with a controlled pilot scope before tenant-wide expansion.
- Break-glass exclusions are required to reduce administrator lockout risk.
- MFA registration should be validated before requiring MFA.
- Report-only mode helps validate Conditional Access policy impact before enforcement.
- CA001 successfully demonstrated pilot MFA enforcement.
- CA002 demonstrated legacy authentication review and enforcement planning.
- Sign-in risk and user risk should be planned as separate policy paths.
- Rollback scripts should return policies to report-only mode instead of deleting them.
- Monitoring scripts should check policy state, group membership, sign-in results, and break-glass usage.
- Evidence exports should avoid public IP address and location fields when privacy is a concern.
- This project does not rely on Intune or compliant-device requirements.

---

## Business Value

Project 06 establishes a practical identity security baseline for Microsoft 365 access.

The organization now has a validated process to:

- Scope Conditional Access to pilot users
- Exclude emergency access
- Validate MFA readiness
- Require MFA for Microsoft 365 access
- Review and prepare legacy authentication blocking
- Plan Identity Protection risk responses
- Monitor Conditional Access operational health
- Roll back policies safely if needed
- Produce privacy-safe evidence for a public portfolio

This project strengthens the identity security layer of the hybrid Microsoft 365 environment and prepares the tenant for future privileged access, Defender, Purview, and Sentinel security projects.
