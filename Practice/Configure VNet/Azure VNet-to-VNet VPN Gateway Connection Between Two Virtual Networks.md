# Azure VNet-to-VNet VPN Gateway Connection Between Two Virtual Networks

## Introduction

Azure Virtual Network gateways allow secure communication between Azure virtual networks by creating encrypted connections over Azure-managed networking components. A **VNet-to-VNet VPN connection** is commonly used when separate virtual networks need private connectivity across regions, subscriptions, or segmented environments.

In this lab, two virtual network gateways were created in different regions: one in **East US** and one in **West US**. Each gateway was deployed with **active-active mode**, **VPN type Route-based**, **VPNGw2AZ SKU**, and **Generation 2**. After both gateways were provisioned, a bidirectional **VNet-to-VNet** connection was configured using a shared pre-shared key. The final step validated that the gateways reached a **Connected** state and that traffic counters began showing **Data in** and **Data out**.

This lab demonstrates how Azure can establish secure site-style connectivity between two separate virtual networks without exposing workloads directly to the public internet.

## Objectives

The objectives of this lab were to:

- Create a VPN gateway in the East US resource group
- Create a second VPN gateway in the West US resource group
- Create two virtual networks with dedicated gateway subnets
- Configure Standard public IP resources for each gateway
- Enable active-active gateway mode
- Create a bidirectional VNet-to-VNet connection
- Configure a shared key for secure tunnel establishment
- Verify the VPN connection state and data flow

## Architecture Diagram

```text
                +---------------------------------------------+
                |             Azure Subscription              |
                +---------------------+-----------------------+
                                      |
          +---------------------------+---------------------------+
          |                                                           |
+---------+---------+                                       +---------+---------+
| Resource Group    |                                       | Resource Group    |
| rg_eastus_xxxxx   |                                       | rg_westus_xxxxx   |
+---------+---------+                                       +---------+---------+
          |                                                           |
+---------+---------+                                       +---------+---------+
| Virtual Network   |                                       | Virtual Network   |
| demoVNet1         |                                       | demoVNet2         |
| 10.1.0.0/16       |                                       | 10.41.0.0/16      |
+---------+---------+                                       +---------+---------+
          |                                                           |
| GatewaySubnet     |                                       | GatewaySubnet     |
| 10.1.255.0/27     |                                       | 10.41.255.0/27    |
          |                                                           |
+---------+---------+                                       +---------+---------+
| VPN Gateway       |=======================================| VPN Gateway       |
| DemoNet1GW        |       VNet-to-VNet VPN Tunnel         | DemoVNet2GW       |
| VPNGw2AZ / Gen2   |        Shared Key: WKey               | VPNGw2AZ / Gen2   |
| Active-Active     |                                       | Active-Active     |
+----+---------+----+                                       +----+---------+----+
     |         |                                                 |         |
     |         |                                                 |         |
 DemoNet1GWPIP DemoNet1GWPIP2                           DemoVNet2GWPIP DemoVNet2GWPIP2
 Standard PIP   Standard PIP                             Standard PIP   Standard PIP
```

This architecture shows two regional virtual networks connected through active-active Azure VPN gateways, using gateway subnets and public IP resources to establish a resilient VNet-to-VNet encrypted tunnel.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser session is recommended to avoid Azure portal cache issues.

---

### Step 2 — Create the East US VPN Gateway

Navigate to:

```text
Virtual network gateways → Create
```

Configure the first gateway with the following settings:

| Setting | Value |
|---|---|
| Name | DemoNet1GW |
| Region | East US |
| Gateway Type | VPN |
| VPN Type | Route-based |
| SKU | VpnGw2AZ |
| Generation | Generation 2 |
| Virtual Network | demoVNet1 |
| Virtual Network Address Space | 10.1.0.0/16 |
| Subnet Name | GatewaySubnet |
| Gateway Subnet Range | 10.1.255.0/27 |
| Public IP Address 1 | DemoNet1GWPIP |
| Public IP Address 2 | DemoNet1GWPIP2 |
| Active-Active Mode | Enabled |
| Configure BGP | Disabled |

Review and create the gateway.

After deployment completes, open the resource and verify that both public IP addresses are associated with the gateway.

—
<img width="1483" height="1622" alt="image" src="https://github.com/user-attachments/assets/2ba7e897-91c5-435f-923a-751fd8c1e659" />


### Step 3 — Create the West US VPN Gateway

