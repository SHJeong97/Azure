# Public DNS Hosting Decision

## Decision

The public domain summitridge-mfg.com should be hosted using a managed public DNS provider.

## Preferred Option

Azure DNS Public Zone

## Alternative Option

Registrar DNS or Cloudflare DNS

## Rejected Option

A Windows Server DNS VM with a public IP address and port 53 exposed to the internet.

## Why Azure DNS Is Preferred for the Portfolio

Azure DNS aligns with the Microsoft cloud architecture used throughout this portfolio.

It allows DNS zones and records to be managed through Azure portal, Azure CLI, and Azure PowerShell.

It also supports later infrastructure-as-code and automation scenarios.

## Why Registrar DNS Is Also Acceptable

Registrar DNS is usually included with domain purchase and may be cheaper or simpler for a lab.

For a small company, registrar DNS is acceptable if it supports the required Microsoft 365 records.

## Why Public Windows DNS Is Rejected

A public Windows DNS server would add:

- Public attack surface
- VM cost
- Patch management
- Availability responsibility
- DDoS exposure
- Monitoring overhead
- Security hardening requirements

For a 250-user company, this creates more risk and cost than value.

## Business Value

Managed public DNS provides cleaner operations, lower maintenance, and better separation between private AD DNS and public internet DNS.
