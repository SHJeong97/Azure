# Business Scenario

## Company

Summit Ridge Manufacturing Group is a simulated 250-user company modernizing identity between on-premises Active Directory and Microsoft 365.

## Current State

| Area | Value |
|---|---|
| Internal AD DS domain | corp.democompany1016.local |
| Microsoft tenant default domain | democompany1016.onmicrosoft.com |
| Verified public domain | summitridge-mfg.com |
| Pilot AD UPN suffix | summitridge-mfg.com |
| Cloud sync state | Not configured yet |

## Business Problem

Project 03 changed pilot AD users to professional UPNs using the verified public domain.

However, changing on-premises AD users does not automatically create or update Microsoft 365 cloud users.

The company needs a controlled synchronization path from Active Directory to Microsoft Entra ID.

## Business Need

The company needs to:

- Synchronize selected AD pilot users to Microsoft Entra ID
- Preserve professional UPNs using summitridge-mfg.com
- Avoid syncing the full directory during the pilot
- Validate identity attributes before broader rollout
- Prepare for Microsoft 365 licensing, Exchange Online, Teams, OneDrive, and Intune readiness

## Target State

Pilot users should exist in Microsoft Entra ID with UPNs like:

```text
first.last@summitridge-mfg.com
```

Example:

```text
emma.wilson@summitridge-mfg.com
```

## Business Value

Hybrid identity synchronization creates a bridge between on-premises AD administration and Microsoft 365 cloud services.

This reduces duplicate account management, prepares users for Microsoft 365 licensing, and creates a safer path toward broader cloud adoption.
