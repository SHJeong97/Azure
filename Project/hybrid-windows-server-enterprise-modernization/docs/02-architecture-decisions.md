# Architecture Decisions

## Decision 01 — Internal DNS Placement

### Decision
Internal DNS will run on DC01 and DC02 as AD-integrated DNS zones.

### Reason
Active Directory depends on DNS for domain controller discovery, Kerberos, LDAP, Global Catalog lookup, domain join, and Group Policy processing. Running DNS on two domain controllers provides redundancy and simplifies AD replication.

### Alternative Considered
A standalone internal DNS server was considered.

### Reason Rejected
For a 250-user company, a standalone DNS VM adds cost, patching, monitoring, backup, and hardening requirements without enough benefit for the baseline environment.

### Risk
If both DC01 and DC02 are offline, internal DNS and authentication are affected.

### Risk Treatment
Use two domain controllers, AD-integrated DNS replication, Azure VM backup, monitoring alerts, and documented recovery steps.

### Business Value
This design improves authentication reliability, reduces unnecessary infrastructure cost, and keeps the hybrid identity foundation simple and supportable.

---

## Decision 02 — Public DNS Hosting

### Decision
Public DNS for the future business domain will be hosted using a managed DNS provider such as Azure DNS Public Zone, registrar DNS, or Cloudflare.

### Rejected Option
A public Windows Server DNS VM with port 53 exposed to the internet was rejected.

### Reason
Public DNS should be highly available, externally reachable, secure, and low-maintenance. Hosting public DNS on a Windows Server VM would add patching, hardening, monitoring, availability, and attack-surface concerns without enough business value for a 250-user company.

### Business Value
The managed DNS approach reduces operational burden, improves reliability, supports Microsoft 365 domain verification and mail flow, and keeps internal AD DNS isolated from the internet.

---

## Decision 03 — Internal AD DS Domain Name

### Decision
The internal AD DS domain will be corp.democompany1016.local.

### Reason
The internal AD DS namespace should remain stable and separate from the public Microsoft 365 sign-in and email domain.

### Future Change
The company will later purchase a public domain such as summitridgemfg.com. That public domain will be added as a Microsoft 365 verified domain and as an AD DS UPN suffix.

### Rejected Option
Renaming the AD DS domain later was rejected.

### Reason Rejected
AD domain rename is risky and can affect domain joins, Kerberos, Group Policy, certificates, service accounts, applications, scripts, file permissions, and hybrid identity synchronization.

### Business Value
Keeping the internal AD DS domain stable reduces operational risk while still allowing users to sign in and send email with a professional public domain later.
