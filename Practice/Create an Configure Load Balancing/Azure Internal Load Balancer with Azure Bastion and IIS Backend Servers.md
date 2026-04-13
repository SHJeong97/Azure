# Azure Internal Load Balancer with Azure Bastion and IIS Backend Servers

## Introduction

Azure Load Balancer is a Layer 4 load balancing service that distributes traffic across multiple backend resources. When deployed as an **internal** load balancer, it provides private application access inside a virtual network rather than exposing the service directly to the internet.

In this lab, a virtual network was created with a backend subnet and **Azure Bastion** enabled. An **internal Standard Load Balancer** was then deployed, followed by backend virtual machines running IIS. A separate test virtual machine was used to access the load balancer’s **private IP address** through Bastion and verify that traffic was distributed across the backend servers. The lab also introduced **Log Analytics Workspace** creation and **Load Balancer Insights** for monitoring topology, health probe status, and throughput metrics.

## Objectives

The objectives of this lab were to:

- Create an Azure Virtual Network with a custom address space
- Create a backend subnet for application servers
- Enable Azure Bastion for secure browser-based VM access
- Deploy an internal Standard Load Balancer
- Create a backend pool for the load balancer
- Deploy backend virtual machines and install IIS
- Create a test virtual machine to validate traffic flow
- Access the load balancer through its private IP address
- Use Load Balancer Insights and Log Analytics for monitoring visibility

## Architecture Diagram

```text
                +----------------------+
                |   Azure Subscription |
                +----------+-----------+
                           |
                +----------+-----------+
                |       Resource Group |
                |     rg_eastus_xxxxx  |
                +----------+-----------+
                           |
                +----------+-----------+
                |     Virtual Network  |
                |       10.1.0.0/16    |
                +----------+-----------+
                           |
        +------------------+------------------+
        |                                     |
+-------+--------+                    +-------+--------+
| Azure Bastion  |                    | MyBackendSubnet|
| MyBastionHost  |                    |   App Subnet   |
+-------+--------+                    +-------+--------+
        |                                     |
        |                           +---------+---------+
        |                           | Internal Load     |
        |                           | Balancer          |
        |                           | DemoLoadBalancer1 |
        |                           | Private Frontend  |
        |                           +---------+---------+
        |                                     |
        |                         +-----------+-----------+
        |                         |       Backend Pool    |
        |                         +-----+-----------+-----+
        |                               |           |
        |                         +-----+--+   +---+-----+
        |                         | DEMOVM2 |   | DEMOVM3 |
        |                         |  IIS    |   |  IIS    |
        |                         +--------+   +---------+
        |
+-------+--------+
| DemoTestVM1    |
| Browser Access |
+----------------+
```

This architecture shows an internal-only application path: the test VM reaches the load balancer over the private network, while Azure Bastion provides secure management access without exposing public RDP directly to the virtual machines.
## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser session is recommended to avoid Azure portal cache issues. 

### Step 2 — Create a Virtual Network

Navigate to:

```text
Virtual Network → Create
```

Configure the virtual network with these core settings:

| Setting | Value |
|---|---|
| Resource Group | Existing assigned resource group |
| Region | East US |
| Virtual Network Name | Unique name |
| Address Space | 10.1.0.0/16 |

Create the subnet with:

| Setting | Value |
|---|---|
| Subnet Name | MyBackendSubnet |
| Address Range | 10.1.0.0/16 |

Then enable **Azure Bastion** during VNet creation:

| Setting | Value |
|---|---|
| Bastion Host Name | MyBastionHost |
| Bastion Public IP | MyBastionIP |
| Public IP SKU | Standard |

Review and create the virtual network
<img width="1523" height="1753" alt="image" src="https://github.com/user-attachments/assets/57c04d3d-488c-4b59-aa17-31047e0e7ca0" />


### Step 3 — Create an Internal Load Balancer

Navigate to:

```text
Load Balancers → Create Standard Load Balancer
```

Configure the load balancer:

| Setting | Value |
|---|---|
| Name | DemoLoadBalancer1 |
| SKU | Standard |
| Type | Internal |

Create the frontend IP configuration with:

