# Project 02 — Internal and External DNS Architecture for Hybrid Enterprise

## Introduction

This project designs and validates a split DNS architecture for **Summit Ridge Manufacturing Group**, a simulated 250-user company using Windows Server Active Directory while preparing for Microsoft 365 custom domain integration.

The company uses internal Active Directory DNS for domain authentication, domain-joined systems, internal server names, and private application records. The company also plans to use a public business domain for Microsoft 365, Exchange Online, email authentication, Autodiscover, and future application publishing.

The internal AD DS domain is:

```text
corp.democompany1016.local
```

The future public business domain is:

```text
summitridge-mfg.com
```

This project separates private internal DNS from public external DNS and documents why a managed public DNS provider is safer and more supportable than exposing a Windows DNS server to the internet.

---

## Objectives

- Validate internal AD-integrated DNS on DC01 and DC02
- Keep internal AD DNS separate from public DNS
- Create planned internal DNS A records
- Create friendly CNAME aliases for future services
- Create reverse lookup zones for internal subnets
- Configure and validate DNS forwarders
- Validate internal recursion behavior
- Disable DNS zone transfers
- Enforce secure dynamic updates
- Confirm DC01/DC02 are not public DNS servers
- Document the public DNS hosting decision for `summitridge-mfg.com`
- Prepare Microsoft 365 DNS record planning for Exchange Online and domain verification
- Document SPF, DKIM, and DMARC planning
- Connect DNS design to business risk, security, and operational value

---

## Full Implementation

This project was implemented in seven batches:

1. **DNS business scenario, architecture decision, folder structure, and planning files**
2. **Internal AD-integrated DNS validation on DC01/DC02**
3. **Internal DNS records, aliases, and reverse lookup zone**
4. **DNS forwarding, recursion, and internal DNS security baseline**
5. **Public DNS hosting decision for `summitridge-mfg.com`**
6. **Microsoft 365 external DNS record plan**
7. **Final validation and GitHub-ready README package**

---

## Implementation Walkthrough

### Batch 1 — DNS Business Scenario and Architecture Planning

The project began by documenting the business need for a split DNS architecture.

Summit Ridge Manufacturing Group needs two DNS layers:

```text
Internal DNS:
Used by domain-joined servers, domain-joined clients, and Active Directory services.

External DNS:
Used by Microsoft 365, Exchange Online, email authentication, and public records.
```

The internal DNS zone is:

```text
corp.democompany1016.local
```

The public DNS zone is:

```text
summitridge-mfg.com
```

The final architecture decision was:

```text
Internal DNS:
DC01 and DC02 using AD-integrated DNS

External DNS:
Managed public DNS provider

Rejected:
Public Windows Server DNS VM
```

This design protects internal AD DNS records while preparing the company for Microsoft 365 public DNS requirements.

---

### Batch 2 — Internal AD-Integrated DNS Validation

Internal DNS was validated from MGMT01.

DNS servers:

| Server | IP Address | Role |
|---|---:|---|
| DC01 | 10.10.1.10 | AD DS + DNS |
| DC02 | 10.10.1.11 | AD DS + DNS |

Validated internal records included:

```text
DC01.corp.democompany1016.local
DC02.corp.democompany1016.local
MGMT01.corp.democompany1016.local
```

Important AD SRV records were validated:

```text
_ldap._tcp.dc._msdcs.corp.democompany1016.local
_kerberos._tcp.corp.democompany1016.local
_gc._tcp.corp.democompany1016.local
```

This confirmed that domain clients can locate domain controllers, Kerberos services, LDAP services, and Global Catalog services.

---

### Batch 3 — Internal DNS Records, Aliases, and Reverse Lookup Zones

Reverse lookup zones were created for the internal subnets:

| Subnet | Reverse Zone |
|---|---|
| 10.10.1.0/24 | 1.10.10.in-addr.arpa |
| 10.10.2.0/24 | 2.10.10.in-addr.arpa |
| 10.10.3.0/24 | 3.10.10.in-addr.arpa |
| 10.10.4.0/24 | 4.10.10.in-addr.arpa |

Planned A records were created for future servers:

| Record | IP Address | Purpose |
|---|---:|---|
| fs01.corp.democompany1016.local | 10.10.3.10 | Future file server |
| app01.corp.democompany1016.local | 10.10.3.20 | Future internal application server |

Friendly CNAME aliases were created:

| Alias | Target | Purpose |
|---|---|---|
| files.corp.democompany1016.local | fs01.corp.democompany1016.local | User-friendly file server alias |
| intranet.corp.democompany1016.local | app01.corp.democompany1016.local | User-friendly internal app alias |

