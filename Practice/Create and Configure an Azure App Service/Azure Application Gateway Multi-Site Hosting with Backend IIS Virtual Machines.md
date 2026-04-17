# Azure Application Gateway Multi-Site Hosting with Backend IIS Virtual Machines

## Introduction

Azure Application Gateway is a Layer 7 load balancing service that provides advanced web traffic management features such as host-based routing, path-based routing, SSL termination, and web application firewall integration. Unlike a standard load balancer, Application Gateway can make routing decisions based on HTTP request details, which makes it useful for modern web applications and multi-site hosting scenarios.

In this lab, two Windows virtual machines were created as backend web servers, IIS was installed on both machines, and an Azure Application Gateway was deployed with **multi-site listeners**. Separate backend pools and routing rules were configured so that requests for different hostnames were directed to different backend virtual machines.

This lab demonstrates how Azure Application Gateway can host multiple sites behind one public IP address by using host-based routing. 

## Objectives

The objectives of this lab were to:

- Create two backend Windows virtual machines
- Create a virtual network with separate subnets for backend servers and Application Gateway
- Install IIS on both backend virtual machines
- Create an Azure Application Gateway
- Configure separate backend pools for each virtual machine
- Configure multi-site listeners using host-based routing
- Map hostnames to the Application Gateway public IP in the local hosts file
- Validate that different hostnames route traffic to different backend servers

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
                |      Virtual Network |
                |        myVNet        |
                |      10.0.0.0/16     |
                +----------+-----------+
                           |
        +------------------+------------------+
        |                                     |
+-------+--------+                    +-------+--------+
| myAGSubnet     |                    | demoBackendSubnet |
| App Gateway    |                    | Backend Servers   |
+-------+--------+                    +-------+--------+
        |                                     |
+-------+--------+                 +----------+----------+
| Application    |                 |                     |
| Gateway        |          +------+-----+       +------+-----+
| demoAppGateway |          |  demoVM1   |       |  demoVM2   |
| Public IP      |          | IIS Server |       | IIS Server |
+-------+--------+          +------+-----+       +------+-----+
        |                          ^                    ^
        |                          |                    |
        |                +---------+                    +---------+
        |                |                                        |
        +----------------+----------------+-----------------------+
                         |                |
               Host-based Rule 1   Host-based Rule 2
               www.vm1.com         www.vm2.com
