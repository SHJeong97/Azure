# Project 02 — Internal and External DNS Architecture for Hybrid Enterprise

## Introduction

This project designs and validates a split DNS architecture for Summit Ridge Manufacturing Group, a simulated 250-user company using Windows Server Active Directory and preparing for Microsoft 365 custom domain integration.

The internal DNS environment supports AD DS, domain authentication, domain-joined systems, and internal application names. The external DNS environment supports Microsoft 365 domain verification, Exchange Online, SPF, DKIM, DMARC, Autodiscover, and future public records for summitridge-mfg.com.

## Objectives

- Validate internal AD-integrated DNS on DC01 and DC02
- Keep internal AD DNS separate from public DNS
- Document why a public Windows DNS server is not used
- Prepare internal DNS records and aliases
- Prepare external DNS records for summitridge-mfg.com
- Prepare Microsoft 365 DNS record plan
- Document DNS risk and business impact
- Prepare the environment for Project 03 domain verification and email migration

## Full Implementation

This project will be implemented in seven batches:

1. DNS business scenario, architecture decision, folder structure, and planning files
2. Internal AD-integrated DNS validation on DC01/DC02
3. Internal DNS records, aliases, and reverse lookup zone
4. DNS forwarding, recursion, and internal DNS security baseline
5. Public DNS hosting decision for summitridge-mfg.com
6. Microsoft 365 external DNS record plan
7. Final validation and GitHub-ready README package

## Implementation Walkthrough

Batch 1 created the project folder structure, DNS business scenario, architecture decision, public DNS hosting decision, DNS record plans, Microsoft 365 DNS plan, and DNS risk register.

## Results & Validation

Batch 1 validation items:

- Project folder structure created
- DNS business scenario documented
- DNS architecture decision documented
- Public DNS hosting decision documented
- Internal DNS record plan created
- External DNS record plan created
- Microsoft 365 DNS record plan created
- DNS risk register created

## Validation Walkthrough

Evidence to collect:

- Screenshot of Project 02 folder structure
- Screenshot of created implementation files
- Screenshot of internal DNS record plan
- Screenshot of external DNS record plan
- Screenshot of Microsoft 365 DNS record plan
- Screenshot of DNS risk register

## Key Takeaways

This batch established the design logic for split DNS. Internal DNS remains private and AD-integrated on DC01/DC02, while public DNS for summitridge-mfg.com will use a managed DNS provider such as Azure DNS Public Zone, registrar DNS, or Cloudflare.
