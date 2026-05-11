
# DNS Business Scenario

## Company

Summit Ridge Manufacturing Group is a simulated 250-user company modernizing from traditional Windows Server infrastructure into a Microsoft hybrid environment.

## Current State

| Area | Value |
|---|---|
| Internal AD DS domain | corp.democompany1016.local |
| Internal DNS servers | DC01 and DC02 |
| Microsoft tenant | democompany1016.onmicrosoft.com |
| Future public domain | summitridge-mfg.com |

## Business Problem

The company needs reliable internal DNS for Active Directory while also preparing for a public business domain used by Microsoft 365, Exchange Online, and user sign-in.

Internal Active Directory DNS records must remain private and should not be exposed to the internet.

## Business Need

The company needs a split DNS model:

- Internal DNS for AD DS, domain-joined systems, and private application names
- External DNS for Microsoft 365, email routing, public verification, and future internet-facing records

## Risk If Done Incorrectly

Poor DNS design can cause:

- Domain join failures
- Kerberos authentication issues
- Group Policy failures
- Microsoft 365 domain verification problems
- Mail delivery failure
- SPF/DKIM/DMARC misconfiguration
- Public exposure of internal AD DNS records
- Increased troubleshooting time and user downtime

## Business Value

A clear DNS architecture improves identity reliability, email security, Microsoft 365 readiness, troubleshooting, and security boundary separation.