| Setting | Value |
|---|---|
| Frontend Name | LdemoLoadBalancerFrontend1 |
| Virtual Network | Previously created VNet |
| Subnet | MyBackendSubnet |
| Assignment | Dynamic |

Review and create the internal load balancer.
<img width="1523" height="588" alt="image" src="https://github.com/user-attachments/assets/a5c00cc5-c159-4d9a-8edb-6561e36cfe7a" />

### Step 4 — Create the Backend Pool

Open the newly created load balancer and create a backend pool to hold the NICs of the backend application servers.

This backend pool will later be associated with the IIS virtual machines so the load balancer can distribute traffic to them. 
<img width="1523" height="769" alt="image" src="https://github.com/user-attachments/assets/d00100cb-fda8-4958-af87-77e8a6b8325b" />


### Step 5 — Deploy Backend Virtual Machines

Deploy the application VMs into the same virtual network and backend subnet. The backend servers referenced in the lab are:

- `DEMOVM2`
- `DEMOVM3`

These machines act as IIS web servers behind the internal load balancer. 

### Step 6 — Install IIS on Backend Virtual Machines

Connect to each backend VM and run PowerShell as Administrator.

Install IIS:

```powershell
Install-WindowsFeature -Name Web-Server -IncludeManagementTools
```

Create a custom default home page:

```powershell
Add-Content -Path "C:\inetpub\wwwroot\iisstart.htm" -Value $("Hello world from " + $env:computername)
```

Repeat the process for both backend virtual machines.

This makes it easy to validate which backend server responded when requests are sent through the load balancer.
<img width="1523" height="303" alt="image" src="https://github.com/user-attachments/assets/d20abe41-fec7-42e6-8e1b-f724b6c1a79c" />


### Step 7 — Create a Test Virtual Machine

Create a separate test VM with these key settings:

| Setting | Value |
|---|---|
| Name | DemoTestVM1 |
| Region | East US |
| Image | Windows Server 2019 Datacenter - x64 Gen2 |
| Size | Standard B2s |
| Public IP | None |
| NIC Network Security Group | Advanced |
| NSG | myNSG |

This VM is used to validate the internal load balancer privately from inside the VNet. 
<img width="1381" height="1919" alt="image" src="https://github.com/user-attachments/assets/7915c0ae-661a-4790-bd4a-506012abe6b6" />
<img width="1523" height="733" alt="image" src="https://github.com/user-attachments/assets/e16d9b3e-3618-4a43-9b36-a501c7f9d191" />



### Step 8 — Test the Internal Load Balancer

Open the load balancer overview page and copy its **private IP address**.

Then connect to `DemoTestVM1` using **Bastion**. Inside the test VM:

1. Open Internet Explorer
2. Paste the private IP address of the internal load balancer
3. Load the page

Expected result:

- The IIS default page responds from either `DEMOVM2` or `DEMOVM3`
- Refreshing the page returns a response from the other backend VM at times


This confirms the internal load balancer is distributing traffic across the backend pool. 
<img width="713" height="330" alt="image" src="https://github.com/user-attachments/assets/47273ac8-59bb-4db7-970e-251ef40cf4cc" />


### Step 9 — Create a Log Analytics Workspace

Navigate to:

```text
Log Analytics workspaces → Create
```

Configure:

| Setting | Value |
|---|---|
| Name | DemoWorkspace1 |
| Region | East US |

Create the workspace.
<img width="1494" height="1138" alt="image" src="https://github.com/user-attachments/assets/1aa43d2a-bcfc-4ec8-a766-01cf85254d95" />


### Step 10 — Use Load Balancer Insights

Navigate to the load balancer and open:

```text
Monitoring → Insights
```

Use the **functional dependency view** to examine the load balancer topology. Then open the **metrics pane** and review detailed views such as:

- Availability overview
- Frontend and backend availability
- Health probe status
- Data throughput

This provides visibility into both the load balancer path and the responsiveness of backend instances.

### Azure CLI (Bash)

Create the virtual network:

```bash
az network vnet create \
  --resource-group rg_eastus_XXXXX \
  --name DemoVNet1 \
  --location eastus \
  --address-prefix 10.1.0.0/16 \
  --subnet-name MyBackendSubnet \
  --subnet-prefix 10.1.0.0/24
```

