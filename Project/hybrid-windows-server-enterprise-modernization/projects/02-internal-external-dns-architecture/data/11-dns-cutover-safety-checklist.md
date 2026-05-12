# DNS Cutover Safety Checklist

## Purpose

This checklist prevents accidental Microsoft 365 mail flow or identity disruption during the public domain migration.

## Domain

```text
summitridge-mfg.com
```

## Before Adding Microsoft 365 DNS Records

- [ ] Confirm who owns the public DNS host
- [ ] Confirm whether DNS is hosted at registrar, Cloudflare, or Azure DNS
- [ ] Confirm access to edit public DNS records
- [ ] Confirm internal AD DNS remains separate
- [ ] Confirm no internal AD records are published publicly

## Before Microsoft 365 Domain Verification

- [ ] Add the custom domain in Microsoft 365 admin center
- [ ] Copy the exact TXT verification value from Microsoft 365
- [ ] Add TXT record at the public DNS host
- [ ] Wait for DNS propagation
- [ ] Verify the domain in Microsoft 365

## Before MX Cutover

- [ ] Confirm Exchange Online mailboxes are ready
- [ ] Confirm pilot users are selected
- [ ] Confirm accepted domain exists in Exchange Online
- [ ] Confirm old email aliases are planned
- [ ] Confirm rollback plan exists
- [ ] Confirm helpdesk/user communication is ready
- [ ] Confirm MX record value from Microsoft 365
- [ ] Confirm no conflicting MX records remain

## Before SPF Record Enforcement

- [ ] Confirm Microsoft 365 is authorized sender
- [ ] Identify any third-party systems that send email
- [ ] Add third-party senders if needed
- [ ] Avoid multiple SPF TXT records for the same domain

## Before DKIM Activation

- [ ] Confirm custom domain is verified
- [ ] Copy selector1 CNAME value from Microsoft 365
- [ ] Copy selector2 CNAME value from Microsoft 365
- [ ] Add both CNAME records to public DNS
- [ ] Validate DKIM CNAME resolution
- [ ] Enable DKIM signing in Microsoft 365

## Before DMARC Enforcement

- [ ] Start with p=none
- [ ] Review DMARC reports
- [ ] Confirm SPF alignment
- [ ] Confirm DKIM alignment
- [ ] Identify legitimate senders
- [ ] Move to quarantine or reject only after validation

## Rollback Planning

If mail flow breaks after MX change:

1. Revert MX record to previous mail provider if applicable.
2. Lower TTL before planned cutover when possible.
3. Validate inbound mail flow.
4. Document incident timeline.
5. Pause additional user migration.

## Business Value

A DNS cutover checklist reduces risk during domain verification, email migration, and Microsoft 365 service activation.
