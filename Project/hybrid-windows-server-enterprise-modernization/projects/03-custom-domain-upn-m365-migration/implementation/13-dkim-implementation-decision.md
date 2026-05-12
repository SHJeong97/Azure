# DKIM Implementation Decision

## Purpose

This document records the DKIM implementation decision for the Summit Ridge Microsoft 365 domain migration project.

## Domain

```text
summitridge-mfg.com
```

## DKIM Readiness Result

DKIM selector DNS records were checked with PowerShell:

```powershell
Resolve-DnsName selector1._domainkey.summitridge-mfg.com -Type CNAME
Resolve-DnsName selector2._domainkey.summitridge-mfg.com -Type CNAME
```

## Result

| Check | Result |
|---|---|
| selector1._domainkey.summitridge-mfg.com | Not found |
| selector2._domainkey.summitridge-mfg.com | Not found |
| DKIM readiness | Not ready |
| DKIM enabled in this batch | No |

## Current Decision

DKIM was not enabled during this batch because selector1 and selector2 CNAME records were not found in public DNS.

## Why DKIM Was Not Enabled

DKIM should not be enabled until:

- The custom domain is verified
- Exchange Online domain configuration is ready
- selector1 CNAME exists in public DNS
- selector2 CNAME exists in public DNS
- Microsoft 365 shows DKIM can be enabled safely

## Future Required Action

A future batch or project should retrieve the exact DKIM selector CNAME values from Microsoft 365 and create them in public DNS.

After both selector CNAME records resolve publicly, DKIM can be enabled and validated.

## Business Risk

Enabling DKIM before DNS is ready can cause DKIM validation failure and incomplete email authentication.

## Risk Treatment

The project avoids enabling DKIM early and documents selector CNAME readiness as a future action.

## Business Value

A controlled DKIM rollout improves outbound mail trust and prepares the company for stronger DMARC enforcement later.
