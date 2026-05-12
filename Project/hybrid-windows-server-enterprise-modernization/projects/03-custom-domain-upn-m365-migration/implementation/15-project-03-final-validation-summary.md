# Project 03 Final Validation Summary

## Purpose

This document records the final validation result for Project 03: Summit Ridge Custom Domain, UPN Suffix, and Microsoft 365 Domain Migration.

## Tenant

```text
democompany1016.onmicrosoft.com
```

## Public Domain

```text
summitridge-mfg.com
```

## Final Domain Status

The public domain was added to Microsoft 365 and verified.

The domain was also validated in Microsoft Entra ID.

## Public DNS Final Result

| Record | Status | Interpretation |
|---|---|---|
| SPF | Found | Valid single Microsoft 365 SPF record |
| MX | Found | MX exists; mail-flow state documented because inbound mail may route to Microsoft 365 |
| Autodiscover | Found | Outlook discovery record exists |
| DMARC | Found | Monitoring record exists |
| DKIM selector 1 | Missing | Future action before DKIM can be enabled |
| DKIM selector 2 | Missing | Future action before DKIM can be enabled |

## Pilot UPN Migration Result

The following pilot users were changed in Active Directory:

| User | New UPN |
|---|---|
| Emma Wilson | emma.wilson@summitridge-mfg.com |
| Olivia Brown | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | sophia.martinez@summitridge-mfg.com |

Only the pilot users were changed.

No broad user migration was performed.

## Identity Sync Finding

The AD pilot UPN changes are on-premises identity changes.

These changes do not automatically appear in Microsoft 365 unless Entra Connect or Cloud Sync is configured.

This identity gap was validated and documented.

## Exchange Online Finding

The domain was checked as an Exchange Online accepted domain.

Pilot mailbox existence was checked and documented.

Email address and alias planning was completed without forcing mailbox changes.

## Email Authentication Finding

SPF is valid.

DMARC exists and remains at the monitoring stage.

DKIM is not ready yet because selector1 and selector2 CNAME records are missing from public DNS.

## Safety Decisions

The project avoided high-risk changes:

- No AD DS domain rename
- No broad user migration
- No forced DKIM enablement
- No DMARC quarantine/reject enforcement
- No unplanned mailbox address changes

## Business Value

This project created a controlled path from internal AD identity toward professional Microsoft 365 identity using:

```text
first.last@summitridge-mfg.com
```

It also documented DNS, mail-flow, identity synchronization, and email authentication risks before broader rollout.
