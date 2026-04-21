# VM Build Sheet

## Hosting Model
Azure infrastructure is hosted in a personal Azure subscription.
Identity target tenant is democompany1016.onmicrosoft.com.

## Planned Servers

### ADC-01
VM Size:
- Standard_DC1ds_v3
- 1 vCPU
- 8 GiB memory

### MGMT-01
VM Size:
- Standard_DC1ds_v3
- 1 vCPU
- 8 GiB memory

Lab note:
This size was selected based on quota and trial constraints rather than ideal performance sizing.
It is sufficient for a low-cost hybrid identity portfolio lab, but some administrative tasks may be slower than preferred.
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