```

This architecture shows one public Application Gateway routing traffic to different backend virtual machines based on the requested hostname.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser window is recommended to avoid Azure portal cache issues.

---

### Step 2 — Create the First Backend Virtual Machine

Navigate to:

```text
Virtual Machines → Create → Azure virtual machine
```

Configure the first virtual machine with the following settings:

| Setting | Value |
|---|---|
| Resource Group | rg_eastus_XXXXX |
| Virtual Machine Name | demoVM1 |
| Region | East US |
| Availability Options | No infrastructure redundancy required |
| Security Type | Standard |
| Image | Windows Server 2025 Datacenter: Azure Edition - x64 Gen2 |
| Size | Standard_B2s |
| Username | Lab-defined username |
| Password | Secure password |
| Public Inbound Ports | Allow selected ports |
| Inbound Port | RDP (3389) |
| OS Disk Type | Standard SSD |

Create a new virtual network during deployment:

| Setting | Value |
|---|---|
| Virtual Network Name | myVNet |
| Address Range | 10.0.0.0/16 |
| Subnet 1 Name | myAGSubnet |
| Subnet 2 Name | demoBackendSubnet |
| Subnet 2 Range | 10.0.1.0/24 |

Select:

```text
demoBackendSubnet
```

for the VM subnet.

On the **Monitoring** tab, disable:

```text
Boot diagnostics
```

Review and create the VM.

---

### Step 3 — Create the Second Backend Virtual Machine

Repeat the virtual machine creation process for the second VM.

Use the following settings:

| Setting | Value |
|---|---|
| Virtual Machine Name | demoVM2 |
| Virtual Network | myVNet |
| Subnet | demoBackendSubnet |
| Region | East US |
| Image | Windows Server 2025 Datacenter: Azure Edition - x64 Gen2 |
| Size | Standard_B2s |

Review and create the second virtual machine.

---

### Step 4 — Install IIS on Both Virtual Machines

Open **Cloud Shell** in the Azure Portal and choose:

```text
PowerShell
```

Set the resource group variable:

```powershell
$ResourceGroup="<resource-group-name>"
```

Install IIS and append the computer name to the default web page on `demoVM1`:

```powershell
Set-AzVMExtension -ResourceGroupName $ResourceGroup -ExtensionName IIS -VMName demoVM1 -Publisher Microsoft.Compute -ExtensionType CustomScriptExtension -TypeHandlerVersion 1.4 -SettingString '{"commandToExecute":"powershell Add-WindowsFeature Web-Server; powershell Add-Content -Path \"C:\\inetpub\\wwwroot\\Default.htm\" -Value $($env:computername)"}' -Location eastus
```

Install IIS and append the computer name to the default web page on `demoVM2`:

```powershell
Set-AzVMExtension -ResourceGroupName $ResourceGroup -ExtensionName IIS -VMName demoVM2 -Publisher Microsoft.Compute -ExtensionType CustomScriptExtension -TypeHandlerVersion 1.4 -SettingString '{"commandToExecute":"powershell Add-WindowsFeature Web-Server; powershell Add-Content -Path \"C:\\inetpub\\wwwroot\\Default.htm\" -Value $($env:computername)"}' -Location eastus
```

These commands install the IIS role and make each backend page identifiable by its VM name.

—
<img width="1523" height="320" alt="image" src="https://github.com/user-attachments/assets/cad0e1ec-b942-42b8-a548-fb27945fef60" />


### Step 5 — Create the Application Gateway

Navigate to:

```text
Application Gateways → Create
```

Configure the gateway:

| Setting | Value |
|---|---|
| Resource Group | rg_eastus_XXXXX |
| Application Gateway Name | demoAppGateway |
| Region | East US |
| Tier | Standard v2 |
| Minimum Instance Count | 0 |
| Maximum Instance Count | 2 |
| Virtual Network | myVNet |
| Subnet | myAGSubnet |

On the **Frontends** tab:

| Setting | Value |
|---|---|
| Frontend IP Type | Public |
| Public IP Name | demoAGPublicIPAddress |

---

### Step 6 — Create Backend Pools

On the **Backends** tab, add the first backend pool:

| Setting | Value |
|---|---|
| Backend Pool Name | demoVM1Pool |
| Target Type | Virtual machine |
| Target | Network interface for demoVM1 |

Add the second backend pool:

| Setting | Value |
|---|---|
| Backend Pool Name | demoVM2Pool |
| Target Type | Virtual machine |
| Target | Network interface for demoVM2 |

---

### Step 7 — Configure the First Routing Rule

On the **Configuration** tab, add a routing rule:

| Setting | Value |
|---|---|
| Rule Name | vm1Rule |
| Priority | 100 |

Listener settings:

| Setting | Value |
|---|---|
| Listener Name | vm1Listener |
| Frontend IP | Public IPv4 |
| Protocol | HTTP |
| Port | 80 |
| Listener Type | Multi site |
| Host Type | Single |
| Host Name | www.vm1.com |

Backend target settings:

| Setting | Value |
|---|---|
| Target Type | Backend pool |
| Backend Target | demoVM1Pool |
| Backend Settings Name | cvm1Setting |

Add the rule.

---

### Step 8 — Configure the Second Routing Rule

Add a second routing rule:

| Setting | Value |
|---|---|
| Rule Name | vm2Rule |
| Priority | 101 |

Listener settings:

| Setting | Value |
|---|---|
| Listener Name | vm2Listner |
| Frontend IP | Public IPv4 |
| Protocol | HTTP |
| Port | 80 |
| Listener Type | Multi site |
| Host Type | Single |
| Host Name | www.vm2.com |

Backend target settings:

| Setting | Value |
|---|---|
| Target Type | Backend pool |
| Backend Target | demoVM2Pool |
| Backend Settings Name | vm2Setting |

Add the rule.

Review and create the Application Gateway deployment.

—


### Step 9 — Update the Local Hosts File

After the Application Gateway deployment completes, copy its public IP address from the overview page.

Open **Notepad as Administrator** and edit the local hosts file:

```text
C:\Windows\System32\drivers\etc\hosts
```

Add entries like the following, replacing `x.x.x.x` with the Application Gateway public IP:

```text
x.x.x.x www.vm1.com
x.x.x.x www.vm2.com
```

Save the file.

—


### Step 10 — Test Multi-Site Routing

Open a web browser and go to:

```text
www.vm1.com
```

Expected result:

- The page from `demoVM1` loads

Then browse to:

```text
www.vm2.com
```

Expected result:

- The page from `demoVM2` loads

Because IIS added the computer name into the default page on each server, the backend response confirms that host-based routing is working correctly.



## Azure CLI (Bash)

Create the virtual network with both subnets:

```bash
az network vnet create \
  --resource-group rg_eastus_XXXXX \
  --name myVNet \
  --location eastus \
  --address-prefix 10.0.0.0/16 \
  --subnet-name myAGSubnet \
  --subnet-prefix 10.0.0.0/24
