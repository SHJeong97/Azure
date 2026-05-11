# Naming Standards

## Purpose

This document defines the naming standards for the Summit Ridge hybrid Windows Server environment.

## Domain Naming

| Item | Standard |
|---|---|
| Internal AD DS domain | corp.democompany1016.local |
| NetBIOS domain | CORP |
| Current Microsoft tenant | democompany1016.onmicrosoft.com |
| Future public domain | summitridge-mfg.com |
| Future user UPN suffix | summitridge-mfg.com |

## Server Naming

| Name | Purpose |
|---|---|
| DC01 | Primary domain controller and internal DNS |
| DC02 | Secondary domain controller and internal DNS |
| MGMT01 | Management server |
| FS01 | File server |
| APP01 | Internal application server |
| WIN11-CL01 | Windows client endpoint |

## OU Naming

OUs use clear business-aligned names:

- SRMG
- Admin
- Groups
- Service Accounts
- Users
- Workstations
- Servers
- Disabled Objects
- Staging

## Group Naming

| Prefix | Purpose |
|---|---|
| GG-Dept-* | Department security groups |
| GG-FS-* | File access groups |
| GG-Admin-* | Administrative role groups |
| GG-LIC-* | Microsoft cloud licensing groups |

## User Naming

Standard user format:

first.last

Example:

emma.wilson

Current UPN:

emma.wilson@corp.democompany1016.local

Future UPN:

emma.wilson@summitridge-mfg.com

## Admin Account Naming

Dedicated admin accounts use:

adm.role

Examples:

- adm.cloudadmin
- adm.serveradmin
- adm.helpdesk

## Service Account Naming

Service accounts use:

svc-purpose

Examples:

- svc-entra-connect
- svc-azure-file-sync
- svc-app-proxy

## Business Value

A consistent naming standard improves administration, troubleshooting, automation, audit readiness, and onboarding. It also reduces confusion during hybrid identity synchronization and Microsoft 365 migration.