PTR records were validated for:

| IP Address | PTR Result |
|---|---|
| 10.10.1.10 | DC01.corp.democompany1016.local |
| 10.10.1.11 | DC02.corp.democompany1016.local |
| 10.10.2.10 | MGMT01.corp.democompany1016.local |
| 10.10.3.10 | fs01.corp.democompany1016.local |
| 10.10.3.20 | app01.corp.democompany1016.local |

DC01 and DC02 required manual PTR record creation because the reverse lookup zone was created after the domain controllers already existed. This was documented and corrected during final validation.

These aliases and reverse records support easier troubleshooting, cleaner documentation, and smoother future migration.

---

### Batch 4 — DNS Forwarding, Recursion, and Security Baseline

DNS forwarders were configured and validated.

Forwarder:

```text
168.63.129.16
```

Recursion remained enabled for internal clients because internal domain-joined systems need to resolve external names through DC01/DC02.

The security boundary is not created by disabling recursion internally. The security boundary is created by keeping the DNS servers private and blocking public internet access to DC01/DC02.

Zone security was validated:

| Setting | Result |
|---|---|
| Zone type | AD-integrated |
| Dynamic updates | Secure |
| Zone transfers | Disabled |
| Replication | Active Directory replication |

Zone transfer testing confirmed that AXFR transfers were blocked or refused.

This prevents bulk DNS zone exposure.

---

### Batch 5 — Public DNS Hosting Decision

The public DNS hosting decision was documented for:

```text
summitridge-mfg.com
```

The preferred portfolio option is:

```text
Azure DNS Public Zone
```

Acceptable practical options are:

```text
Registrar DNS
Cloudflare DNS
```

Rejected option:

```text
Public Windows Server DNS VM
```

A public Windows DNS server was rejected because it would add:

- Public attack surface
- VM cost
- Patching requirements
- Monitoring requirements
- Availability responsibility
- DDoS exposure
- Open resolver risk
- Extra hardening work

For a 250-user company, managed public DNS creates a cleaner and safer operating model.

---

### Batch 6 — Microsoft 365 External DNS Record Plan

A Microsoft 365 DNS record plan was created for:

```text
summitridge-mfg.com
```

Planned records include:

| Service | Record Type | Host/Name | Purpose |
|---|---|---|---|
| Microsoft 365 domain verification | TXT | @ | Prove domain ownership |
| Exchange Online | MX | @ | Route inbound mail |
| SPF | TXT | @ | Authorize Microsoft 365 senders |
| Autodiscover | CNAME | autodiscover | Outlook mailbox discovery |
| DKIM selector 1 | CNAME | selector1._domainkey | Email signing |
| DKIM selector 2 | CNAME | selector2._domainkey | Email signing |
| DMARC | TXT | _dmarc | Email authentication monitoring |

Initial DMARC policy:

```text
v=DMARC1; p=none; rua=mailto:dmarc@summitridge-mfg.com
```

The project intentionally delays MX cutover and DKIM activation until Project 03, after Microsoft 365 domain verification and mailbox readiness.

---

### Batch 7 — Final Validation

Final validation confirmed:

- Internal DNS resolution
- Reverse DNS lookup
- CNAME aliases
- DNS forwarders
- Internal recursion
- Secure dynamic updates
- Zone transfer blocking
- DNS zone baseline
- Public DNS hosting decision
- Microsoft 365 DNS record planning
- Evidence and data exports

---

## Results & Validation

### Final DNS Architecture

```text
Internal DNS
├── DC01 - 10.10.1.10
│   ├── AD DS
│   ├── DNS
│   └── AD-integrated zone: corp.democompany1016.local
│
└── DC02 - 10.10.1.11
    ├── AD DS
    ├── DNS
    └── AD-integrated zone: corp.democompany1016.local

External DNS
└── summitridge-mfg.com
    ├── Microsoft 365 verification TXT
    ├── Exchange Online MX
    ├── SPF TXT
    ├── DKIM CNAME records
    ├── DMARC TXT
    ├── Autodiscover CNAME
    └── Future application records
```

### Internal DNS Results

| Item | Result |
|---|---|
| Internal DNS servers | DC01 and DC02 |
| Internal DNS zone | corp.democompany1016.local |
| Zone type | AD-integrated |
| Dynamic updates | Secure |
| Zone transfers | Disabled |
| Forwarder | 168.63.129.16 |
| Internal recursion | Enabled |
| Public DNS exposure | Blocked by design |

### Internal DNS Records

