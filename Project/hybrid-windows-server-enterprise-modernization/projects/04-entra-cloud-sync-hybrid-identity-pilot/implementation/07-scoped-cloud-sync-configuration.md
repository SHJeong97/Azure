# Scoped Cloud Sync Configuration

## Purpose

This document records the scoped Microsoft Entra Cloud Sync configuration for the Summit Ridge hybrid identity pilot.

## Sync Direction

```text
Active Directory to Microsoft Entra ID
```

## AD Domain

```text
corp.democompany1016.local
```

## Microsoft Entra Tenant

```text
democompany1016.onmicrosoft.com
```

## Verified Public UPN Suffix

```text
summitridge-mfg.com
```

## Provisioning Agent Server

```text
MGMT01
```

## Pilot Scope Method

The configuration uses selected security group scoping.

## Pilot Sync Group

```text
GRP-EntraCloudSync-Pilot
```

## Pilot Users

| User | UPN |
|---|---|
| Emma Wilson | emma.wilson@summitridge-mfg.com |
| Olivia Brown | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | sophia.martinez@summitridge-mfg.com |

## Important Scoping Decision

The pilot group uses direct user membership only.

Nested groups are not used.

## Password Hash Sync

Password hash sync was enabled if selected during the configuration flow.

## Attribute Mapping

Default attribute mappings were reviewed and kept for the pilot.

The expected identity outcome is:

```text
AD userPrincipalName → Microsoft Entra userPrincipalName
```

## On-Demand Provisioning Test

Provision on demand was tested before enabling the scoped configuration.

The first test user was:

```text
emma.wilson@summitridge-mfg.com
```

## Safety Decisions

The project avoided high-risk sync changes:

- Full directory sync was not selected
- Nested groups were not used
- Broad OU sync was not selected
- Attribute mappings were not customized unnecessarily
- Configuration was tested before validation

## Business Risk

Incorrect sync scoping can create or modify too many cloud identities.

## Risk Treatment

The project uses a narrow pilot security group and validates results before expanding synchronization.

## Business Value

This creates a controlled bridge between Active Directory and Microsoft Entra ID, allowing the company to validate hybrid identity with limited risk.
