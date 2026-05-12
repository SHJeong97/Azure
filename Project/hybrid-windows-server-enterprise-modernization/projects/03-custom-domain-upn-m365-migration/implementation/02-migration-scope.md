# Migration Scope

## Purpose

This document defines what Project 03 will and will not change.

## In Scope

Project 03 includes:

- Microsoft 365 custom domain planning
- summitridge-mfg.com domain verification
- Public DNS verification record planning
- Microsoft 365 DNS record planning
- Pilot UPN migration planning
- Pilot user UPN validation
- Exchange Online email address planning
- SPF, DKIM, and DMARC readiness documentation
- Risk and rollback planning

## Out of Scope

Project 03 does not include:

- AD DS domain rename
- Full production user migration
- Full Exchange mailbox migration from another provider
- Full MX cutover without validation
- Device migration
- Intune enrollment
- Conditional Access enforcement
- Entra Connect production rollout for every user

## Migration Strategy

The project uses a staged approach:

1. Prepare documentation and risk plan.
2. Add the public domain to Microsoft 365.
3. Verify domain ownership through DNS.
4. Prepare Microsoft 365 service DNS records.
5. Select pilot users.
6. Change pilot user UPNs.
7. Validate Microsoft 365 sign-in behavior.
8. Plan Exchange Online email addresses and aliases.
9. Delay broad rollout until validation succeeds.

## Why Staged Migration Matters

Changing user sign-in names and email domains can affect:

- User sign-in
- Outlook profile behavior
- Teams identity
- OneDrive access
- SharePoint access
- Mobile devices
- Helpdesk call volume

A staged pilot reduces risk before broader rollout.

## Success Criteria

Project 03 is successful when:

- summitridge-mfg.com is documented as the target public domain
- Microsoft 365 domain verification is planned or completed
- Required DNS records are documented
- Pilot UPN migration plan is created
- Risk and rollback steps are documented
- No broad production cutover is performed without validation
