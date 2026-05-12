# DNS Forwarding, Recursion, and Security Baseline

## Purpose

This implementation configured and validated the DNS forwarding, recursion, and security baseline for the Summit Ridge internal DNS environment.

## DNS Servers

| Server | IP Address | Role |
|---|---:|---|
| DC01 | 10.10.1.10 | AD DS + DNS |
| DC02 | 10.10.1.11 | AD DS + DNS |

## Forwarder Design

The internal DNS servers use the Azure-provided DNS resolver as the forwarder:

```text
168.63.129.16
```

Internal clients send DNS queries to DC01/DC02.

DC01/DC02 resolve internal AD DNS records directly and forward external DNS queries when needed.

## Recursion Decision

Recursion remains enabled on DC01 and DC02 for internal domain clients.

This is required so domain-joined systems can resolve external names through internal DNS.

## Security Boundary

The DNS servers are internal only.

DC01 and DC02 should not have public IP addresses.

The domain controller subnet NSG should not allow inbound DNS from the internet.

## Zone Security

The internal AD DNS zones use:

| Setting | Value |
|---|---|
| Zone type | AD-integrated |
| Dynamic updates | Secure |
| Zone transfers | Disabled |
| Replication | Active Directory replication |

## Why Zone Transfers Are Disabled

Zone transfers can expose DNS records in bulk.

For internal AD DNS, zone transfers are not required because AD-integrated DNS replicates through Active Directory.

## Business Problem

The company needs internal DNS to resolve both internal AD names and external internet names, but it must avoid becoming an open public DNS resolver.

## Risk

Incorrect DNS configuration can create:

- Authentication issues
- External name resolution failure
- Public DNS exposure
- DNS zone data leakage
- Open resolver abuse
- Increased attack surface

## Risk Treatment

The risk is reduced by:

- Keeping DNS servers private
- Preventing public IP exposure on domain controllers
- Blocking inbound public DNS through NSGs
- Using secure dynamic updates
- Disabling zone transfers
- Validating recursion only for internal use
- Documenting forwarder behavior

## Business Value

This baseline supports reliable internal authentication and external name resolution while reducing DNS security risk.

It prepares the company for later Microsoft 365 DNS configuration and public DNS separation.
