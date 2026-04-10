# Azure Load Balancer Deployment with NAT Gateway and IIS Backend Servers

## Introduction

Azure Load Balancer is a Layer 4 load balancing service that distributes inbound traffic across multiple backend resources such as virtual machines. It improves availability, scalability, and resiliency by ensuring that client requests can be served by more than one backend system.

In this lab, a virtual network and subnet were created first, followed by a NAT Gateway for outbound connectivity. An Azure Load Balancer was then configured to distribute HTTP traffic across three Windows virtual machines. IIS was installed on each VM, and the default web page was customized to show the server name so that backend distribution could be verified through the load balancer public IP.

This lab demonstrates a practical Azure networking design that combines **inbound load distribution** with **controlled outbound internet access**. 

---

## Objectives

The objectives of this lab were to:

- Create an Azure Virtual Network and subnet
- Deploy a NAT Gateway with a public IP
- Configure an Azure Load Balancer
- Create multiple Windows virtual machines as backend servers
- Associate the virtual machines with the load balancer backend pool
- Install IIS on each virtual machine
- Test HTTP traffic distribution through the load balancer public IP

---

## Architecture Diagram

```text
                 +----------------------+
                 |   Azure Subscription |
                 +----------+-----------+
                            |
                 +----------+-----------+
                 |       Resource Group |
                 |   rg_westeurope_xxx  |
                 +----------+-----------+
                            |
                  +---------+----------+
                  |   Virtual Network  |
                  |     demoVNet1      |
                  |    10.1.0.0/16     |
                  +---------+----------+
                            |
                     +------+------+
                     |   Subnet    |
                     | demoVNet... |
                     | 10.1.0.0/24 |
                     +------+------+
                            |
        +-------------------+-------------------+
        |                   |                   |
 +------+------+      +-----+-----+       +-----+-----+
 |  demoVM1   |      |  demoVM2   |       |  demoVM3   |
 | IIS Server |      | IIS Server |       | IIS Server |
 +------+------+      +-----+-----+       +-----+-----+
        \                   |                   /
         \                  |                  /
          +-----------------+-----------------+
                            |
                   +--------+--------+
                   | Azure Load      |
                   | Balancer        |
                   | demoLoadBal...  |
                   +--------+--------+
                            |
                       Public IP
                            |
                        HTTP Users

                   +------------------+
                   |   NAT Gateway    |
                   |    DemoNATGW1    |
                   +--------+---------+
                            |
                       Public IP
                       demoNATIP1
```

This architecture shows how Azure Load Balancer handles inbound HTTP traffic to multiple IIS servers while the NAT Gateway provides outbound internet connectivity for resources in the subnet.

---

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser session is recommended to avoid cached Azure account issues.

---

### Step 2 — Create a Virtual Network

Navigate to:

```text
Virtual Networks → Create
```

Configure the virtual network:

| Setting | Value |
|---|---|
| Resource Group | rg_westeurope_XXXXX |
| Name | demoVNet1 |
| Region | West Europe |
| Address Space | 10.1.0.0/16 |

Edit the default subnet with the following values:

| Setting | Value |
|---|---|
| Name | demoVNetSubnet1 |
| Starting Address | 10.1.0.0 |
| Subnet Size | /24 |
| Subnet Purpose | Default |

Create the virtual network. 

—
<img width="1523" height="1356" alt="image" src="https://github.com/user-attachments/assets/fd360a4a-fd58-4c65-a3cd-3ce7bf1a6326" />


### Step 3 — Create NAT Gateway

Navigate to:

```text
NAT Gateways → Create
```

Configure the NAT Gateway:

| Setting | Value |
|---|---|
| Resource Group | rg_westeurope_XXXXX |
| NAT Gateway Name | DemoNATGW1 |
| Availability Zone | None |
| TCP Idle Timeout | 15 minutes |

Create a new public IP:

| Setting | Value |
|---|---|
| Public IP Name | demoNATIP1 |

Associate the NAT Gateway with:

| Setting | Value |
|---|---|
| Virtual Network | demoVNet1 |
| Subnet | demoVNetSubnet1 |

Deploy the NAT Gateway. 

