# Azure Virtual Network Deployment and VM-to-VM Connectivity Validation

## Introduction

In this project, I deployed an Azure Virtual Network (VNet) with a custom subnet and provisioned two Windows Server virtual machines within the same network. I configured ICMP rules to allow internal communication and validated connectivity by performing VM-to-VM ping tests.

This implementation demonstrates Azure networking fundamentals, subnet configuration, VM deployment, network security configuration, and internal connectivity validation.

The project aligns with AZ-104 objectives related to virtual networking and compute resource management.

---

## Objectives

- Create an Azure Virtual Network (VNet)
- Configure a custom subnet
- Deploy two Virtual Machines within the same VNet
- Configure inbound ICMP rules
- Validate private network communication
- Understand NSG and Windows Firewall interactions

---

## Full Implementation

### Virtual Network Creation

#### Option 1 – Azure CLI (Bash)

```bash
az network vnet create \
  --resource-group <resource-group-name> \
  --name vnet1 \
  --address-prefix 10.0.0.0/16 \
  --subnet-name default2 \
  --subnet-prefix 10.0.1.0/24 \
  --location eastus
``` 
Option 2 – Azure PowerShell (Az Module)
```powershell
New-AzVirtualNetwork `
 -Name "vnet1" `
 -ResourceGroupName "<resource-group-name>" `
 -Location "East US" `
 -AddressPrefix "10.0.0.0/16"

Add-AzVirtualNetworkSubnetConfig `
 -Name "default2" `
 -VirtualNetwork (Get-AzVirtualNetwork -Name "vnet1" -ResourceGroupName "<resource-group-name>") `
 -AddressPrefix "10.0.1.0/24"

Set-AzVirtualNetwork `
 -VirtualNetwork (Get-AzVirtualNetwork -Name "vnet1" -ResourceGroupName "<resource-group-name>")
``` 

### Virtual Machine Deployment (vm1 and vm2)
#### Option 1 – Azure CLI (Bash)
```bash
az vm create \
 --resource-group <resource-group-name> \
 --name vm1 \
 --vnet-name vnet1 \
 --subnet default2 \
 --image Win2025Datacenter \
 --size Standard_B2s \
 --admin-username <username> \
 --admin-password <password> \
 --public-ip-sku Standard \
 --location eastus

az vm create \
 --resource-group <resource-group-name> \
 --name vm2 \
 --vnet-name vnet1 \
 --subnet default2 \
 --image Win2025Datacenter \
 --size Standard_B2s \
 --admin-username <username> \
 --admin-password <password> \
 --public-ip-sku Standard \
 --location eastus

```
#### Option 2 – Azure PowerShell (Az Module)
```powershell
New-AzVM `
 -ResourceGroupName "<resource-group-name>" `
 -Name "vm1" `
 -Location "East US" `
 -VirtualNetworkName "vnet1" `
 -SubnetName "default2" `
 -ImageName "Win2025Datacenter" `
 -Size "Standard_B2s" `
 -Credential (Get-Credential)

New-AzVM `
 -ResourceGroupName "<resource-group-name>" `
 -Name "vm2" `
 -Location "East US" `
 -VirtualNetworkName "vnet1" `
 -SubnetName "default2" `
 -ImageName "Win2025Datacenter" `
 -Size "Standard_B2s" `
 -Credential (Get-Credential)
``` 
Configuration Highlights:
- VNet: vnet1


- Address Space: 10.0.0.0/16


- Subnet: default2 (10.0.1.0/24)


- VM Size: B2s


- OS Disk: Standard SSD


- Region: East US



### ICMP Rule Configuration
To enable VM-to-VM ping communication:
#### Azure CLI (NSG Rule)
```bash
az network nsg rule create \
 --resource-group <resource-group-name> \
 --nsg-name <nsg-name> \
 --name Allow-ICMP \
 --protocol Icmp \
 --priority 1000 \
 --direction Inbound \
 --access Allow
``` 
#### Azure PowerShell
```powershell
Add-AzNetworkSecurityRuleConfig `
 -Name "Allow-ICMP" `
 -NetworkSecurityGroup (Get-AzNetworkSecurityGroup -Name "<nsg-name>" -ResourceGroupName "<resource-group-name>") `
 -Protocol Icmp `
 -Direction Inbound `
 -Priority 1000 `
 -Access Allow `
 -SourceAddressPrefix * `
 -SourcePortRange * `
 -DestinationAddressPrefix * `
 -DestinationPortRange *
``` 
Additionally, ICMP inbound rules were enabled within Windows Defender Firewall on vm2.

##  Implementation Walkthrough
### Step 1 – Virtual Network Deployment
- Created VNet with 10.0.0.0/16 address space.


- Created subnet default2 (10.0.1.0/24).


- Verified successful provisioning.

<img width="1392" height="1594" alt="image" src="https://github.com/user-attachments/assets/b1ca7831-02cc-4923-b183-256be9a70009" />


#### Architecture Insight:
 A VNet provides isolated, secure networking for Azure resources.

### Step 2 – VM Deployment
- Deployed vm1 and vm2 into same subnet.


- Configured Standard SSD OS disks.


- Assigned public IPs for RDP access.


- Verified provisioning success.
<img width="1514" height="1333" alt="image" src="https://github.com/user-attachments/assets/224d6dac-1a27-44ef-b0e5-1ab38ccbcdad" />
<img width="1523" height="1303" alt="image" src="https://github.com/user-attachments/assets/a846383c-43ab-4a33-8673-e7ccd8006ad5" />


#### Operational Insight:
 Placing both VMs in same subnet allows private IP communication.

### Step 3 – ICMP Configuration
- Created inbound ICMP rule in NSG.


- Enabled ICMP rule in Windows Firewall.


- Verified rule activation.


This demonstrates layered security:
- Azure NSG


- Guest OS Firewall

<img width="1523" height="913" alt="image" src="https://github.com/user-attachments/assets/ab8accb8-6b52-444b-ab30-4c174e2b3b28" />
<img width="1523" height="194" alt="image" src="https://github.com/user-attachments/assets/df881cd5-bb5e-4844-9108-d79f479d47a5" />





### Step 4 – Connectivity Validation
- Connected to vm1 via RDP.


- Opened PowerShell (Administrator).


- Executed:


ping vm2
Ping successful.
This confirms:
- Proper subnet configuration


- Functional NSG rule


- Firewall configuration


- Internal VNet routing
<img width="1523" height="395" alt="image" src="https://github.com/user-attachments/assets/944f5572-3a2a-45a6-9c56-837ea1177484" />




##  Results & Validation
- Virtual Network successfully created.


- Subnet configured correctly.


- Two VMs deployed within same subnet.


- ICMP rule applied successfully.


- Firewall rule enabled.


- vm1 successfully pinged vm2.


- Private network communication validated.


All objectives achieved.

##  Validation Walkthrough
- Verified VNet address space.


- Confirmed subnet configuration.


- Confirmed both VMs assigned private IPs within subnet.


- Verified NSG rule creation.


- Enabled Windows firewall ICMP rule.


- Performed ping test from vm1 to vm2.


- Confirmed successful ICMP response.


Connectivity fully validated.

##  Key Takeaways
- Azure VNets provide secure network isolation.


- Subnetting improves traffic segmentation.


- NSG rules control traffic at network layer.


- Windows Firewall adds OS-level protection.


- Successful ICMP validation confirms internal routing functionality.


- Layered security model is essential in Azure networking.


This project strengthens Azure Administrator skills in networking, security configuration, and VM connectivity validation.