Create the public IP for Bastion:

```bash
az network public-ip create \
  --resource-group rg_eastus_XXXXX \
  --name MyBastionIP \
  --sku Standard \
  --location eastus
```

Create Bastion:

```bash
az network bastion create \
  --resource-group rg_eastus_XXXXX \
  --name MyBastionHost \
  --public-ip-address MyBastionIP \
  --vnet-name DemoVNet1 \
  --location eastus
```

Create the internal load balancer:

```bash
az network lb create \
  --resource-group rg_eastus_XXXXX \
  --name DemoLoadBalancer1 \
  --sku Standard \
  --vnet-name DemoVNet1 \
  --subnet MyBackendSubnet \
  --private-ip-address-version IPv4 \
  --frontend-ip-name LdemoLoadBalancerFrontend1 \
  --backend-pool-name DemoBackendPool1
```

Create a probe:

```bash
az network lb probe create \
  --resource-group rg_eastus_XXXXX \
  --lb-name DemoLoadBalancer1 \
  --name DemoHealthProbe \
  --protocol tcp \
  --port 80
```

Create a load-balancing rule:

```bash
az network lb rule create \
  --resource-group rg_eastus_XXXXX \
  --lb-name DemoLoadBalancer1 \
  --name DemoHttpRule \
  --protocol tcp \
  --frontend-port 80 \
  --backend-port 80 \
  --frontend-ip-name LdemoLoadBalancerFrontend1 \
  --backend-pool-name DemoBackendPool1 \
  --probe-name DemoHealthProbe
```

Create a Log Analytics workspace:

```bash
az monitor log-analytics workspace create \
  --resource-group rg_eastus_XXXXX \
  --workspace-name DemoWorkspace1 \
  --location eastus
```

### Azure PowerShell

Create the subnet and virtual network:

```powershell
$subnet = New-AzVirtualNetworkSubnetConfig `
  -Name "MyBackendSubnet" `
  -AddressPrefix "10.1.0.0/24"

New-AzVirtualNetwork `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "DemoVNet1" `
  -Location "East US" `
  -AddressPrefix "10.1.0.0/16" `
  -Subnet $subnet
```

Create the Bastion public IP:

```powershell
$pubIp = New-AzPublicIpAddress `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "MyBastionIP" `
  -Location "East US" `
  -Sku Standard `
  -AllocationMethod Static
```

Create Bastion:

```powershell
New-AzBastion `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "MyBastionHost" `
  -PublicIpAddressRgName "rg_eastus_XXXXX" `
  -PublicIpAddressName "MyBastionIP" `
  -VirtualNetworkRgName "rg_eastus_XXXXX" `
  -VirtualNetworkName "DemoVNet1" `
  -Sku "Standard"
```

Create the internal load balancer:

```powershell
$vnet = Get-AzVirtualNetwork -ResourceGroupName "rg_eastus_XXXXX" -Name "DemoVNet1"
$frontend = New-AzLoadBalancerFrontendIpConfig `
  -Name "LdemoLoadBalancerFrontend1" `
  -SubnetId $vnet.Subnets[0].Id `
  -PrivateIpAddressVersion "IPv4"

$backend = New-AzLoadBalancerBackendAddressPoolConfig `
  -Name "DemoBackendPool1"

$probe = New-AzLoadBalancerProbeConfig `
  -Name "DemoHealthProbe" `
  -Protocol Tcp `
  -Port 80 `
  -IntervalInSeconds 15 `
  -ProbeCount 2

$rule = New-AzLoadBalancerRuleConfig `
  -Name "DemoHttpRule" `
  -FrontendIpConfiguration $frontend `
  -BackendAddressPool $backend `
  -Probe $probe `
  -Protocol Tcp `
  -FrontendPort 80 `
  -BackendPort 80

New-AzLoadBalancer `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "DemoLoadBalancer1" `
  -Location "East US" `
  -Sku Standard `
  -FrontendIpConfiguration $frontend `
  -BackendAddressPool $backend `
  -Probe $probe `
  -LoadBalancingRule $rule
```

Create the Log Analytics workspace:

```powershell
New-AzOperationalInsightsWorkspace `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "DemoWorkspace1" `
  -Location "East US" `
  -Sku "PerGB2018"
```