—
<img width="1523" height="1711" alt="image" src="https://github.com/user-attachments/assets/fd9cfb42-7c5b-40d3-aa4b-7f5e89fc231c" />


### Step 4 — Create Azure Load Balancer

Create a public Azure Load Balancer and configure:

- Frontend public IP
- Backend pool
- Health probe
- Load-balancing rule for HTTP
- Floating IP disabled
- TCP reset enabled

The lab used an Azure Load Balancer named similar to:

```text
demoLoadBalancer1
```

and backend pool:

```text
demoBackendPool1
```

This load balancer was later attached to the three virtual machines during deployment. 

—
<img width="1523" height="1233" alt="image" src="https://github.com/user-attachments/assets/da816de3-3a35-4d77-b7d2-188a2a76c79e" />


### Step 5 — Create Virtual Machines

Navigate to:

```text
Virtual Machines → Create
```

Create three Windows Server VMs.

Base settings for `demoVM1`:

| Setting | Value |
|---|---|
| Resource Group | rg_westeurope_XXXXX |
| Name | demoVM1 |
| Region | West Europe |
| Security Type | Standard |
| Image | Windows Server 2025 Datacenter: Azure Edition - x64 Gen2 |
| Size | B2s |
| Public Inbound Ports | RDP |

Networking settings:

| Setting | Value |
|---|---|
| Virtual Network | demoVNet1 |
| Subnet | demoVNetSubnet1 |
| Public IP | (new) demoVM1-ip |
| NIC NSG | Advanced |
| NSG Name | demoVM1-nsg |

Add inbound NSG rule:

| Setting | Value |
|---|---|
| Service | HTTP |
| Priority | 100 |
| Name | demoVM1-nsgRule |

Load balancing settings:

| Setting | Value |
|---|---|
| Load-balancing options | Azure load balancer |
| Load balancer | demoLoadBalancer1 |
| Backend pool | demoBackendPool1 |

Create `demoVM2` and `demoVM3` with the same settings, reusing the existing NSG, and place them into the same backend pool. 
---

### Step 6 — Install IIS on Each Virtual Machine

Connect to each VM using RDP and run PowerShell as Administrator.

Install IIS:

```powershell
Install-WindowsFeature -Name Web-Server -IncludeManagementTools
```

Remove the default web page:

```powershell
Remove-Item C:\inetpub\wwwroot\iisstart.htm
```

Create a custom page that displays the server name:

```powershell
Add-Content -Path "C:\inetpub\wwwroot\iisstart.htm" -Value $("Hello World from " + $env:computername)
```

Repeat this process on:

- demoVM1
- demoVM2
- demoVM3

This makes it possible to identify which backend VM served the request. 

---

### Step 7 — Test the Load Balancer

Navigate to:

```text
Load Balancer → Frontend IP configuration
```

Copy the public IP address and open it in a web browser.

Expected result:

- The IIS page loads successfully
- The page displays `Hello World from <computername>`
- Refreshing may show responses from different backend servers depending on the balancing behavior

This confirms that the load balancer is distributing traffic across the backend virtual machines. 

---

### Azure CLI (Bash)

Create the virtual network:

```bash
az network vnet create \
  --resource-group rg_westeurope_XXXXX \
  --name demoVNet1 \
  --location westeurope \
  --address-prefix 10.1.0.0/16 \
  --subnet-name demoVNetSubnet1 \
  --subnet-prefix 10.1.0.0/24
```

Create the NAT Gateway public IP:

```bash
az network public-ip create \
  --resource-group rg_westeurope_XXXXX \
  --name demoNATIP1 \
  --sku Standard
```

Create NAT Gateway:

```bash
az network nat gateway create \
  --resource-group rg_westeurope_XXXXX \
  --name DemoNATGW1 \
  --public-ip-addresses demoNATIP1 \
  --idle-timeout 15
```

Associate NAT Gateway with subnet:

```bash
az network vnet subnet update \
  --resource-group rg_westeurope_XXXXX \
  --vnet-name demoVNet1 \
  --name demoVNetSubnet1 \
  --nat-gateway DemoNATGW1
```

Create Load Balancer public IP:

