# Hybrid Identity Readiness Plan

## Purpose

This document explains how the Project 01 AD DS foundation prepares for later Microsoft Entra hybrid identity integration.

## Current State

| Item | Value |
|---|---|
| Internal AD DS domain | corp.democompany1016.local |
| Current user UPN suffix | corp.democompany1016.local |
| Microsoft tenant | democompany1016.onmicrosoft.com |
| Future public domain | summitridge-mfg.com |

## Future State

After the company purchases and verifies the public domain, users will move to:

first.last@summitridge-mfg.com

This will be used for:

- Microsoft 365 sign-in
- Exchange Online primary email
- Teams identity
- OneDrive identity
- Intune user identity
- Conditional Access targeting

## Important Design Decision

The internal AD DS domain will not be renamed.

Instead, summitridge-mfg.com was added as an alternate UPN suffix in Active Directory.

## Why AD Domain Rename Is Avoided

Renaming an AD DS domain can affect:

- Domain joins
- Kerberos
- DNS
- Group Policy
- Certificates
- Service accounts
- Applications
- File permissions
- Entra Connect synchronization
- Scripts and automation

For a 250-user company, the safer approach is to keep the internal AD DS domain stable and use a verified public domain as the user sign-in suffix.

## Later Project Dependency

User UPNs should not be changed to summitridge-mfg.com until:

1. The company purchases the public domain.
2. The domain is verified in Microsoft 365.
3. Public DNS records are configured.
4. Pilot users are selected.
5. Rollback plan is documented.
6. Communication plan is prepared.

## Business Value

This approach supports a professional Microsoft 365 sign-in and email domain while reducing the operational risk of renaming the internal AD DS domain.
