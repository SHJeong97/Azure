# Public DNS Final Decision

## Decision

Summit Ridge Manufacturing Group will use a managed DNS provider for the public domain:

```text
summitridge-mfg.com
```

## Preferred Portfolio Decision

The preferred portfolio design is:

```text
Azure DNS Public Zone
```

## Practical Lab Option

If registrar DNS is simpler or already included with the purchased domain, the lab may use:

```text
Registrar DNS
```

or:

```text
Cloudflare DNS
```

## Reasoning

The company needs public DNS records for Microsoft 365 and Exchange Online, but it does not need to host public DNS on a Windows Server VM.

Managed public DNS is better because it reduces:

- VM cost
- Patch management
- DNS server hardening work
- Public attack surface
- Availability burden
- Monitoring burden

## Azure DNS Delegation Requirement

If Azure DNS is used, the public DNS zone must be created in Azure and then delegated at the domain registrar by replacing the registrar name servers with the Azure DNS name servers.

## Registrar DNS Requirement

If registrar DNS is used, the Microsoft 365 records will be created directly at the registrar DNS host.

## Security Boundary

Internal AD DNS stays private.

Public DNS hosts only public records for:

- Microsoft 365
- Exchange Online
- Email authentication
- Autodiscover
- Future application publishing

Public DNS does not host internal AD records such as:

- _ldap._tcp.dc._msdcs.corp.democompany1016.local
- _kerberos._tcp.corp.democompany1016.local
- DC01.corp.democompany1016.local
- DC02.corp.democompany1016.local

## Business Value

This decision gives the company a secure and supportable DNS model:

```text
Internal DNS:
Private AD-integrated DNS on DC01/DC02

External DNS:
Managed public DNS for summitridge-mfg.com
```

This supports Microsoft 365 readiness while reducing operational and security risk.