```bash
az network public-ip create \
  --resource-group rg_westeurope_XXXXX \
  --name demoLBPublicIP \
  --sku Standard
```

Create Load Balancer:

```bash
az network lb create \
  --resource-group rg_westeurope_XXXXX \
  --name demoLoadBalancer1 \
  --sku Standard \
  --public-ip-address demoLBPublicIP \
  --frontend-ip-name demoFrontendIP \
  --backend-pool-name demoBackendPool1
```

Create health probe:

```bash
az network lb probe create \
  --resource-group rg_westeurope_XXXXX \
  --lb-name demoLoadBalancer1 \
  --name demoHealthProbe \
  --protocol tcp \
  --port 80
```

Create load-balancing rule:

```bash
az network lb rule create \
  --resource-group rg_westeurope_XXXXX \
  --lb-name demoLoadBalancer1 \
  --name demoHTTPRule \
  --protocol tcp \
  --frontend-port 80 \
  --backend-port 80 \
  --frontend-ip-name demoFrontendIP \
  --backend-pool-name demoBackendPool1 \
  --probe-name demoHealthProbe
```

Create a VM and attach it to the backend pool:

```bash
az vm create \
  --resource-group rg_westeurope_XXXXX \
  --name demoVM1 \
  --image Win2025Datacenter \
  --size Standard_B2s \
  --admin-username azureadmin \
  --admin-password 'StrongPassword123!' \
  --vnet-name demoVNet1 \
  --subnet demoVNetSubnet1 \
  --public-ip-address demoVM1-ip
```

---

### Azure PowerShell

Create the virtual network:

```powershell
$subnet = New-AzVirtualNetworkSubnetConfig `
  -Name "demoVNetSubnet1" `
  -AddressPrefix "10.1.0.0/24"

New-AzVirtualNetwork `
  -ResourceGroupName "rg_westeurope_XXXXX" `
  -Name "demoVNet1" `
  -Location "West Europe" `
  -AddressPrefix "10.1.0.0/16" `
  -Subnet $subnet
```

Create NAT Gateway public IP:

```powershell
$natIp = New-AzPublicIpAddress `
  -ResourceGroupName "rg_westeurope_XXXXX" `
  -Name "demoNATIP1" `
  -Location "West Europe" `
  -Sku Standard `
  -AllocationMethod Static
```

Create NAT Gateway:

```powershell
$natGw = New-AzNatGateway `
  -ResourceGroupName "rg_westeurope_XXXXX" `
  -Name "DemoNATGW1" `
  -Location "West Europe" `
  -IdleTimeoutInMinutes 15 `
  -Sku Standard `
  -PublicIpAddress $natIp
```

Associate NAT Gateway with subnet:

```powershell
$vnet = Get-AzVirtualNetwork -ResourceGroupName "rg_westeurope_XXXXX" -Name "demoVNet1"
$vnet.Subnets[0].NatGateway = $natGw
$vnet | Set-AzVirtualNetwork
```

Create Load Balancer public IP:

```powershell
$lbPip = New-AzPublicIpAddress `
  -ResourceGroupName "rg_westeurope_XXXXX" `
  -Name "demoLBPublicIP" `
  -Location "West Europe" `
  -Sku Standard `
  -AllocationMethod Static
```

Create Load Balancer:

```powershell
$frontend = New-AzLoadBalancerFrontendIpConfig `
  -Name "demoFrontendIP" `
  -PublicIpAddress $lbPip

$backend = New-AzLoadBalancerBackendAddressPoolConfig `
  -Name "demoBackendPool1"

$probe = New-AzLoadBalancerProbeConfig `
  -Name "demoHealthProbe" `
  -Protocol Tcp `
  -Port 80 `
  -IntervalInSeconds 15 `
  -ProbeCount 2

$lbrule = New-AzLoadBalancerRuleConfig `
  -Name "demoHTTPRule" `
  -FrontendIpConfiguration $frontend `
  -BackendAddressPool $backend `
  -Probe $probe `
  -Protocol Tcp `
  -FrontendPort 80 `
  -BackendPort 80

New-AzLoadBalancer `
  -ResourceGroupName "rg_westeurope_XXXXX" `
  -Name "demoLoadBalancer1" `
  -Location "West Europe" `
  -Sku Standard `
  -FrontendIpConfiguration $frontend `
  -BackendAddressPool $backend `
  -Probe $probe `
  -LoadBalancingRule $lbrule
```

