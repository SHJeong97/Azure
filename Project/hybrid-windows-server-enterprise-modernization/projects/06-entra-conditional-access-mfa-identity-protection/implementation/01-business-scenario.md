
# Business Scenario

## Company

Summit Ridge Manufacturing Group is a simulated 250-user hybrid organization modernizing Microsoft identity, Microsoft 365 services, and cloud access security.

## Current State

| Area | Value |
|---|---|
| Internal AD DS domain | corp.democompany1016.local |
| Microsoft 365 tenant | democompany1016.onmicrosoft.com |
| Verified public domain | summitridge-mfg.com |
| Identity sync method | Microsoft Entra Cloud Sync |
| Pilot users | Synced to Microsoft Entra ID |
| Licensing | Pilot users licensed |
| Mailboxes | Exchange Online mailboxes provisioned |
| Primary SMTP | first.last@summitridge-mfg.com |
| Conditional Access state | Not yet implemented |

## Business Problem

The company has synchronized cloud identities and Microsoft 365 services, but access is not yet protected with Conditional Access and MFA policy controls.

Without Conditional Access, the organization cannot consistently enforce MFA, block legacy authentication, evaluate sign-in risk, or prepare for Zero Trust access decisions.

## Business Need

The company needs to:

- Create a controlled Conditional Access pilot scope
- Require MFA for pilot users
- Block legacy authentication
- Prepare risk-based access controls
- Validate policies in report-only mode before enforcement
- Review sign-in logs and policy impact
- Protect the tenant without locking out administrators
- Document rollback and monitoring controls

## Pilot Users

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Target State

| Item | Target Result |
|---|---|
| Pilot Conditional Access group | Created |
| Break-glass exclusion | Documented |
| MFA policy | Created in report-only mode first |
| Legacy authentication policy | Created in report-only mode first |
| Risk-based policy planning | Documented |
| Sign-in logs | Reviewed |
| Pilot enforcement | Controlled and reversible |
| Rollback controls | Documented |

## Business Value

This project establishes a controlled identity security baseline for Microsoft 365 access without relying on Intune device compliance.

It prepares the organization for stronger Zero Trust access controls based on user, group, authentication strength, legacy authentication status, and risk signals.
