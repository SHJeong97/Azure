# Public DNS Change Plan

## Purpose

This document defines the public DNS record changes for the Summit Ridge Microsoft 365 custom domain project.

## Domain

```text
summitridge-mfg.com
```

## Current Status

The domain has been added and verified in Microsoft 365 using a TXT verification record.

## DNS Records in Scope

| Record | Action |
|---|---|
| TXT verification | Already completed |
| SPF TXT | Planned |
| Autodiscover CNAME | Planned |
| DMARC TXT | Planned as monitoring only |
| MX | Delayed |
| DKIM CNAME | Document only in this batch |

## Records That Will Not Be Changed Yet

MX will not be changed during this batch.

DKIM will not be enabled during this batch.

DMARC will not be set to quarantine or reject during this batch.

## Why MX Is Delayed

MX controls where inbound email is delivered.

Changing MX too early can route mail to Microsoft 365 before mailboxes, aliases, pilot users, and rollback steps are ready.

## Safe Records for This Batch

The following records are considered safe for this planning stage:

| Record | Reason |
|---|---|
| SPF TXT | Prepares outbound sender authorization |
| Autodiscover CNAME | Prepares Outlook discovery |
| DMARC TXT with p=none | Enables monitoring without enforcement |

## SPF Record

```text
v=spf1 include:spf.protection.outlook.com -all
```

## Autodiscover Record

```text
autodiscover.summitridge-mfg.com → autodiscover.outlook.com
```

## DMARC Monitoring Record

```text
v=DMARC1; p=none; rua=mailto:dmarc@summitridge-mfg.com
```

## Business Risk

Incorrect public DNS records can cause:

- Microsoft 365 setup warnings
- Mail routing failure
- Spoofing risk
- Outlook Autodiscover issues
- Future DKIM activation failure
- User disruption during migration

## Risk Treatment

The project reduces risk by:

- Capturing current DNS records before change
- Delaying MX cutover
- Starting DMARC with p=none
- Keeping DKIM as documentation until exact Microsoft values are confirmed
- Validating all public DNS records after creation

## Business Value

This staged approach prepares the public domain for Microsoft 365 while reducing the risk of mail flow disruption.