Create the second gateway with these values:

| Setting | Value |
|---|---|
| Name | DemoVNet2GW |
| Region | West US |
| Gateway Type | VPN |
| VPN Type | Route-based |
| SKU | VpnGw2AZ |
| Generation | Generation 2 |
| Virtual Network | demoVNet2 |
| Virtual Network Address Space | 10.41.0.0/16 |
| Subnet Name | GatewaySubnet |
| Gateway Subnet Range | 10.41.255.0/27 |
| Public IP Address 1 | DemoVNet2GWPIP |
| Public IP Address 2 | DemoVNet2GWPIP2 |
| Active-Active Mode | Enabled |
| Configure BGP | Disabled |

Review and create the gateway.

After deployment completes, open the resource and verify the assigned public IP addresses.

—
<img width="1392" height="1548" alt="image" src="https://github.com/user-attachments/assets/77f560be-427e-47ff-bf6b-474efcfccd1a" />


### Step 4 — Configure the VNet-to-VNet Gateway Connection

Open the first virtual network gateway:

```text
DemoNet1GW → Connections → + Add
```

Configure the connection:

| Setting | Value |
|---|---|
| Resource Group | rg_eastus_xxxxx |
| Connection Type | VNet-to-VNet |
| Establish Bidirectional Connectivity | Enabled |
| First Connection Name | DemoVNet1-DemoVNet2 |
| Second Connection Name | DemoVNet2-DemoVNet1 |
| Region | East US |
| First Virtual Network Gateway | DemoNet1GW |
| Second Virtual Network Gateway | DemoVNet2GW |
| Shared Key (PSK) | WKey |

Review and create the connection.

This action builds both directions of the connection so that each gateway recognizes the other as its peer.

—


### Step 5 — Verify the Gateway Connections

After the connection is created, open:

```text
DemoNet1GW → Connections
```

Refresh the connection status periodically.

Expected result:

- Status changes to `Connected`

Open one of the connections and verify:

- `Connected` status
- `Data in` value
- `Data out` value

This confirms that the VNet-to-VNet tunnel is established and traffic is flowing.

### Azure CLI (Bash)

Create the East US virtual network:

```bash
az network vnet create \
  --resource-group rg_eastus_XXXXX \
  --name demoVNet1 \
  --location eastus \
  --address-prefix 10.1.0.0/16 \
  --subnet-name GatewaySubnet \
  --subnet-prefix 10.1.255.0/27
```

Create the East US public IPs:

```bash
az network public-ip create \
  --resource-group rg_eastus_XXXXX \
  --name DemoNet1GWPIP \
  --location eastus \
  --sku Standard
```

```bash
az network public-ip create \
  --resource-group rg_eastus_XXXXX \
  --name DemoNet1GWPIP2 \
  --location eastus \
  --sku Standard
```

Create the East US VPN gateway:

```bash
az network vnet-gateway create \
  --resource-group rg_eastus_XXXXX \
  --name DemoNet1GW \
  --public-ip-addresses DemoNet1GWPIP DemoNet1GWPIP2 \
  --vnet demoVNet1 \
  --gateway-type Vpn \
  --vpn-type RouteBased \
  --sku VpnGw2AZ \
  --active-active true
```

Create the West US virtual network:

```bash
az network vnet create \
  --resource-group rg_westus_XXXXX \
  --name demoVNet2 \
  --location westus \
  --address-prefix 10.41.0.0/16 \
  --subnet-name GatewaySubnet \
  --subnet-prefix 10.41.255.0/27
```

Create the West US public IPs:

```bash
az network public-ip create \
  --resource-group rg_westus_XXXXX \
  --name DemoVNet2GWPIP \
  --location westus \
  --sku Standard
```

```bash
az network public-ip create \
  --resource-group rg_westus_XXXXX \
  --name DemoVNet2GWPIP2 \
  --location westus \
  --sku Standard
```

Create the West US VPN gateway:

```bash
az network vnet-gateway create \
  --resource-group rg_westus_XXXXX \
  --name DemoVNet2GW \
  --public-ip-addresses DemoVNet2GWPIP DemoVNet2GWPIP2 \
  --vnet demoVNet2 \
  --gateway-type Vpn \
  --vpn-type RouteBased \
  --sku VpnGw2AZ \
  --active-active true
```

Create the VNet-to-VNet connection:

