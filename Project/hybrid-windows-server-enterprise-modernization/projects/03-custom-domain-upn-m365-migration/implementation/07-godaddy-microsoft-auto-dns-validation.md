# GoDaddy and Microsoft 365 Auto DNS Validation

## Purpose

This document records the DNS validation results after Microsoft 365 and GoDaddy automatically configured DNS records for the public domain.

## Domain

```text
summitridge-mfg.com
```

## DNS Setup Method

Microsoft 365 used GoDaddy Domain Connect / automatic DNS setup to configure DNS records.

## Why Batch 3 Was Adjusted

The original plan was to manually create selected public DNS records.

Because Microsoft and GoDaddy automatically created DNS records, the implementation changed to:

1. Validate what records were created.
2. Confirm whether MX was created.
3. Check Microsoft 365 DNS health.
4. Document risk.
5. Preserve evidence.

## Records Checked

| Record | Purpose |
|---|---|
| TXT verification | Proves domain ownership |
| MX | Routes inbound mail |
| SPF TXT | Authorizes Microsoft 365 as sender |
| Autodiscover CNAME | Supports Outlook discovery |
| DKIM selector CNAMEs | Supports DKIM signing |
| DMARC TXT | Supports email authentication monitoring |

## Important MX Finding

Update this section based on actual validation:

```text
MX status:
MX was auto-created and points to Microsoft 365.
```

or:

```text
MX status:
MX was not created and mail routing has not been cut over.
```

## Risk

If MX was auto-created, inbound email for the domain may already route to Microsoft 365.

This is acceptable in the lab only if no production mail is using the domain yet.

## Risk Treatment

The project documents the actual DNS state and validates records before proceeding to user UPN and Exchange Online planning.

## Business Value

This validation proves that public DNS is connected to Microsoft 365 while showing awareness of the risk of automatic DNS changes, especially MX mail-routing changes.
