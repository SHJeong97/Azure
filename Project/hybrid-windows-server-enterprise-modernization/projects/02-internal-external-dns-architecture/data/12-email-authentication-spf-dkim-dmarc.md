# Email Authentication: SPF, DKIM, and DMARC

## Purpose

This document explains how Summit Ridge Manufacturing Group will use SPF, DKIM, and DMARC to protect the public email domain:

```text
summitridge-mfg.com
```

## Why Email Authentication Matters

Without email authentication, attackers may spoof the company domain in phishing campaigns.

For a 250-user company, spoofed email can create:

- Credential theft risk
- Vendor fraud risk
- Payroll fraud risk
- Helpdesk ticket increase
- Brand trust damage
- Compliance concerns

## SPF

SPF stands for Sender Policy Framework.

SPF tells receiving mail systems which mail servers are allowed to send email for the domain.

Planned Microsoft 365 SPF record:

```text
v=spf1 include:spf.protection.outlook.com -all
```

## DKIM

DKIM stands for DomainKeys Identified Mail.

DKIM uses cryptographic signing to prove that the message was authorized by the domain and was not modified in transit.

Microsoft 365 custom domains use two DKIM CNAME records:

```text
selector1._domainkey
selector2._domainkey
```

The exact CNAME targets are provided by Microsoft 365.

## DMARC

DMARC stands for Domain-based Message Authentication, Reporting, and Conformance.

DMARC tells receiving mail systems what to do when messages fail SPF or DKIM alignment.

Initial monitoring record:

```text
v=DMARC1; p=none; rua=mailto:dmarc@summitridge-mfg.com
```

## DMARC Policy Stages

| Stage | Policy | Purpose |
|---|---|---|
| Monitoring | p=none | Collect reports without blocking mail |
| Partial enforcement | p=quarantine | Send suspicious mail to spam/quarantine |
| Full enforcement | p=reject | Reject mail that fails authentication |

## Why Start with p=none

Starting with p=none reduces the risk of blocking legitimate business mail.

The company should review reports and confirm all legitimate senders before moving to stricter policies.

## Business Value

SPF, DKIM, and DMARC reduce spoofing risk, improve email trust, support secure Microsoft 365 mail flow, and reduce the chance that users trust fraudulent messages.
