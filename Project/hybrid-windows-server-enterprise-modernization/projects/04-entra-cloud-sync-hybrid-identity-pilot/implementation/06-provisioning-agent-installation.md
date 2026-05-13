# Microsoft Entra Provisioning Agent Installation

## Purpose

This document records the Microsoft Entra provisioning agent installation for the Cloud Sync pilot.

## Server

```text
MGMT01
```

## Domain

```text
corp.democompany1016.local
```

## Tenant

```text
democompany1016.onmicrosoft.com
```

## Installation Source

The Microsoft Entra provisioning agent was downloaded from the Microsoft Entra admin center:

```text
Microsoft Entra admin center
→ Identity
→ Hybrid management
→ Microsoft Entra Connect
→ Cloud sync
→ Agents
```

## Installer

```text
AADConnectProvisioningAgentSetup.exe
```

## Installation Result

The provisioning agent was installed on MGMT01.

## Issue Encountered

During configuration, the wizard reported that it could not create the gMSA because KDS might not be running on the domain controller.

## Root Cause

The Active Directory environment needed KDS/gMSA readiness before the provisioning agent could complete configuration.

## Fix Applied

The KDS service was validated and started on DC01.

A KDS Root Key was created or validated.

AD replication was checked after the KDS fix.

## gMSA

The provisioning agent used the following gMSA identity:

```text
corp.democompany1016.local\provAgentgMSA
```

## Validation Performed

Validation included:

- MGMT01 domain membership check
- Microsoft cloud endpoint DNS validation
- TLS 1.2 session validation
- AD domain and forest validation
- AD replication validation
- KDS service validation
- KDS Root Key validation
- gMSA validation
- Provisioning agent service validation
- Agent registration check in Microsoft Entra admin center

## Current Status

The provisioning agent is installed.

Cloud Sync configuration has not been created yet.

The pilot sync scope will be configured in the next batch.

## Business Value

Installing the provisioning agent creates the required bridge between on-premises Active Directory and Microsoft Entra Cloud Sync while keeping synchronization configuration separate and controlled.