Create a VM:

```powershell
New-AzVM `
  -ResourceGroupName "rg_westeurope_XXXXX" `
  -Name "demoVM1" `
  -Location "West Europe" `
  -Image "Win2025Datacenter" `
  -Size "Standard_B2s" `
  -Credential (Get-Credential)
```

Install IIS after connecting:

```powershell
Install-WindowsFeature -Name Web-Server -IncludeManagementTools
Remove-Item C:\inetpub\wwwroot\iisstart.htm
Add-Content -Path "C:\inetpub\wwwroot\iisstart.htm" -Value $("Hello World from " + $env:computername)
```

---

## Implementation Walkthrough

The lab started by creating a dedicated virtual network and subnet for the workload. A NAT Gateway was then deployed and attached to the subnet so the virtual machines could use controlled outbound internet access. After the base network was ready, an Azure Load Balancer was configured to accept inbound HTTP traffic and distribute it to a backend pool.

Three Windows Server virtual machines were then deployed into the same virtual network and associated with the load balancer backend pool. IIS was installed on each machine, and the default page was replaced with a host-specific message that displayed the computer name. This made it easy to confirm that requests were reaching the backend servers through the load balancer.

This implementation demonstrates real engineering thinking because it separates outbound connectivity through the NAT Gateway from inbound application delivery through the Load Balancer, which is a common pattern in Azure network design.

---

## Results & Validation

| Test | Result |
|---|---|
| Virtual network creation | Successful |
| Subnet configuration | Successful |
| NAT Gateway deployment | Successful |
| Load Balancer deployment | Successful |
| Three VM deployments | Successful |
| IIS installation on all VMs | Successful |
| HTTP access through Load Balancer public IP | Successful |

Key observations:

- The NAT Gateway handled outbound subnet connectivity
- The Load Balancer provided a single entry point for inbound HTTP traffic
- IIS customization made backend responses visible during testing
- The backend pool allowed multiple VMs to serve the same application endpoint

---

## Validation Walkthrough

1. Verified that `demoVNet1` and `demoVNetSubnet1` were created successfully.
2. Confirmed that `DemoNATGW1` was deployed and associated with the subnet.
3. Verified that the Azure Load Balancer and backend pool were created.
4. Confirmed that `demoVM1`, `demoVM2`, and `demoVM3` were deployed in the same virtual network.
5. Connected to each VM using RDP.
6. Installed IIS on each VM and created a custom `iisstart.htm` file showing the server name.
7. Opened the load balancer public IP in a browser.
8. Confirmed that the custom IIS page loaded successfully from the backend infrastructure.

---

## Real-World Use Case

This design is common for **high-availability web applications** in Azure.

Example: **Internal Business Web Application**

| Component | Role |
|---|---|
| Virtual Network | Private application network |
| NAT Gateway | Outbound internet access |
| Azure Load Balancer | Inbound traffic distribution |
| Multiple VMs | Redundant application servers |
| IIS | Web service hosting |

Typical workflow:

```text
User Request
    ↓
Azure Load Balancer Public IP
    ↓
Backend Pool
    ↓
demoVM1 / demoVM2 / demoVM3
    ↓
IIS Web Response
```

This approach improves uptime, supports horizontal scaling, and reduces the risk of a single-server failure affecting service availability.

---

## Key Takeaways

This lab demonstrated several important Azure networking concepts:

- Azure Load Balancer distributes inbound traffic across multiple backend servers
- NAT Gateway provides centralized outbound internet access for subnet resources
- Virtual machines can be combined with load balancing to increase application availability
- IIS installation on each backend helps validate real traffic flow
- Separating inbound and outbound networking roles reflects strong cloud architecture practice

Understanding Azure Load Balancer, NAT Gateway, and backend VM design is essential for cloud engineers, Azure administrators, and infrastructure teams building resilient application environments.

