# Identity Model

## Business Intent
The directory is structured to support a 75-user company, but the lab creates a controlled pilot population first.
This reflects a realistic staged rollout model rather than a full production migration on day one.

## Source of Authority
On-premises Active Directory is the source of authority for employee identities in this project.

## UPN Strategy
Because the on-prem AD forest uses a .local namespace, an alternate UPN suffix of democompany1016.onmicrosoft.com is added for cloud-ready sign-in alignment.

## OU Strategy
The directory separates:
- users
- groups
- admins
- servers
- service accounts
- workstations

This improves lifecycle control and future sync scoping.

## Group Strategy
Groups are divided into:
- department groups
- licensing groups
- role groups

## Admin Strategy
Privileged accounts are separate from standard user accounts.

## Emergency Access Strategy
Emergency access accounts are not created in on-prem AD.
They remain cloud-only in Microsoft Entra / Microsoft 365.
