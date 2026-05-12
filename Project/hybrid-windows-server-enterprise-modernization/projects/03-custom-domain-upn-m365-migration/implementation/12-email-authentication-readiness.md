# Email Authentication Readiness

## Purpose

This document records SPF, DKIM, and DMARC readiness for the Summit Ridge Manufacturing Group Microsoft 365 domain migration project.

## Domain

```text
summitridge-mfg.com
```

## Email Authentication Controls

| Control | Purpose |
|---|---|
| SPF | Defines which mail systems are allowed to send mail for the domain |
| DKIM | Cryptographically signs outbound mail to prove message integrity and domain authorization |
| DMARC | Tells receiving mail systems how to handle messages that fail SPF/DKIM alignment |

## SPF Status

Expected Microsoft 365 SPF record:

```text
v=spf1 include:spf.protection.outlook.com -all
```

SPF validation was performed with:

```powershell
Resolve-DnsName summitridge-mfg.com -Type TXT
```

## SPF Risk

The domain should have only one SPF TXT record.

Multiple SPF records can cause SPF validation failure.

## DKIM Status

DKIM readiness was checked using Exchange Online PowerShell:

```powershell
Get-DkimSigningConfig
```

The DKIM selector records were checked using:

```powershell
Resolve-DnsName selector1._domainkey.summitridge-mfg.com -Type CNAME
Resolve-DnsName selector2._domainkey.summitridge-mfg.com -Type CNAME
```

## DKIM Safety Decision

DKIM should not be enabled until both selector CNAME records exist in public DNS and Microsoft 365 shows the domain is ready for DKIM signing.

## DMARC Status

Initial DMARC monitoring policy:

```text
v=DMARC1; p=none; rua=mailto:dmarc@summitridge-mfg.com
```

DMARC validation was performed with:

```powershell
Resolve-DnsName _dmarc.summitridge-mfg.com -Type TXT
```

## DMARC Safety Decision

The current policy should remain:

```text
p=none
```

The company should not move to:

```text
p=quarantine
```

or:

```text
p=reject
```

until SPF and DKIM alignment are validated.

## Why p=none First

A strict DMARC policy too early can block legitimate mail if all valid senders are not accounted for.

Starting with `p=none` allows monitoring without enforcement.

## Business Risk

Incorrect mail authentication can cause:

- Spoofed email risk
- Phishing risk
- Mail delivery issues
- Legitimate mail rejection
- User trust issues
- Brand reputation damage

## Risk Treatment

The project reduces risk by:

- Validating SPF before enforcement
- Checking for a single SPF record
- Checking DKIM selector readiness
- Keeping DMARC at p=none
- Delaying strict DMARC enforcement
- Documenting current DNS and Exchange Online state

## Business Value

SPF, DKIM, and DMARC readiness improves domain trust, reduces spoofing risk, and prepares the company for safer Exchange Online mail flow using:

```text
first.last@summitridge-mfg.com
```
