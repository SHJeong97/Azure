# UPN Suffix and Hybrid Identity Readiness

## Purpose

This implementation prepared the AD DS environment for future hybrid identity integration with Microsoft Entra ID and Microsoft 365.

## Current State

| Item | Value |
|---|---|
| Internal AD DS domain | corp.democompany1016.local |
| NetBIOS name | CORP |
| Current user UPN suffix | corp.democompany1016.local |
| Future public UPN suffix | summitridge-mfg.com |

## What Was Configured

The future public domain suffix summitridge-mfg.com was added as an alternate UPN suffix in Active Directory.

No user accounts were migrated to the new suffix during this project.

## Why Users Were Not Changed Yet

The company has not completed the public domain purchase, external DNS configuration, or Microsoft 365 domain verification yet.

Changing user UPNs before the public domain is verified in Microsoft 365 could create sign-in confusion and hybrid identity issues.

## Business Problem

The company wants users to eventually sign in with a professional public identity such as:

first.last@summitridge-mfg.com

instead of:

first.last@corp.democompany1016.local

## Risk

Changing user UPNs too early can cause:

- User sign-in confusion
- Microsoft 365 identity mismatch
- Entra Connect synchronization issues
- Outlook/Teams/OneDrive profile confusion
- Helpdesk ticket increase

## Risk Treatment

Add the future UPN suffix now, but delay user migration until the public domain is verified in Microsoft 365 and a pilot migration plan is ready.

## Business Value

This prepares the AD DS environment for Microsoft 365 and Entra ID integration while avoiding unnecessary risk during the infrastructure foundation phase.
