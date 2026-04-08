# Azure Virtual Network Peering and Cross-VNet VM Communication

## Introduction

In this project, I implemented Azure Virtual Network (VNet) peering between two isolated virtual networks and validated communication between virtual machines deployed in each network.

Azure Virtual Network peering enables direct, private connectivity between two VNets without requiring gateways or public internet routing. This allows resources in different VNets to communicate with low latency and high bandwidth.

This lab demonstrates how Azure administrators can build scalable network architectures and establish secure cross-network communication.

---

## Objectives

- Create two Azure Virtual Networks
- Configure custom subnets
- Establish VNet Peering
- Deploy Virtual Machines in separate VNets
- Enable ICMP communication between VMs
- Validate cross-network connectivity

---

# Full Implementation

## Create Virtual Networks

### Azure CLI (Bash)

```bash
az network vnet create \
--resource-group <resource-group-name> \
--name demoVNet1 \
--address-prefix 10.1.0.0/16 \
--subnet-name SubnetA \
--subnet-prefix 10.1.0.0/24 \
--location westeurope

az network vnet create \
--resource-group <resource-group-name> \
--name demoVNet2 \
--address-prefix 10.2.0.0/16 \
--subnet-name SubnetB \
--subnet-prefix 10.2.0.0/24 \
--location westeurope

Azure PowerShell
New-AzVirtualNetwork `
-Name "demoVNet1" `
-ResourceGroupName "<resource-group-name>" `
-Location "West Europe" `
-AddressPrefix "10.1.0.0/16"

Add-AzVirtualNetworkSubnetConfig `
-Name "SubnetA" `
-VirtualNetwork (Get-AzVirtualNetwork -Name "demoVNet1" -ResourceGroupName "<resource-group-name>") `
-AddressPrefix "10.1.0.0/24"

New-AzVirtualNetwork `
-Name "demoVNet2" `
-ResourceGroupName "<resource-group-name>" `
-Location "West Europe" `
-AddressPrefix "10.2.0.0/16"

Add-AzVirtualNetworkSubnetConfig `
-Name "SubnetB" `
-VirtualNetwork (Get-AzVirtualNetwork -Name "demoVNet2" -ResourceGroupName "<resource-group-name>") `
-AddressPrefix "10.2.0.0/24"
``` 
##  Configure VNet Peering
### Azure CLI (Bash)
```bash
az network vnet peering create \
--resource-group <resource-group-name> \
--name demoVNet1-demoVNet2 \
--vnet-name demoVNet1 \
--remote-vnet demoVNet2 \
--allow-vnet-access

az network vnet peering create \
--resource-group <resource-group-name> \
--name demoVNet2-demoVNet1 \
--vnet-name demoVNet2 \
--remote-vnet demoVNet1 \
--allow-vnet-access
``` 
### Azure PowerShell
```powershell
Add-AzVirtualNetworkPeering `
-Name "demoVNet1-demoVNet2" `
-VirtualNetwork (Get-AzVirtualNetwork -Name "demoVNet1" -ResourceGroupName "<resource-group-name>") `
-RemoteVirtualNetworkId (Get-AzVirtualNetwork -Name "demoVNet2" -ResourceGroupName "<resource-group-name>").Id

Add-AzVirtualNetworkPeering `
-Name "demoVNet2-demoVNet1" `
-VirtualNetwork (Get-AzVirtualNetwork -Name "demoVNet2" -ResourceGroupName "<resource-group-name>") `
-RemoteVirtualNetworkId (Get-AzVirtualNetwork -Name "demoVNet1" -ResourceGroupName "<resource-group-name>").Id
``` 


