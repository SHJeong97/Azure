# DMARC Enforcement Roadmap

## Purpose

This document defines a staged DMARC roadmap for Summit Ridge Manufacturing Group.

## Domain

```text
summitridge-mfg.com
```

## Current Email Authentication Result

| Control | Current Result |
|---|---|
| SPF | Valid single Microsoft 365 SPF record found |
| DMARC | Record found |
| DKIM | Not ready because selector CNAME records are missing |

## Current DMARC Policy

Current recommended project-stage policy:

```text
p=none
```

## Why DMARC Should Stay at p=none

DMARC should stay in monitoring mode because DKIM is not ready yet.

Moving to `p=quarantine` or `p=reject` before DKIM is ready could increase the risk of legitimate mail being filtered or rejected.

## DMARC Stages

| Stage | Policy | Purpose |
|---|---|---|
| Stage 1 | p=none | Monitor mail authentication without blocking mail |
| Stage 2 | p=quarantine | Send failing messages to spam/quarantine |
| Stage 3 | p=reject | Reject messages that fail authentication |

## Current Stage

```text
Stage 1 — Monitoring
```

## Requirements Before Moving to p=quarantine

Before moving from `p=none` to `p=quarantine`, the company should:

- Confirm SPF remains valid
- Create DKIM selector CNAME records
- Enable DKIM in Microsoft 365
- Validate DKIM signing
- Review DMARC reports
- Identify legitimate third-party senders
- Confirm business-critical systems are not failing authentication

## Requirements Before Moving to p=reject

Before moving from `p=quarantine` to `p=reject`, the company should:

- Confirm stable SPF alignment
- Confirm stable DKIM alignment
- Confirm no legitimate mail is failing authentication
- Communicate the enforcement change
- Monitor helpdesk tickets after enforcement

## Business Value

A staged DMARC roadmap reduces spoofing risk while avoiding accidental blocking of legitimate business email.
