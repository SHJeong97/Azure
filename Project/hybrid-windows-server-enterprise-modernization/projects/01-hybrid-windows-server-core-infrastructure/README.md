# Project 01 — Hybrid Windows Server Core Infrastructure Foundation

## Introduction

This project builds the reusable hybrid Windows Server foundation for Summit Ridge Manufacturing Group, a simulated 250-user company modernizing from traditional Windows Server administration into a secure Microsoft hybrid environment.

The foundation includes Azure networking, Windows Server domain controllers, Active Directory Domain Services, AD-integrated DNS, a management server, and a structure that supports later projects involving hybrid identity, Microsoft 365, Azure Files, Entra Application Proxy, Azure Arc, backup, disaster recovery, and Intune.

## Objectives

- Design a reusable hybrid lab foundation for a 250-user company
- Create a cost-controlled Azure deployment plan
- Use AD-integrated DNS on two domain controllers
- Keep internal DNS separate from public DNS
- Prepare an internal AD DS domain: corp.democompany1016.local
- Prepare for a future public domain: summitridgemfg.com
- Build documentation that connects technical design to business risk and value

## Full Implementation

This project will be implemented in eight batches:

1. Business scenario, architecture, subscription/license checklist, and cost-control setup
2. Azure resource group, VNet, subnets, and NSG baseline
3. Deploy DC01, DC02, and MGMT01
4. Install AD DS, DNS, and create the forest/domain
5. Configure DNS, domain join, RSAT, and management access
6. Create OU model, users, groups, admin accounts, and service accounts
7. Configure hybrid-ready UPN suffix, naming standards, and baseline documentation
8. Validate infrastructure and create the final evidence package

## Implementation Walkthrough

Batch 1 established the architecture and business justification before any major Azure resources were deployed.

The key architecture decisions were:

- Internal DNS will run on DC01 and DC02 as AD-integrated DNS.
- Public DNS will use a managed DNS provider later.
- The internal AD DS domain will remain stable as corp.democompany1016.local.
- The future public domain will be used as a UPN suffix and email domain, not as an AD DS rename.
- Cost controls must be configured before deploying virtual machines.
- EMS E5 will support identity security, Conditional Access, Intune, and endpoint management scenarios later in the portfolio.

## Results & Validation

Batch 1 validation items:

- Project folder structure created
- Architecture decisions documented
- Subscription and license plan documented
- Cost-control plan documented
- Server plan CSV created
- Network plan CSV created
- Domain plan CSV created
- Azure budget alert configured

## Validation Walkthrough

Evidence to collect:

- Screenshot of Azure budget alert
- CSV files showing server, network, and domain plan
- Architecture decision document
- Cost-control document
- Subscription/license document

## Key Takeaways

This batch shows that a strong hybrid Windows Server project starts with architecture, cost control, and risk decisions before deployment. The design avoids unnecessary servers, separates internal and external DNS, and prepares the company for future Microsoft 365, Entra ID, Azure Files, Application Proxy, and Intune integration.
