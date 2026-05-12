# Risk and Rollback Plan

## Purpose

This document identifies the main risks in the Microsoft 365 custom domain and UPN migration project.

## Key Risk Areas

| Risk | Impact | Treatment |
|---|---|---|
| Wrong TXT verification record | Domain verification fails | Copy exact value from Microsoft 365 |
| Wrong MX record | Mail flow disruption | Delay MX cutover until mailbox readiness |
| Wrong SPF record | Outbound mail may fail authentication | Use one SPF TXT record only |
| DKIM CNAME typo | DKIM cannot be enabled | Copy exact Microsoft 365 DKIM values |
| DMARC policy too strict | Legitimate mail may be rejected | Start with p=none |
| UPN change too broad | User sign-in disruption | Use pilot users first |
| Internal AD DNS confusion | Authentication issues | Keep internal AD DNS separate from public DNS |
| Poor communication | Helpdesk ticket increase | Document user impact and rollback |

## Rollback Principles

Rollback should be simple and fast.

Before changing pilot users:

- Export current user UPNs
- Document old UPN values
- Document new UPN values
- Change only pilot users
- Validate sign-in
- Keep rollback commands ready

## UPN Rollback Example

If a pilot user UPN change causes problems, revert from:

```text
emma.wilson@summitridge-mfg.com
```

back to:

```text
emma.wilson@corp.democompany1016.local
```

## Mail Flow Rollback

If MX cutover causes mail issues:

1. Revert MX record to previous mail provider if applicable.
2. Validate inbound mail delivery.
3. Pause further migration.
4. Review DNS records.
5. Document the incident.

## Safety Rule

Project 03 should validate and pilot before broad rollout.

## Business Value

A rollback plan reduces business disruption and gives IT a controlled path to recover from DNS, identity, or mail flow mistakes.