```bash
az network vpn-connection create \
  --resource-group rg_eastus_XXXXX \
  --name DemoVNet1-DemoVNet2 \
  --vnet-gateway1 DemoNet1GW \
  --vnet-gateway2 DemoVNet2GW \
  --shared-key WKey
```

Show connection status:

```bash
az network vpn-connection show \
  --resource-group rg_eastus_XXXXX \
  --name DemoVNet1-DemoVNet2 \
  --query "{Status:connectionStatus,DataIn:ingressBytesTransferred,DataOut:egressBytesTransferred}"
```

### Azure PowerShell

Create the East US subnet and virtual network:

```powershell
$eastSubnet = New-AzVirtualNetworkSubnetConfig `
  -Name "GatewaySubnet" `
  -AddressPrefix "10.1.255.0/27"

New-AzVirtualNetwork `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "demoVNet1" `
  -Location "East US" `
  -AddressPrefix "10.1.0.0/16" `
  -Subnet $eastSubnet
```

Create the East US public IPs:

```powershell
$eastPip1 = New-AzPublicIpAddress `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "DemoNet1GWPIP" `
  -Location "East US" `
  -AllocationMethod Dynamic `
  -Sku Standard

$eastPip2 = New-AzPublicIpAddress `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "DemoNet1GWPIP2" `
  -Location "East US" `
  -AllocationMethod Dynamic `
  -Sku Standard
```

Create the East US VPN gateway:

```powershell
$eastVnet = Get-AzVirtualNetwork -ResourceGroupName "rg_eastus_XXXXX" -Name "demoVNet1"
$eastGatewaySubnet = Get-AzVirtualNetworkSubnetConfig -Name "GatewaySubnet" -VirtualNetwork $eastVnet

$eastIpConfig1 = New-AzVirtualNetworkGatewayIpConfig `
  -Name "gwipconfig1" `
  -SubnetId $eastGatewaySubnet.Id `
  -PublicIpAddressId $eastPip1.Id

$eastIpConfig2 = New-AzVirtualNetworkGatewayIpConfig `
  -Name "gwipconfig2" `
  -SubnetId $eastGatewaySubnet.Id `
  -PublicIpAddressId $eastPip2.Id

New-AzVirtualNetworkGateway `
  -Name "DemoNet1GW" `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Location "East US" `
  -IpConfigurations $eastIpConfig1, $eastIpConfig2 `
  -GatewayType Vpn `
  -VpnType RouteBased `
  -GatewaySku VpnGw2AZ `
  -EnableActiveActiveFeature
```

Create the West US subnet and virtual network:

```powershell
$westSubnet = New-AzVirtualNetworkSubnetConfig `
  -Name "GatewaySubnet" `
  -AddressPrefix "10.41.255.0/27"

New-AzVirtualNetwork `
  -ResourceGroupName "rg_westus_XXXXX" `
  -Name "demoVNet2" `
  -Location "West US" `
  -AddressPrefix "10.41.0.0/16" `
  -Subnet $westSubnet
```

Create the West US public IPs and gateway similarly, then create the connection:

```powershell
New-AzVirtualNetworkGatewayConnection `
  -Name "DemoVNet1-DemoVNet2" `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -VirtualNetworkGateway1 (Get-AzVirtualNetworkGateway -Name "DemoNet1GW" -ResourceGroupName "rg_eastus_XXXXX") `
  -VirtualNetworkGateway2 (Get-AzVirtualNetworkGateway -Name "DemoVNet2GW" -ResourceGroupName "rg_westus_XXXXX") `
  -Location "East US" `
  -ConnectionType Vnet2Vnet `
  -SharedKey "WKey"
```

Check connection status:

```powershell
Get-AzVirtualNetworkGatewayConnection `
  -Name "DemoVNet1-DemoVNet2" `
  -ResourceGroupName "rg_eastus_XXXXX"
```

## Implementation Walkthrough

The lab began by creating the first virtual network gateway in **East US**. During this deployment, a new virtual network named `demoVNet1` was created with the address space `10.1.0.0/16`, and a dedicated `GatewaySubnet` using `10.1.255.0/27` was defined. The gateway `DemoNet1GW` was configured as a **VPN** gateway with the **Route-based** type, **VpnGw2AZ** SKU, **Generation 2**, and **active-active mode enabled** using two Standard public IP addresses. :contentReference[oaicite:1]{index=1}

