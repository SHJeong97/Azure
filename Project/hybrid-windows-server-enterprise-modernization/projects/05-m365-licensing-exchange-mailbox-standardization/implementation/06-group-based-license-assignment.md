# Group-Based Microsoft 365 License Assignment

## Purpose

This document records the Microsoft 365 group-based license assignment for the pilot users.

## Licensing Group

```text
GRP-M365-E5-Pilot-License
```

## Pilot Users

| User | UPN |
|---|---|
| Emma Wilson | emma.wilson@summitridge-mfg.com |
| Olivia Brown | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | sophia.martinez@summitridge-mfg.com |

## License Assignment Method

The project used group-based licensing.

The license was assigned to the pilot licensing group instead of assigning licenses broadly to all users.

## Target License

The target pilot license was selected from available tenant SKUs.

Preferred SKU order:

```text
ENTERPRISEPREMIUM
SPE_E5
ENTERPRISEPACK
```

## Validation Performed

Validation included:

- Microsoft Graph connection
- Available tenant SKU export
- Pilot license SKU selection
- Cloud licensing group creation
- Pilot user membership validation
- Pre-assignment license readiness validation
- Group license assignment
- User license application validation
- License detail and service plan export

## Expected Result

Each pilot user should show the selected Microsoft 365 license assigned.

Each user should remain:

```text
AccountEnabled = True
UsageLocation = US
```

## Exchange Online Impact

After the Exchange Online-capable license is assigned, Exchange Online mailbox provisioning is expected to begin.

Mailbox provisioning will be validated separately in Batch 4.

## Safety Decisions

The project avoided:

- Assigning licenses to all users
- Assigning licenses to unrelated users
- Changing primary SMTP addresses before mailbox validation
- Assuming mailbox provisioning before checking Exchange Online

## Business Risk

Incorrect license assignment can cause:

- Unexpected service activation
- Unplanned mailbox creation
- Licensing cost issues
- User confusion
- Helpdesk impact

## Risk Treatment

The project reduces risk by using a dedicated pilot licensing group and validating license assignment before mailbox work.

## Business Value

Group-based licensing creates a scalable way to activate Microsoft 365 services for synchronized users while keeping service enablement controlled.
