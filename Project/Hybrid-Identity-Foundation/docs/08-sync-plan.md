# Sync Plan

## Sync Technology
Microsoft Entra Connect Sync

## Sync Server
MGMT-01

## Sign-in Method
Password Hash Synchronization

## Target Tenant
democompany1016.onmicrosoft.com

## Pilot Sync Scope
- OU=Employees
- OU=Groups
- OU=Admins

## Out of Scope for Pilot
- Servers
- Workstations
- Service Accounts
- Domain Controllers
- Emergency access cloud-only accounts

## Design Note
A pilot OU scope is used first to reduce blast radius and validate object matching before broader synchronization.
