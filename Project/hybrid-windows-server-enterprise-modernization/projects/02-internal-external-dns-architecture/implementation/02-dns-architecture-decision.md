# DNS Architecture Decision

## Decision

Summit Ridge Manufacturing Group will use a **split DNS architecture**.

The environment will separate:

- **Internal DNS** for Active Directory, domain-joined systems, and private application names
- **External DNS** for Microsoft 365, Exchange Online, public domain verification, and internet-facing records

---

## Internal DNS Design

Internal DNS will run on the existing domain controllers:

| Server | IP Address | Role |
|---|---:|---|
| DC01 | 10.10.1.10 | AD DS + DNS |
| DC02 | 10.10.1.11 | AD DS + DNS |

Internal DNS zone:

```text
corp.democompany1016.local
```

DNS zone type:

```text
AD-integrated DNS
```

The internal DNS zone will remain private and will not be exposed to the internet.

---

## External DNS Design

External DNS will be used for the company’s future public business domain:

```text
summitridge-mfg.com
```

External DNS will be hosted by a managed public DNS provider.

Preferred option:

```text
Azure DNS Public Zone
```

Acceptable low-cost alternatives:

```text
Registrar DNS
Cloudflare DNS
```

External DNS will be used for:

- Microsoft 365 domain verification
- Exchange Online MX record
- SPF record
- DKIM records
- DMARC record
- Autodiscover
- Future public application records

---

## Rejected Option

The company will **not** expose a Windows Server DNS VM to the public internet.

Rejected design:

```text
Internet
→ Public IP
→ Windows Server DNS VM
→ Port 53 exposed publicly
```

---

## Why Internal DNS Uses DC01 and DC02

Active Directory depends heavily on DNS.

Internal DNS is required for:

- Domain controller discovery
- Kerberos authentication
- LDAP lookup
- Global Catalog discovery
- Domain join
- Group Policy processing
- SYSVOL access
- NETLOGON access

Using DNS on DC01 and DC02 provides redundancy and allows DNS data to replicate through Active Directory.

This is better for a 250-user company than creating a separate standalone internal DNS server because a standalone DNS server would add:

- Extra VM cost
- Extra patching
- Extra monitoring
- Extra backup requirements
- Extra hardening work
- More troubleshooting complexity

---

## Why External DNS Uses a Managed Provider

Public DNS should be:

- Internet-facing
- Highly available
- Low maintenance
- Securely managed
- Separate from internal AD DS records

A managed DNS provider reduces operational burden and avoids exposing internal Windows Server infrastructure to the public internet.

---

## Business Problem Solved

The company needs to support both internal Windows Server authentication and future public Microsoft 365 services.

Internal users need reliable DNS for:

- Signing in to domain computers
- Accessing file shares
- Applying Group Policy
- Finding domain controllers
- Accessing internal applications

External services need public DNS for:

- Microsoft 365 domain verification
- Email routing
- Email authentication
- Outlook Autodiscover
- Future application publishing

---

## Risk If Configured Incorrectly

Poor DNS design can cause:

- Domain join failures
- Kerberos authentication issues
- LDAP lookup failures
- Group Policy failures
- File share access problems
- Microsoft 365 domain verification failure
- Exchange Online mail flow failure
- SPF/DKIM/DMARC misconfiguration
- Public exposure of internal AD DNS records
- Increased helpdesk tickets and downtime

---

## Risk Treatment

| Risk | Treatment |
|---|---|
| Internal DNS outage | Use two domain controllers with AD-integrated DNS |
| Public DNS misconfiguration | Use documented DNS record plan before making changes |
| Internal DNS exposed publicly | Keep AD DNS private and use managed public DNS |
| Email routing failure | Delay MX cutover until Project 03 validation |
| Spoofing risk | Plan SPF, DKIM, and DMARC records |
| Operational confusion | Document internal vs external DNS ownership |

---

## Business Value

This design protects internal Active Directory DNS while preparing the company for Microsoft 365 custom domain integration.

The split DNS model creates value by:

- Improving authentication reliability
- Supporting Microsoft 365 readiness
- Reducing public attack surface
- Separating internal and external DNS responsibilities
- Improving troubleshooting clarity
- Supporting future email security with SPF, DKIM, and DMARC
- Preparing for future application publishing through Entra Application Proxy

---

## Final Architecture Decision

```text
Internal DNS:
DC01 and DC02
AD-integrated zone: corp.democompany1016.local

External DNS:
Managed DNS provider
Public zone: summitridge-mfg.com

Rejected:
Public Windows Server DNS VM
```

This is the final DNS architecture for the hybrid enterprise portfolio.
