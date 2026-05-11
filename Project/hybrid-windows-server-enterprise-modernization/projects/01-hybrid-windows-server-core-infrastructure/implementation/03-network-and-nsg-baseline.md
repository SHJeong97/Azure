# Network and NSG Baseline

## Purpose

This document defines the Azure network foundation for the Summit Ridge hybrid Windows Server lab.

## Business Problem

The company needs a clean network structure before deploying domain controllers, management servers, file servers, application servers, and client endpoints.

A flat network would be simpler, but it would make troubleshooting, segmentation, access control, and future security hardening harder.

## Design

### Resource Group

rg-srmg-hybrid-core

### Virtual Network

vnet-srmg-hybrid-eastus

Address space:

10.10.0.0/16

### Subnets

| Subnet | Address Range | Purpose |
|---|---:|---|
| snet-domain-controllers | 10.10.1.0/24 | Domain controllers and internal DNS |
| snet-management | 10.10.2.0/24 | Admin tools, RSAT, Windows Admin Center |
| snet-member-servers | 10.10.3.0/24 | File servers, app servers, workload servers |
| snet-workstations | 10.10.4.0/24 | Windows client endpoint testing |

### Network Security Groups

| NSG | Associated Subnet |
|---|---|
| nsg-srmg-domain-controllers | snet-domain-controllers |
| nsg-srmg-management | snet-management |
| nsg-srmg-member-servers | snet-member-servers |
| nsg-srmg-workstations | snet-workstations |

## Security Decision

The baseline allows internal VirtualNetwork communication so that AD DS, DNS, Kerberos, LDAP, SMB, Group Policy, and management traffic can function during the foundation phase.

Internet inbound access is not broadly opened.

RDP from the internet must not be allowed from 0.0.0.0/0.

## Risk

If subnet and NSG design is too restrictive too early, AD DS promotion, domain join, DNS, Group Policy, and management validation can fail.

If subnet and NSG design is too open long term, the environment has weak segmentation and higher lateral movement risk.

## Risk Treatment

Use a permissive internal baseline during the foundation build, then progressively harden access in later security projects.

## Business Value

The subnet design creates a clean operating model for a 250-user company. It separates identity infrastructure, management systems, workload servers, and endpoints while keeping the lab simple enough to operate under a $100 budget.