##  Deploy Virtual Machines
### Azure CLI (Bash)
```bash
az vm create \
--resource-group <resource-group-name> \
--name demoVM1 \
--vnet-name demoVNet1 \
--subnet SubnetA \
--image Win2025Datacenter \
--size Standard_B2s \
--admin-username vm1 \
--admin-password <password>

az vm create \
--resource-group <resource-group-name> \
--name demoVM2 \
--vnet-name demoVNet2 \
--subnet SubnetB \
--image Win2025Datacenter \
--size Standard_B2s \
--admin-username vm2 \
--admin-password <password>
``` 
### Azure PowerShell
```powershell
New-AzVM `
-ResourceGroupName "<resource-group-name>" `
-Name "demoVM1" `
-Location "West Europe" `
-VirtualNetworkName "demoVNet1" `
-SubnetName "SubnetA" `
-ImageName "Win2025Datacenter" `
-Size "Standard_B2s" `
-Credential (Get-Credential)

New-AzVM `
-ResourceGroupName "<resource-group-name>" `
-Name "demoVM2" `
-Location "West Europe" `
-VirtualNetworkName "demoVNet2" `
-SubnetName "SubnetB" `
-ImageName "Win2025Datacenter" `
-Size "Standard_B2s" `
-Credential (Get-Credential)
``` 

##  Implementation Walkthrough
### Step 1 — Create Virtual Networks
Two isolated virtual networks were created:
| VNet     | Address Space | Subnet  |
| -------- | ------------- | ------- |
| demoVNet1 | 10.1.0.0/24   | SubnetA |
| demoVNet2 | 10.2.0.0/24   | SubnetB |


Each VNet operates independently until peering is configured.
<img width="1423" height="1414" alt="image" src="https://github.com/user-attachments/assets/3da177a9-c427-4008-9c89-284bca2f71a9" />
<img width="1411" height="1538" alt="image" src="https://github.com/user-attachments/assets/22a01734-3dc6-489e-879b-842c0591eb22" />



### Step 2 — Configure VNet Peering
VNet peering establishes direct connectivity between networks.
Once configured:
- Traffic flows through Azure backbone


- No gateway required


- Low latency communication


Peering status becomes Connected once successfully configured.
<img width="1523" height="1375" alt="image" src="https://github.com/user-attachments/assets/ff0e0874-e03e-4df3-beb9-b419d9e3e85b" />


### Step 3 — Deploy Virtual Machines
Two Windows Server VMs were deployed:
| VM            | Network  | Subnet  |
| ------------- | -------- | ------- |
| demoVM1 | demoVNet1 | SubnetA |
| demoVM2 | demoVNet2 | SubnetB |


These VMs represent workloads in separate network segments.

<img width="1523" height="1506" alt="image" src="https://github.com/user-attachments/assets/ce7abfda-30ad-4e66-a2ab-d6a0898560e8" />
<img width="1488" height="1675" alt="image" src="https://github.com/user-attachments/assets/68c7ac17-d6e6-4d4d-bebe-ad1453479b69" />


### Step 4 — Enable ICMP Communication
Windows firewall blocks ICMP by default.
Rule created using PowerShell:
New-NetFirewallRule -DisplayName "Allow ICMPv4-In" -Protocol ICMPv4
This allows ping-based connectivity testing.

### Step 5 — Test Cross-VNet Connectivity
From VM1, a remote desktop connection was initiated to VM2 using the private IP address.
Example:
mstsc /v:10.2.0.4
This demonstrates successful routing across peered VNets.

##  Results & Validation
The following results confirm successful deployment:
Two Virtual Networks created


Address spaces configured


VNet peering established


Two virtual machines deployed


Firewall rule enabled


Cross-VNet communication established


Remote connection from VM1 to VM2 successful


All network routing and peering functions operated correctly.

##  Validation Walkthrough
- Verified both VNets were created successfully.


- Confirmed subnet configuration.


- Validated peering status = Connected.


- Deployed VM1 and VM2 in separate VNets.


- Enabled ICMP rule in Windows Firewall.


- Retrieved private IP address of VM2.


- Initiated remote connection from VM1 using private IP.


- Successfully logged into VM2.


Cross-network communication validated successfully.

##  Key Takeaways
- Azure Virtual Networks provide isolated networking environments.


- VNet Peering allows seamless communication between networks.


- Peering traffic uses the Azure backbone network.


- Cross-VNet communication does not require VPN gateways.


- Firewall rules must allow required protocols for connectivity testing.


- VNet peering is commonly used in hub-and-spoke architectures.


This project strengthens Azure networking skills in VNet architecture, secure connectivity, and cloud infrastructure design.

