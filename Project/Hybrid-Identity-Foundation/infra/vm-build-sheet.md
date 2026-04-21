# VM Build Sheet

## Hosting Model
Azure infrastructure is hosted in a personal Azure subscription.
Identity target tenant is democompany1016.onmicrosoft.com.

## Planned Servers

### ADC-01
Role:
- Active Directory Domain Services
- DNS

Notes:
- static private IP
- first domain controller
- hosts corp.democompany1016.local

### MGMT-01
Role:
- domain-joined management server
- RSAT tools
- Microsoft Entra Connect Sync

Notes:
- used for management and sync configuration

## Identity Model
- 1 cloud-only emergency access account
- 2 privileged admin accounts
- 1 helpdesk/admin operations account
- 1 licensing/admin operations account
- 50 to 75 employee identities represented through structured test users

## Design Principle
Normal user accounts and privileged accounts must be separated.
