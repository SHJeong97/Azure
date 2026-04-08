# Azure VPN Gateway Deployment and Reset Operation

## Introduction

In this project, I deployed an Azure Virtual Network (VNet), configured subnets including a dedicated Gateway Subnet, and deployed an Azure VPN Gateway to enable secure network connectivity.

Azure VPN Gateway enables encrypted communication between Azure Virtual Networks and external networks such as on-premises environments or other cloud networks. It plays a critical role in hybrid cloud architecture.

After deploying the VPN Gateway, I performed a gateway reset operation to understand operational maintenance procedures for Azure network gateways.

---

## Objectives

- Create an Azure Virtual Network
- Configure multiple subnets including a Gateway Subnet
- Deploy an Azure VPN Gateway
- Understand gateway deployment architecture
- Perform gateway reset operation
- Validate gateway provisioning and configuration

---

# Full Implementation

## Create Virtual Network

### Azure CLI (Bash)

```bash
az network vnet create \
--resource-group <resource-group-name> \
--name demoVNet1 \
--address-prefix 10.1.0.0/16 \
--subnet-name FrontEnd \
--subnet-prefix 10.1.0.0/24 \
--location eastus
``` 
### Azure PowerShell
```powershell
New-AzVirtualNetwork `
-Name "demoVNet1" `
-ResourceGroupName "<resource-group-name>" `
-Location "East US" `
-AddressPrefix "10.1.0.0/16"
``` 

### Create Gateway Subnet
### Azure CLI (Bash)
```bash
az network vnet subnet create \
--resource-group <resource-group-name> \
--vnet-name demoVNet1 \
--name GatewaySubnet \
--address-prefix 10.1.255.0/27
``` 
### Azure PowerShell
```powershell
Add-AzVirtualNetworkSubnetConfig `
-Name "GatewaySubnet" `
-VirtualNetwork (Get-AzVirtualNetwork -Name "demoVNet1" -ResourceGroupName "<resource-group-name>") `
-AddressPrefix "10.1.255.0/27"

Set-AzVirtualNetwork `
-VirtualNetwork (Get-AzVirtualNetwork -Name "demoVNet1" -ResourceGroupName "<resource-group-name>")
``` 

### Create Public IP for VPN Gateway
### Azure CLI (Bash)
```bash
az network public-ip create \
--resource-group <resource-group-name> \
--name demoVGWPIP \
--sku Standard \
--allocation-method Static
``` 
### Azure PowerShell
```powershell
New-AzPublicIpAddress `
-Name "demoVGWPIP" `
-ResourceGroupName "<resource-group-name>" `
-Location "East US" `
-AllocationMethod Static `
-Sku Standard
``` 

### Deploy Azure VPN Gateway
### Azure CLI (Bash)
```bash
az network vnet-gateway create \
--resource-group <resource-group-name> \
--name WhizGateway \
--public-ip-address demoVGWPIP \
--vnet demoVNet1 \
--gateway-type Vpn \
--sku VpnGw2AZ \
--vpn-type RouteBased
``` 
### Azure PowerShell
```powershell
New-AzVirtualNetworkGateway `
-Name "WhizGateway" `
-ResourceGroupName "<resource-group-name>" `
-Location "East US" `
-IpConfigurations $ipConfig `
-GatewayType Vpn `
-VpnType RouteBased `
-GatewaySku VpnGw2AZ
``` 

### Reset VPN Gateway
Azure CLI (Bash)
```bash
az network vnet-gateway reset \
--resource-group <resource-group-name> \
--name WhizGateway
``` 
Azure PowerShell
```powershell
Reset-AzVirtualNetworkGateway `
-Name "WhizGateway" `
-ResourceGroupName "<resource-group-name>"
``` 


##  Implementation Walkthrough
### Step 1 — Create Virtual Network
A Virtual Network named demoVNet1 was created with the following configuration:
| Configuration | Value       |
| ------------- | ----------- |
| Address Space | 10.1.0.0/16 |
| Region        | East US     |
| Subnet        | FrontEnd    |



The VNet serves as the core network boundary for Azure resources.

### Step 2 — Configure Gateway Subnet
A dedicated GatewaySubnet was created.| Subnet        | Address Range |
| ------------- | ------------- |
| FrontEnd      | 10.1.0.0/24   |
| GatewaySubnet | 10.1.255.0/27 |


Azure requires a dedicated GatewaySubnet to host VPN gateway resources.


### Step 3 — Deploy VPN Gateway
The following gateway configuration was deployed:| Setting            | Value    |
| ------------------ | -------- |
| Gateway Type       | VPN      |
| SKU                | VPNGw2AZ |
| Generation         | Gen2     |
| Public IP          | Standard |
| Active-Active Mode | Disabled |
| BGP                | Disabled |




### Step 4 — Reset VPN Gateway
The gateway reset operation was performed to simulate maintenance or troubleshooting scenarios.
Gateway reset helps resolve issues such as:
- connectivity failures


- routing inconsistencies


- gateway service interruptions



##  Results & Validation
The following results confirm successful implementation:
- Virtual Network created successfully


- Gateway subnet configured correctly


- Public IP address provisioned


- VPN Gateway deployed successfully


- Gateway resource visible in Azure Portal


- Reset operation executed successfully


The infrastructure deployed and functioned as expected.

##  Validation Walkthrough
- Verified VNet creation in Azure Portal.


- Confirmed subnet and GatewaySubnet configuration.


- Verified Public IP creation.


- Confirmed VPN Gateway deployment status.


- Observed gateway Public IP address assignment.


- Executed gateway reset operation.


- Verified gateway returned to operational state.


All validation steps completed successfully.

##  Key Takeaways
- Azure VPN Gateway enables secure communication between networks.


- GatewaySubnet is required for hosting VPN gateway services.


- VPN Gateway deployment requires significant provisioning time.


- Gateway reset is a common troubleshooting operation.


- VPN gateways are critical components in hybrid cloud networking.


This project strengthens Azure networking skills related to hybrid connectivity, gateway deployment, and network infrastructure management.