```

Add the backend subnet:

```bash
az network vnet subnet create \
  --resource-group rg_eastus_XXXXX \
  --vnet-name myVNet \
  --name demoBackendSubnet \
  --address-prefixes 10.0.1.0/24
```

Create `demoVM1`:

```bash
az vm create \
  --resource-group rg_eastus_XXXXX \
  --name demoVM1 \
  --image Win2025Datacenter \
  --size Standard_B2s \
  --admin-username azureadmin \
  --admin-password 'StrongPassword123!' \
  --vnet-name myVNet \
  --subnet demoBackendSubnet
```

Create `demoVM2`:

```bash
az vm create \
  --resource-group rg_eastus_XXXXX \
  --name demoVM2 \
  --image Win2025Datacenter \
  --size Standard_B2s \
  --admin-username azureadmin \
  --admin-password 'StrongPassword123!' \
  --vnet-name myVNet \
  --subnet demoBackendSubnet
```

Create the Application Gateway public IP:

```bash
az network public-ip create \
  --resource-group rg_eastus_XXXXX \
  --name demoAGPublicIPAddress \
  --sku Standard \
  --location eastus
```

Create the Application Gateway:

```bash
az network application-gateway create \
  --resource-group rg_eastus_XXXXX \
  --name demoAppGateway \
  --location eastus \
  --sku Standard_v2 \
  --capacity 1 \
  --vnet-name myVNet \
  --subnet myAGSubnet \
  --public-ip-address demoAGPublicIPAddress
```

## Azure PowerShell

Create the virtual network and subnets:

```powershell
$subnet1 = New-AzVirtualNetworkSubnetConfig `
  -Name "myAGSubnet" `
  -AddressPrefix "10.0.0.0/24"

$subnet2 = New-AzVirtualNetworkSubnetConfig `
  -Name "demoBackendSubnet" `
  -AddressPrefix "10.0.1.0/24"

New-AzVirtualNetwork `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "myVNet" `
  -Location "East US" `
  -AddressPrefix "10.0.0.0/16" `
  -Subnet $subnet1, $subnet2
```

Create `demoVM1`:

```powershell
New-AzVM `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "demoVM1" `
  -Location "East US" `
  -Image "Win2025Datacenter" `
  -Size "Standard_B2s" `
  -Credential (Get-Credential)
```

Create `demoVM2`:

```powershell
New-AzVM `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "demoVM2" `
  -Location "East US" `
  -Image "Win2025Datacenter" `
  -Size "Standard_B2s" `
  -Credential (Get-Credential)
```

Install IIS extension on `demoVM1`:

```powershell
Set-AzVMExtension `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -ExtensionName "IIS" `
  -VMName "demoVM1" `
  -Publisher "Microsoft.Compute" `
  -ExtensionType "CustomScriptExtension" `
  -TypeHandlerVersion "1.4" `
  -SettingString '{"commandToExecute":"powershell Add-WindowsFeature Web-Server; powershell Add-Content -Path \"C:\\inetpub\\wwwroot\\Default.htm\" -Value $($env:computername)"}' `
  -Location "eastus"
```

Install IIS extension on `demoVM2`:

```powershell
Set-AzVMExtension `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -ExtensionName "IIS" `
  -VMName "demoVM2" `
  -Publisher "Microsoft.Compute" `
  -ExtensionType "CustomScriptExtension" `
  -TypeHandlerVersion "1.4" `
  -SettingString '{"commandToExecute":"powershell Add-WindowsFeature Web-Server; powershell Add-Content -Path \"C:\\inetpub\\wwwroot\\Default.htm\" -Value $($env:computername)"}' `
  -Location "eastus"
