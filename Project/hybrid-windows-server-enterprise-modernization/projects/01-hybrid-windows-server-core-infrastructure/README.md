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

### Batch 2 — Azure Network Foundation

Batch 2 created the Azure resource group, virtual network, four subnets, and subnet-level network security groups.

The network separates domain controllers, management systems, member servers, and workstation testing into different subnets. This supports future security hardening while avoiding unnecessary complexity during the initial AD DS build.

The NSG baseline does not expose RDP broadly to the internet. Internal communication is allowed during the foundation phase so AD DS, DNS, Kerberos, LDAP, SMB, and Group Policy can function correctly.

### Batch 3 — Windows Server VM Deployment

Batch 3 deployed the first three Windows Server VMs for the hybrid lab: DC01, DC02, and MGMT01.

DC01 and DC02 were placed in the domain controller subnet and assigned static private IP addresses for future AD DS and DNS use. MGMT01 was placed in the management subnet and prepared as the administrative access point.

The design avoids public IP addresses on the domain controllers. If direct RDP is needed, temporary access is limited to MGMT01 from the administrator's current public IP only.

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

Batch 2 validation items:
- Resource group rg-srmg-hybrid-core created
- Virtual network vnet-srmg-hybrid-eastus created
- Four subnets created
- Four NSGs created
- NSGs associated to their matching subnets
- No VMs deployed yet
  
Batch 3 validation items:
- DC01 deployed
- DC02 deployed
- MGMT01 deployed
- DC01 private IP set to 10.10.1.10
- DC02 private IP set to 10.10.1.11
- MGMT01 private IP set to 10.10.2.10
- Auto-shutdown enabled
- Domain controllers not exposed directly to the internet

## Validation Walkthrough

Evidence to collect:

- Screenshot of Azure budget alert
- CSV files showing server, network, and domain plan
- Architecture decision document
- Cost-control document
- Subscription/license document

Batch 2 validation evidence:

- Screenshot of resource group
- Screenshot of VNet address space and subnets
- Screenshot of NSG list
- Screenshot of NSG subnet associations
- Azure CLI output showing VNet/subnet configuration
- Azure CLI output showing subnet-to-NSG associations

  Batch 3 validation evidence:

- Screenshot of VM list
- Screenshot of DC01 static private IP
- Screenshot of DC02 static private IP
- Screenshot of MGMT01 static private IP
- Screenshot of MGMT01 temporary RDP rule if used
- Azure CLI output showing VM names, private IPs, public IPs, power state, and VM sizes
- Test-NetConnection output from MGMT01 to DC01 and DC02

## Key Takeaways

This batch shows that a strong hybrid Windows Server project starts with architecture, cost control, and risk decisions before deployment. The design avoids unnecessary servers, separates internal and external DNS, and prepares the company for future Microsoft 365, Entra ID, Azure Files, Application Proxy, and Intune integration.
