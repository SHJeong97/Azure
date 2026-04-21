# Azure Resource Plan

## Goal
Provide low-cost Azure-hosted infrastructure for a hybrid identity portfolio lab.

## Resource Group
rg-hybrid-identity-lab

## Region
Choose one region close to your location and keep all resources in the same region.

## Network
- Virtual Network: vnet-hybrid-identity
- Address Space: 10.10.0.0/16
- Subnet: snet-core
- Subnet Range: 10.10.1.0/24

## NSG
nsg-hybrid-identity-management

## Virtual Machines
### ADC-01
Purpose:
- first domain controller
- DNS server
- future identity source

Private IP target:
- 10.10.1.10

### MGMT-01
Purpose:
- management server
- future Microsoft Entra Connect host
- RSAT administration

Private IP target:
- 10.10.1.20

## Cost Control
- keep VM count to two
- use small sizes
- stop VMs after use
- do not add extra services unless required

## Security Intent
- restrict inbound RDP to your own public IP if possible
- avoid broad inbound exposure
- use strong local admin credentials