```

## Implementation Walkthrough

The lab began by building the backend environment first. Two Windows Server 2025 virtual machines, `demoVM1` and `demoVM2`, were deployed into a dedicated backend subnet named `demoBackendSubnet` inside a virtual network called `myVNet`. A separate subnet named `myAGSubnet` was also created specifically for the Application Gateway, which is a required architectural pattern because Application Gateway must live in its own subnet. :contentReference[oaicite:1]{index=1}

After the backend infrastructure was in place, IIS was installed on both virtual machines using `Set-AzVMExtension` in Azure Cloud Shell PowerShell. The extension command not only installed the **Web-Server** role but also modified the default IIS home page to include the VM’s computer name. This was important for validation because it made it easy to see which backend server responded to each request. :contentReference[oaicite:2]{index=2}

The next phase was the Application Gateway deployment. A Standard v2 Application Gateway named `demoAppGateway` was created in the `myAGSubnet` subnet with a public frontend IP. Two backend pools were then created: `demoVM1Pool` pointing to `demoVM1`, and `demoVM2Pool` pointing to `demoVM2`. Two multi-site listeners and routing rules were configured so that requests for `www.vm1.com` would be sent to `demoVM1Pool`, while requests for `www.vm2.com` would be sent to `demoVM2Pool`. :contentReference[oaicite:3]{index=3}

Finally, the hosts file on the local test machine was updated so both hostnames pointed to the Application Gateway public IP. Browsing to `www.vm1.com` displayed the IIS page for `demoVM1`, while browsing to `www.vm2.com` displayed the IIS page for `demoVM2`. This confirmed that the Application Gateway was correctly performing host-based routing for multiple websites behind a single public endpoint. :contentReference[oaicite:4]{index=4}

## Results & Validation

| Test | Result |
|---|---|
| Virtual network creation | Successful |
| Application Gateway subnet creation | Successful |
| Backend subnet creation | Successful |
| Backend VM deployment | Successful |
| IIS installation on both VMs | Successful |
| Application Gateway deployment | Successful |
| Backend pool configuration | Successful |
| Multi-site listener configuration | Successful |
| Host-based routing rule creation | Successful |
| Hosts file update | Successful |
| `www.vm1.com` routing test | Successful |
| `www.vm2.com` routing test | Successful |

Key observations:

- Application Gateway required a dedicated subnet separate from backend workloads
- Multi-site listeners allowed different hostnames to share one public IP and port
- Separate backend pools provided precise control over traffic routing
- IIS page customization made backend validation clear during testing
- Host-based routing successfully directed traffic to the correct virtual machine

## Validation Walkthrough

1. Verified that `myVNet` was created with the address space `10.0.0.0/16`.
2. Confirmed that `myAGSubnet` and `demoBackendSubnet` were created successfully.
3. Verified that `demoVM1` and `demoVM2` were deployed into `demoBackendSubnet`.
4. Ran the PowerShell VM extension commands and confirmed IIS installation completed on both backend servers.
5. Verified that each IIS default page included its VM computer name.
6. Confirmed that `demoAppGateway` was created in `myAGSubnet` with a public frontend IP.
7. Verified that `demoVM1Pool` targeted `demoVM1` and `demoVM2Pool` targeted `demoVM2`.
8. Confirmed that `vm1Rule` used the hostname `www.vm1.com` and mapped to `demoVM1Pool`.
9. Confirmed that `vm2Rule` used the hostname `www.vm2.com` and mapped to `demoVM2Pool`.
10. Updated the local hosts file so both hostnames pointed to the Application Gateway public IP.
11. Opened `www.vm1.com` in the browser and confirmed the response came from `demoVM1`.
12. Opened `www.vm2.com` in the browser and confirmed the response came from `demoVM2`.

## Real-World Use Case

Azure Application Gateway multi-site hosting is commonly used when organizations want to host multiple websites behind a single public entry point.

Example: **Multi-Site Web Hosting Behind One Gateway**

| Component | Role |
|---|---|
| Application Gateway | Layer 7 traffic distribution |
| Public IP | Shared public entry point |
| Multi-site listeners | Detect requested hostname |
| Backend pools | Separate site destinations |
| IIS backend servers | Host the actual web content |

Typical workflow:

```text
User Requests www.vm1.com
            ↓
Application Gateway Listener Matches Hostname
            ↓
Routing Rule Sends Traffic to demoVM1Pool
            ↓
demoVM1 Returns the Website

User Requests www.vm2.com
            ↓
Application Gateway Listener Matches Hostname
            ↓
Routing Rule Sends Traffic to demoVM2Pool
            ↓
demoVM2 Returns the Website
```

This design is useful for shared web infrastructure, multi-tenant environments, application consolidation, and scenarios where multiple websites must be served through one gateway.

## Key Takeaways

This lab demonstrated several important Azure application delivery concepts:

- Azure Application Gateway provides Layer 7 host-based routing capabilities
- A dedicated subnet is required for Application Gateway deployments
- Multi-site listeners allow multiple hostnames to share one public IP and port
- Separate backend pools make it possible to route traffic to specific backend servers
- IIS customization is an effective validation method for host-based routing tests

Understanding Azure Application Gateway multi-site routing is valuable for cloud administrators, Azure engineers, and infrastructure teams responsible for web traffic management and application delivery in Azure.

