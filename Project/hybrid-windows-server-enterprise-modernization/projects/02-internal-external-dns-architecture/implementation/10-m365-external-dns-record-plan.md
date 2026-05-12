# Microsoft 365 External DNS Record Plan

## Purpose

This document defines the external DNS records needed to prepare the public domain for Microsoft 365 services.

## Public Domain

```text
summitridge-mfg.com
```

## Important Scope Note

This project prepares the DNS record plan only.

The actual Microsoft 365 custom domain verification, Exchange Online mail routing, DKIM activation, and email migration happen later in:

```text
Project 03 — Summit Ridge Custom Domain, UPN Suffix, and Email Migration
```

## DNS Hosting Options

The public DNS records may be hosted in one of these locations:

| Option | Description |
|---|---|
| Azure DNS Public Zone | Preferred portfolio option |
| Registrar DNS | Practical low-cost option |
| Cloudflare DNS | Acceptable managed DNS option |

## Required Microsoft 365 DNS Records

| Service | Record Type | Host/Name | Value | Purpose |
|---|---|---|---|---|
| Microsoft 365 domain verification | TXT | @ | Provided by Microsoft 365 | Verifies ownership of summitridge-mfg.com |
| Exchange Online mail routing | MX | @ | Provided by Microsoft 365 | Routes inbound mail to Exchange Online |
| Exchange Online Protection SPF | TXT | @ | v=spf1 include:spf.protection.outlook.com -all | Authorizes Microsoft 365 as a valid mail sender |
| Outlook Autodiscover | CNAME | autodiscover | autodiscover.outlook.com | Helps Outlook locate Exchange Online mailbox settings |
| DKIM selector 1 | CNAME | selector1._domainkey | Provided by Microsoft 365 | Enables DKIM email signing |
| DKIM selector 2 | CNAME | selector2._domainkey | Provided by Microsoft 365 | Enables DKIM email signing |
| DMARC | TXT | _dmarc | v=DMARC1; p=none; rua=mailto:dmarc@summitridge-mfg.com | Starts DMARC monitoring |

## Microsoft 365 Domain Verification

The TXT verification record proves that the company owns the public domain.

Microsoft 365 provides the exact TXT value during domain setup.

The domain should not be used for production sign-in or email migration until verification succeeds.

## Exchange Online MX Record

The MX record controls where inbound email is delivered.

MX cutover should not happen until:

1. The domain is verified in Microsoft 365.
2. Exchange Online mailboxes are ready.
3. Pilot users are selected.
4. Mail flow testing is planned.
5. Rollback steps are documented.

## SPF Record

Recommended Microsoft 365 SPF record:

```text
v=spf1 include:spf.protection.outlook.com -all
```

This authorizes Exchange Online Protection to send email for the domain.

## DKIM Records

DKIM requires two CNAME records for the custom domain.

The exact DKIM target values should be copied from the Microsoft 365 Defender portal or Exchange Online DKIM configuration page.

## DMARC Record

Initial monitoring DMARC record:

```text
v=DMARC1; p=none; rua=mailto:dmarc@summitridge-mfg.com
```

The company should start with `p=none` to monitor authentication results before moving to stricter policies such as `quarantine` or `reject`.

## Why p=none First

A strict DMARC policy too early can block legitimate mail if SPF or DKIM is incomplete.

Starting with monitoring helps the company understand legitimate senders before enforcing rejection.

## Records Not Added in This Project

This project does not add or activate:

- MX cutover
- DKIM activation
- User UPN migration
- Primary SMTP address migration
- Production mail flow changes

## Risk

Incorrect public DNS records can cause:

- Microsoft 365 domain verification failure
- Inbound email failure
- Outbound mail authentication failure
- Spoofing risk
- Outlook Autodiscover issues
- User sign-in confusion
- Increased helpdesk tickets

## Risk Treatment

The project reduces risk by:

- Planning the records before implementation
- Delaying MX cutover until Project 03
- Starting DMARC at p=none
- Using Microsoft-provided DKIM values
- Keeping internal AD DNS separate from public DNS
- Validating all records before user migration

## Business Value

This DNS plan prepares Summit Ridge Manufacturing Group for professional Microsoft 365 identity and email service using:

```text
first.last@summitridge-mfg.com
```

It supports a safer domain migration by separating planning from production cutover.