| Name | Type | Target/IP |
|---|---|---|
| DC01 | A | 10.10.1.10 |
| DC02 | A | 10.10.1.11 |
| MGMT01 | A | 10.10.2.10 |
| FS01 | A | 10.10.3.10 |
| APP01 | A | 10.10.3.20 |
| files | CNAME | fs01.corp.democompany1016.local |
| intranet | CNAME | app01.corp.democompany1016.local |

### Reverse Lookup Results

| IP Address | PTR Record |
|---|---|
| 10.10.1.10 | DC01.corp.democompany1016.local |
| 10.10.1.11 | DC02.corp.democompany1016.local |
| 10.10.2.10 | MGMT01.corp.democompany1016.local |
| 10.10.3.10 | fs01.corp.democompany1016.local |
| 10.10.3.20 | app01.corp.democompany1016.local |

### Public DNS Planning Results

| Item | Decision |
|---|---|
| Public domain | summitridge-mfg.com |
| Preferred DNS host | Azure DNS Public Zone |
| Practical low-cost DNS host | Registrar DNS or Cloudflare |
| Public Windows DNS server | Rejected |
| Microsoft 365 DNS records | Planned |
| MX cutover | Delayed until Project 03 |
| DKIM activation | Delayed until Project 03 |
| DMARC enforcement | Start with p=none |

---

## Validation Walkthrough

Validation evidence was collected throughout each batch.

Evidence was captured for:

- Project folder structure
- DNS architecture decision
- Public DNS hosting decision
- Internal DNS record plan
- Microsoft 365 DNS record plan
- DNS risk register
- Internal DNS validation
- AD SRV record validation
- DNS Manager screenshots
- Reverse lookup zones
- Planned A records
- CNAME aliases
- PTR record correction for DC01 and DC02
- Forwarder configuration
- Recursion validation
- Secure dynamic update validation
- Zone transfer blocking
- DC public IP exposure check
- Domain controller NSG review
- Public DNS planning files
- Microsoft 365 DNS planning files
- Final DNS exports

Evidence folders:

```text
evidence/screenshots/
evidence/command-outputs/
evidence/validation-notes/
```

Data exports:

```text
data/
```

Implementation notes:

```text
implementation/
```

Scripts:

```text
scripts/powershell/
scripts/azure-cli/
```

Important data files include:

```text
internal-dns-record-plan.csv
external-dns-record-plan.csv
m365-dns-record-plan.csv
m365-dns-record-plan-detailed.csv
dns-risk-register.csv
azure-dns-public-zone-plan.csv
registrar-dns-plan.csv
project-02-final-dc01-forward-records.csv
project-02-final-dc02-forward-records.csv
project-02-final-dns-zone-baseline.csv
```

Important implementation files include:

```text
01-dns-business-scenario.md
02-dns-architecture-decision.md
03-public-dns-hosting-decision.md
04-internal-dns-validation.md
05-internal-dns-records-aliases-reverse-zones.md
06-dns-forwarding-recursion-security-baseline.md
07-public-dns-hosting-comparison.md
08-public-dns-final-decision.md
09-public-dns-delegation-plan.md
10-m365-external-dns-record-plan.md
11-dns-cutover-safety-checklist.md
12-email-authentication-spf-dkim-dmarc.md
```

---

## Key Takeaways

This project created a realistic DNS architecture for a hybrid Windows Server and Microsoft 365 environment.

Key technical outcomes:

- Internal DNS remains private and AD-integrated
- DC01 and DC02 provide internal DNS redundancy
- Internal DNS supports AD DS, Kerberos, LDAP, Group Policy, SYSVOL, and NETLOGON
- Friendly CNAME aliases improve usability and migration flexibility
- Reverse lookup zones improve troubleshooting
- PTR records improve IP-to-hostname troubleshooting
- DNS forwarders support external name resolution
- Zone transfers are disabled to reduce data exposure
- Secure dynamic updates protect AD DNS records
- Public DNS is separated from internal DNS
- Microsoft 365 DNS records are planned before implementation

Business value created:

- Improves authentication reliability
- Reduces DNS-related outage risk
- Reduces public attack surface
- Protects internal AD DNS records
- Prepares for Microsoft 365 custom domain verification
- Prepares for Exchange Online mail flow
- Supports future SPF, DKIM, and DMARC email security
- Creates safer preparation for UPN and email domain migration
- Improves troubleshooting for internal systems and future file/app services

This project prepares the next portfolio project:

```text
Project 03 — Summit Ridge Custom Domain, UPN Suffix, and Microsoft 365 Domain Migration
```

Project 03 will use the public domain:

```text
summitridge-mfg.com
```

and will focus on Microsoft 365 domain verification, user UPN planning, Exchange Online email addressing, aliases, and validation.