The second phase repeated the same pattern in **West US**, where `demoVNet2` was created with the address space `10.41.0.0/16` and a `GatewaySubnet` using `10.41.255.0/27`. The second gateway, `DemoVNet2GW`, was deployed with the same high-availability gateway model: **Route-based VPN**, **VpnGw2AZ**, **Generation 2**, and **active-active mode** with two public IP resources. This established the two regional endpoints that would form the tunnel. :contentReference[oaicite:2]{index=2}

Once both gateways were fully provisioned, a **VNet-to-VNet** connection was created from `DemoNet1GW`. The connection configuration enabled **bidirectional connectivity**, automatically creating both `DemoVNet1-DemoVNet2` and `DemoVNet2-DemoVNet1`. A shared key of `WKey` was configured on the connection. After waiting for the tunnel to establish, the **Connections** blade showed the status as **Connected**, and the detail view displayed **Data in** and **Data out**, confirming that the gateways were exchanging traffic successfully. :contentReference[oaicite:3]{index=3}

## Results & Validation

| Test | Result |
|---|---|
| East US virtual network creation | Successful |
| East US VPN gateway creation | Successful |
| West US virtual network creation | Successful |
| West US VPN gateway creation | Successful |
| Active-active gateway configuration | Successful |
| Bidirectional VNet-to-VNet connection creation | Successful |
| Shared key configuration | Successful |
| Connection status verification | Successful |
| Data in / Data out visibility | Successful |

Key observations:

- Azure can connect two virtual networks securely across regions using VNet-to-VNet VPN gateways
- Active-active mode increases resiliency by using two gateway public IPs per gateway
- Route-based gateways support dynamic routing scenarios and modern Azure VPN patterns
- The shared key is required to establish the VPN tunnel trust relationship
- Connection health can be confirmed through `Connected` state and data transfer counters

## Validation Walkthrough

1. Verified that `DemoNet1GW` was created in the East US resource group.
2. Confirmed that `demoVNet1` used the address space `10.1.0.0/16`.
3. Confirmed that `GatewaySubnet` in `demoVNet1` used `10.1.255.0/27`.
4. Verified that both `DemoNet1GWPIP` and `DemoNet1GWPIP2` were associated with the East US gateway.
5. Verified that `DemoVNet2GW` was created in the West US resource group.
6. Confirmed that `demoVNet2` used the address space `10.41.0.0/16`.
7. Confirmed that `GatewaySubnet` in `demoVNet2` used `10.41.255.0/27`.
8. Verified that both `DemoVNet2GWPIP` and `DemoVNet2GWPIP2` were associated with the West US gateway.
9. Created the bidirectional VNet-to-VNet connection using the shared key `WKey`.
10. Opened the **Connections** blade for `DemoNet1GW`.
11. Refreshed until the connection status changed to `Connected`.
12. Opened the connection details and confirmed that **Data in** and **Data out** values were present.

## Real-World Use Case

VNet-to-VNet gateway connections are commonly used when organizations need private connectivity between separate Azure network environments.

Example: **Regional Network Segmentation with Secure Connectivity**

| Component | Role |
|---|---|
| East US virtual network | Primary application region |
| West US virtual network | Secondary or disaster recovery region |
| VPN gateways | Secure network endpoints |
| Shared key | Tunnel authentication |
| VNet-to-VNet connection | Private inter-network communication |

Typical workflow:

```text
Application in East US Needs Private Access
                ↓
Traffic Enters DemoNet1GW
                ↓
Encrypted VPN Tunnel Traverses Azure Gateway Path
                ↓
Traffic Reaches DemoVNet2GW
                ↓
West US Network Receives Private Connectivity
```

This pattern is useful for regional failover designs, segmented application tiers, cross-region private access, disaster recovery planning, and secure network integration between separate Azure environments.

## Key Takeaways

This lab demonstrated several important Azure networking concepts:

- Azure Virtual Network Gateways enable secure private connectivity between virtual networks
- VNet-to-VNet VPN connections can connect Azure networks across regions
- Route-based VPN gateways are commonly used for Azure VPN designs
- Active-active mode improves gateway resiliency by using multiple public IPs
- Shared keys are used to establish VPN trust between gateway peers
- Connection status and traffic counters provide operational verification of tunnel health

Understanding Azure VNet-to-VNet VPN gateway design is valuable for cloud administrators, network engineers, and infrastructure teams responsible for secure cross-network connectivity in Azure.

