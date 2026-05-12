# Public DNS Hosting Comparison

## Purpose

This document compares the public DNS hosting options for the Summit Ridge Manufacturing Group public domain:

```text
summitridge-mfg.com
```

## Business Context

The company purchased a public domain to support Microsoft 365, Exchange Online, external email authentication, and future application publishing.

The public DNS zone must stay separate from the internal Active Directory DNS zone.

## Current Internal DNS

| Item | Value |
|---|---|
| Internal AD DS domain | corp.democompany1016.local |
| Internal DNS servers | DC01 and DC02 |
| Internal DNS type | AD-integrated DNS |
| Internal DNS exposure | Private only |

## Public DNS Requirement

The public domain must support DNS records for:

- Microsoft 365 domain verification
- Exchange Online MX record
- SPF
- DKIM
- DMARC
- Autodiscover
- Future public application names

## Option A — Azure DNS Public Zone

Azure DNS Public Zone can host the public DNS zone for summitridge-mfg.com.

### Advantages

- Aligns with Azure-based portfolio architecture
- Supports Azure Portal, Azure CLI, and PowerShell management
- Good for automation and infrastructure-as-code later
- Keeps DNS management inside Azure
- Good interview talking point for Azure administration

### Disadvantages

- Requires delegation from the registrar to Azure DNS name servers
- Adds another Azure resource to track
- May be unnecessary for a small lab if registrar DNS is already included

### Best Fit

Azure DNS is best if the company wants cloud-managed DNS with Azure-native administration and automation.

## Option B — Registrar DNS or Cloudflare DNS

Registrar DNS or Cloudflare DNS can host the public DNS zone without moving DNS hosting into Azure.

### Advantages

- Often included with the domain purchase
- Lower complexity for small environments
- Easy to configure Microsoft 365 DNS records
- Good enough for many 100–500 user companies

### Disadvantages

- DNS management is outside Azure
- Automation may vary by provider
- Portal experience depends on registrar
- Evidence may be less Azure-focused

### Best Fit

Registrar DNS or Cloudflare is best if the company wants the simplest and lowest-cost public DNS setup.

## Rejected Option — Public Windows DNS Server

The company will not expose a Windows Server DNS VM publicly.

Rejected design:

```text
Internet
→ Public IP
→ Windows Server DNS VM
→ Port 53 exposed publicly
```

### Why Rejected

A public Windows DNS server would create:

- Public attack surface
- VM cost
- Patch management responsibility
- Monitoring responsibility
- Availability responsibility
- DDoS exposure
- Open resolver risk
- Extra hardening work

For a 250-user company, this creates more risk and cost than value.

## Final Decision

For this portfolio, the preferred design is:

```text
Primary recommendation:
Azure DNS Public Zone

Acceptable practical option:
Registrar DNS / Cloudflare DNS

Rejected:
Public Windows DNS server
```

## Business Value

The managed public DNS approach provides:

- Separation between private AD DNS and public DNS
- Cleaner Microsoft 365 domain verification
- Lower public attack surface
- Better operational reliability
- Lower maintenance than self-hosted public DNS
- A safer foundation for future Exchange Online and Application Proxy records