## Implementation Walkthrough

The lab started with the deployment of a custom virtual network using the address space `10.1.0.0/16`. A backend subnet was added to host the application servers, and Azure Bastion was enabled at the network layer so administrators could connect to virtual machines securely from the browser. This avoided relying on public RDP access while still supporting management operations. 

Next, a **Standard internal load balancer** was created with a dynamically assigned private frontend IP in the backend subnet. A backend pool was then created so the NICs of the backend virtual machines could be registered with the load balancer. Backend virtual machines running IIS were configured to return host-specific responses, making it possible to confirm the traffic distribution behavior during testing. 

A separate test VM was then deployed with **no public IP**, and Bastion was used to access it privately. From that test system, the load balancer’s private IP was opened in the browser. The response alternated between backend servers such as `DEMOVM2` and `DEMOVM3`, confirming successful internal load balancing. Finally, a Log Analytics workspace was created and Load Balancer Insights was used to review the functional dependency view, health probe data, and throughput metrics. 
## Results & Validation

| Test | Result |
|---|---|
| Virtual network creation | Successful |
| Backend subnet creation | Successful |
| Azure Bastion deployment | Successful |
| Internal load balancer deployment | Successful |
| Backend pool configuration | Successful |
| IIS installation on backend VMs | Successful |
| Test VM deployment | Successful |
| Private IP access through test VM | Successful |
| Load balancing across backend servers | Successful |
| Log Analytics workspace creation | Successful |
| Load Balancer Insights review | Successful |

Key observations:

- The application was not exposed through a public frontend because the load balancer was internal
- Azure Bastion provided secure VM access without depending on public RDP
- Backend IIS customization made traffic distribution visible during testing
- Load Balancer Insights added operational visibility for availability and throughput

## Validation Walkthrough

1. Verified that the virtual network and `MyBackendSubnet` were created successfully.
2. Confirmed Azure Bastion was enabled with `MyBastionHost` and `MyBastionIP`.
3. Verified that `DemoLoadBalancer1` was created as an **internal** Standard Load Balancer.
4. Confirmed that the frontend IP configuration `LdemoLoadBalancerFrontend1` used the backend subnet.
5. Verified that the backend pool was configured for the application servers.
6. Installed IIS on backend VMs and created host-specific `iisstart.htm` content.
7. Deployed `DemoTestVM1` without a public IP.
8. Copied the private IP address of the load balancer from the overview page.
9. Used Bastion to connect to the test VM.
10. Opened the load balancer private IP in the browser and confirmed a response from either `DEMOVM2` or `DEMOVM3`.
11. Refreshed the page and confirmed traffic could be served by another backend VM.
12. Created `DemoWorkspace1` and opened **Insights** on the load balancer.
13. Reviewed the functional dependency view, frontend/backend availability, health probe charts, and throughput metrics.

## Real-World Use Case

This design is common for **private line-of-business applications** that should only be accessible inside a corporate Azure network.

Example: **Internal HR or Finance Web Application**

| Component | Role |
|---|---|
| Virtual Network | Private application boundary |
| Azure Bastion | Secure administrator access |
| Internal Load Balancer | Private application entry point |
| Backend IIS VMs | Web application servers |
| Test / Jump VM | Internal validation client |
| Log Analytics + Insights | Monitoring and troubleshooting |

Typical workflow:

```text
Administrator connects through Bastion
            ↓
Internal client VM accesses private frontend IP
            ↓
Internal Load Balancer distributes request
            ↓
Backend IIS servers respond
            ↓
Insights and metrics show availability and health
```

This pattern is useful when organizations want application redundancy and observability without exposing the application directly to the public internet.

## Key Takeaways

This lab demonstrated several important Azure networking and operations concepts:

- An **internal** Azure Load Balancer provides private application access inside a virtual network
- Azure Bastion improves management security by reducing the need for public RDP exposure
- Backend pools allow multiple virtual machines to serve the same application endpoint
- IIS customization is a practical way to validate load balancing behavior
- Load Balancer Insights and Log Analytics improve visibility into topology, health probe status, and throughput
- This architecture reflects real enterprise design patterns for internal-only applications

