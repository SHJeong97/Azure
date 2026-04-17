# Azure Storage Access Control with Virtual Network Service Endpoints and NSGs

## Introduction

Azure virtual networks, subnets, network security groups, and service endpoints work together to control how resources communicate across an Azure environment. This becomes especially important when an organization wants storage services to be reachable only from approved network segments while blocking access from less trusted subnets.

In this lab, a virtual network was created with separate **Public** and **Private** subnets. A **Microsoft.Storage service endpoint** was enabled only on the **Private** subnet. Network security groups were then configured to control RDP and outbound traffic behavior for each subnet. An Azure Storage Account with a file share was created and configured to allow network access only from the **Private** subnet. Finally, two Windows virtual machines were deployed—one in each subnet—and the same PowerShell mapping script was tested from both systems. The VM in the **Private** subnet successfully mapped the file share, while the VM in the **Public** subnet received **Access is denied**.

This lab demonstrates how Azure network segmentation and service endpoints can be used to enforce storage access boundaries.

## Objectives

The objectives of this lab were to:

- Create an Azure virtual network with Public and Private subnets
- Enable a Microsoft.Storage service endpoint on the Private subnet
- Create and configure network security groups for both subnets
- Restrict general internet egress from the Private subnet while allowing storage access
- Create an Azure Storage Account and SMB file share
- Restrict storage account network access to the Private subnet only
- Deploy one virtual machine in the Private subnet and one in the Public subnet
- Test SMB file share access from both virtual machines
- Validate that storage access is allowed only from the Private subnet

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
                |   Virtual Network    |
                |      demoVNet1       |
                |     10.0.0.0/16      |
                +----------+-----------+
                           |
        +------------------+------------------+
        |                                     |
+-------+--------+                    +-------+--------+
| Public Subnet  |                    | Private Subnet |
| 10.0.0.0/24    |                    | 10.0.1.0/24    |
| demoNsgPublic1 |                    | demoNsgPrivate1|
+-------+--------+                    +-------+--------+
        |                                     |
+-------+--------+                    +-------+--------+
| demoVMPublic   |                    | demoVM1        |
| Windows Server |                    | Windows Server |
+-------+--------+                    +-------+--------+
        |                                     |
        |                          Service Endpoint
        |                           Microsoft.Storage
        |                                     |
        +-------------------X-----------------+
                            |
                    +-------+--------+
                    | Storage Account|
                    | demoStorage... |
                    +-------+--------+
                            |
                    +-------+--------+
                    | File Share     |
                    | demofileshare1 |
                    +----------------+
```

This architecture shows a segmented Azure network where only the **Private** subnet has a Microsoft.Storage service endpoint and is permitted to access the protected file share.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser session is recommended to avoid Azure portal cache issues.

---

### Step 2 — Create the Virtual Network

Navigate to:

```text
Virtual Networks → Create
```

Configure the virtual network with the following settings:

| Setting | Value |
|---|---|
| Resource Group | rg_eastus_XXXXX |
| Name | demoVNet1 |
| Region | East US |
| IPv4 Address Space | 10.0.0.0/16 |

Edit the default subnet and configure:

| Setting | Value |
|---|---|
| Subnet Name | Public |
| Starting Address | 10.0.0.0/24 |

Save the subnet and create the virtual network.

—
<img width="1206" height="1567" alt="image" src="https://github.com/user-attachments/assets/afa3fa64-bbf1-4c00-a5db-baddd21f878c" />


### Step 3 — Add the Private Subnet and Configure the Storage Service Endpoint

Open the newly created virtual network and navigate to:

```text
Settings → Subnets
```

Add a second subnet with:

| Setting | Value |
|---|---|
| Subnet Name | Private |
| Starting Address | 10.0.1.0/24 |

After the subnet is created, navigate to:

```text
Settings → Service Endpoints
```

Add a new service endpoint with:

| Setting | Value |
|---|---|
| Service | Microsoft.Storage |
| Subnet | Private |

This enables the Private subnet to reach Azure Storage through a service endpoint.

—
<img width="1523" height="619" alt="image" src="https://github.com/user-attachments/assets/c8bb53bd-dfd6-42d1-9404-fe15f3d1277c" />


### Step 4 — Create and Configure the NSG for the Private Subnet

Navigate to:

```text
Network Security Groups → Create
```

Configure the NSG:

| Setting | Value |
|---|---|
| Name | demoNsgPrivate1 |
| Resource Group | rg_eastus_XXXXX |
| Region | East US |

After deployment, add these **outbound** rules:

#### Outbound Rule 1

| Setting | Value |
|---|---|
| Source | Service Tag |
| Source Service Tag | VirtualNetwork |
| Destination | Any |
| Destination Port Ranges | * |
| Protocol | Any |
| Action | Allow |
| Priority | 1000 |
| Name | Allow-Storage-All |

#### Outbound Rule 2

| Setting | Value |
|---|---|
| Source | Service Tag |
| Source Service Tag | VirtualNetwork |
| Destination | Service Tag |
| Destination Service Tag | Internet |
| Destination Port Ranges | * |
| Protocol | Any |
| Action | Deny |
| Priority | 1100 |
| Name | Deny-Internet-All |

Add this **inbound** rule:

| Setting | Value |
|---|---|
| Source | Any |
| Source Port Ranges | * |
| Destination | Service Tag |
| Destination Service Tag | VirtualNetwork |
| Destination Port Ranges | 3389 |
| Protocol | TCP |
| Action | Allow |
| Priority | 1200 |
| Name | Allow-RDP-All |

Associate `demoNsgPrivate1` with the **Private** subnet.

—
<img width="1289" height="972" alt="image" src="https://github.com/user-attachments/assets/de5bf4cd-769c-4eec-a0ed-d45521376ba0" />
<img width="1523" height="889" alt="image" src="https://github.com/user-attachments/assets/f8d0a495-db35-4ce9-a295-d91a182b629d" />
<img width="1523" height="742" alt="image" src="https://github.com/user-attachments/assets/1ba09678-41f4-4427-a7ed-19dd19fe676e" />




### Step 5 — Create and Configure the NSG for the Public Subnet

Create another NSG:

| Setting | Value |
|---|---|
| Name | demoNsgPublic1 |
| Resource Group | rg_eastus_XXXXX |
| Region | East US |

Add this **inbound** rule:

| Setting | Value |
|---|---|
| Source | Any |
| Source Port Ranges | * |
| Destination | Service Tag |
| Destination Service Tag | VirtualNetwork |
| Destination Port Ranges | 3389 |
| Protocol | TCP |
| Action | Allow |
| Priority | 1200 |
| Name | Allow-RDP-All |

Associate `demoNsgPublic1` with the **Public** subnet.

—
<img width="1523" height="514" alt="image" src="https://github.com/user-attachments/assets/0c7714fb-0d58-4d03-8d10-aea58e0a902c" />
<img width="1523" height="445" alt="image" src="https://github.com/user-attachments/assets/aa4554b2-ad87-456e-a972-87049ca736f3" />



### Step 6 — Create the Storage Account and File Share

Navigate to:

```text
Storage Accounts → Create
```

Configure the storage account:

| Setting | Value |
|---|---|
| Resource Group | rg_eastus_XXXXX |
| Storage Account Name | demoStorageacc545 |
| Region | East US |
| Performance | Standard (general-purpose v2) |
| Redundancy | Locally-redundant storage (LRS) |

After deployment, open the storage account and navigate to:

```text
Data Storage → File shares
```

Create a file share:

| Setting | Value |
|---|---|
| Name | demofileshare1 |

After the file share is created, open it and select:

```text
Connect
```

On the **Windows** tab, copy the PowerShell script that maps the share as drive `Z:`. Save that script for later testing.

---

### Step 7 — Restrict Storage Account Network Access

In the storage account, navigate to:

```text
Security + networking → Networking
```

Under public network access, select:

```text
Enabled from selected virtual networks
```

Then add an existing virtual network and choose:

| Setting | Value |
|---|---|
| Virtual Network | demoVNet1 |
| Subnet | Private |

Save the configuration.

This means the storage account now allows network access only from the **Private** subnet.

—
<img width="1523" height="811" alt="image" src="https://github.com/user-attachments/assets/6fd33cdb-f284-435f-85d5-63e5df7f9090" />


### Step 8 — Deploy the Private Subnet Virtual Machine

Create a virtual machine with the following settings:

| Setting | Value |
|---|---|
| Name | demoVM1 |
| Resource Group | rg_eastus_XXXXX |
| Region | East US |
| Image | Windows Server 2025 Datacenter: Azure Edition - Gen2 |
| Size | Standard B2s |
| Public Inbound Ports | None |
| OS Disk Type | Standard HDD |
| Virtual Network | demoVNet1 |
| Subnet | Private (10.0.1.0/24) |
| Public IP | new(demoVM1)-ip |

Create the VM.

---

### Step 9 — Deploy the Public Subnet Virtual Machine

Create a second virtual machine with the following settings:

| Setting | Value |
|---|---|
| Name | demoVMPublic |
| Resource Group | rg_eastus_XXXXX |
| Region | East US |
| Image | Windows Server 2022 Datacenter: Azure Edition - Gen2 |
| Size | Standard B2s |
| Public Inbound Ports | None |
| OS Disk Type | Standard HDD |
| Virtual Network | demoVNet1 |
| Subnet | Public (10.0.0.0/24) |
| Public IP | (new)demoVMPublic-ip |

Create the VM.

---

### Step 10 — Test File Share Access from the Private Subnet

Open `demoVM1` and connect using RDP.

Inside the VM:

1. Open **Windows PowerShell ISE**
2. Paste the previously copied PowerShell file share mapping script
3. Run the script

Expected result:

- The `Z:` drive is created successfully
- The Azure file share is accessible in File Explorer

This confirms that the **Private** subnet can access the storage account.

—
<img width="1523" height="648" alt="image" src="https://github.com/user-attachments/assets/4bf516c9-5785-4db8-9683-07424d10bda7" />
<img width="1523" height="434" alt="image" src="https://github.com/user-attachments/assets/fd0abba0-dd47-4af0-8531-13d1d35b94a4" />



### Step 11 — Test File Share Access from the Public Subnet

Open `demoVMPublic` and connect using RDP.

Inside the VM:

1. Open **Windows PowerShell ISE**
2. Paste the same PowerShell file share mapping script
3. Run the script

Expected result:

- PowerShell returns `New-PSDrive: Access is denied`

This occurs because the **Public** subnet does **not** have a Microsoft.Storage service endpoint and is **not allowed** by the storage account network rules.
<img width="1523" height="558" alt="image" src="https://github.com/user-attachments/assets/639d63b0-f3a3-47b9-9d0c-d92593e7f2dc" />


## Azure CLI (Bash)

Create the virtual network and Public subnet:

```bash
az network vnet create \
  --resource-group rg_eastus_XXXXX \
  --name demoVNet1 \
  --location eastus \
  --address-prefix 10.0.0.0/16 \
  --subnet-name Public \
  --subnet-prefix 10.0.0.0/24
```

Create the Private subnet:

```bash
az network vnet subnet create \
  --resource-group rg_eastus_XXXXX \
  --vnet-name demoVNet1 \
  --name Private \
  --address-prefixes 10.0.1.0/24
```

Enable the Microsoft.Storage service endpoint on the Private subnet:

```bash
az network vnet subnet update \
  --resource-group rg_eastus_XXXXX \
  --vnet-name demoVNet1 \
  --name Private \
  --service-endpoints Microsoft.Storage
```

Create the Private NSG:

```bash
az network nsg create \
  --resource-group rg_eastus_XXXXX \
  --name demoNsgPrivate1 \
  --location eastus
```

Add the allow outbound rule:

```bash
az network nsg rule create \
  --resource-group rg_eastus_XXXXX \
  --nsg-name demoNsgPrivate1 \
  --name Allow-Storage-All \
  --priority 1000 \
  --direction Outbound \
  --source-address-prefixes VirtualNetwork \
  --destination-address-prefixes '*' \
  --destination-port-ranges '*' \
  --protocol '*' \
  --access Allow
```

Add the deny internet outbound rule:

```bash
az network nsg rule create \
  --resource-group rg_eastus_XXXXX \
  --nsg-name demoNsgPrivate1 \
  --name Deny-Internet-All \
  --priority 1100 \
  --direction Outbound \
  --source-address-prefixes VirtualNetwork \
  --destination-address-prefixes Internet \
  --destination-port-ranges '*' \
  --protocol '*' \
  --access Deny
```

Add the RDP inbound rule:

```bash
az network nsg rule create \
  --resource-group rg_eastus_XXXXX \
  --nsg-name demoNsgPrivate1 \
  --name Allow-RDP-All \
  --priority 1200 \
  --direction Inbound \
  --source-address-prefixes '*' \
  --destination-address-prefixes VirtualNetwork \
  --destination-port-ranges 3389 \
  --protocol Tcp \
  --access Allow
```

Associate the NSG with the Private subnet:

```bash
az network vnet subnet update \
  --resource-group rg_eastus_XXXXX \
  --vnet-name demoVNet1 \
  --name Private \
  --network-security-group demoNsgPrivate1
```

Create the Public NSG:

```bash
az network nsg create \
  --resource-group rg_eastus_XXXXX \
  --name demoNsgPublic1 \
  --location eastus
```

Add the RDP inbound rule to the Public NSG:

```bash
az network nsg rule create \
  --resource-group rg_eastus_XXXXX \
  --nsg-name demoNsgPublic1 \
  --name Allow-RDP-All \
  --priority 1200 \
  --direction Inbound \
  --source-address-prefixes '*' \
  --destination-address-prefixes VirtualNetwork \
  --destination-port-ranges 3389 \
  --protocol Tcp \
  --access Allow
```

Associate the NSG with the Public subnet:

```bash
az network vnet subnet update \
  --resource-group rg_eastus_XXXXX \
  --vnet-name demoVNet1 \
  --name Public \
  --network-security-group demoNsgPublic1
```

Create the storage account:

```bash
az storage account create \
  --name demostorageacc545 \
  --resource-group rg_eastus_XXXXX \
  --location eastus \
  --sku Standard_LRS \
  --kind StorageV2
```

Create the file share:

```bash
az storage share-rm create \
  --resource-group rg_eastus_XXXXX \
  --storage-account demostorageacc545 \
  --name demofileshare1 \
  --enabled-protocols SMB
```

Restrict storage network access to the Private subnet:

```bash
az storage account network-rule add \
  --resource-group rg_eastus_XXXXX \
  --account-name demostorageacc545 \
  --vnet-name demoVNet1 \
  --subnet Private
```

Create the Private VM:

```bash
az vm create \
  --resource-group rg_eastus_XXXXX \
  --name demoVM1 \
  --image Win2025Datacenter \
  --size Standard_B2s \
  --vnet-name demoVNet1 \
  --subnet Private \
  --public-ip-address demoVM1-ip \
  --admin-username azureadmin \
  --admin-password 'StrongPassword123!'
```

Create the Public VM:

```bash
az vm create \
  --resource-group rg_eastus_XXXXX \
  --name demoVMPublic \
  --image Win2022Datacenter \
  --size Standard_B2s \
  --vnet-name demoVNet1 \
  --subnet Public \
  --public-ip-address demoVMPublic-ip \
  --admin-username azureadmin \
  --admin-password 'StrongPassword123!'
```

## Azure PowerShell

Create the virtual network and subnets:

```powershell
$publicSubnet = New-AzVirtualNetworkSubnetConfig `
  -Name "Public" `
  -AddressPrefix "10.0.0.0/24"

$privateSubnet = New-AzVirtualNetworkSubnetConfig `
  -Name "Private" `
  -AddressPrefix "10.0.1.0/24"

New-AzVirtualNetwork `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "demoVNet1" `
  -Location "East US" `
  -AddressPrefix "10.0.0.0/16" `
  -Subnet $publicSubnet, $privateSubnet
```

Enable the Microsoft.Storage service endpoint on the Private subnet:

```powershell
$vnet = Get-AzVirtualNetwork -ResourceGroupName "rg_eastus_XXXXX" -Name "demoVNet1"
Set-AzVirtualNetworkSubnetConfig `
  -VirtualNetwork $vnet `
  -Name "Private" `
  -AddressPrefix "10.0.1.0/24" `
  -ServiceEndpoint "Microsoft.Storage"
$vnet | Set-AzVirtualNetwork
```

Create the Private NSG:

```powershell
New-AzNetworkSecurityGroup `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "demoNsgPrivate1" `
  -Location "East US"
```

Create the Public NSG:

```powershell
New-AzNetworkSecurityGroup `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "demoNsgPublic1" `
  -Location "East US"
```

Create the storage account:

```powershell
New-AzStorageAccount `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "demostorageacc545" `
  -Location "East US" `
  -SkuName "Standard_LRS" `
  -Kind "StorageV2"
```

Create the file share:

```powershell
$ctx = (Get-AzStorageAccount `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "demostorageacc545").Context

New-AzStorageShare `
  -Name "demofileshare1" `
  -Context $ctx
```

Create the Private VM:

```powershell
New-AzVM `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "demoVM1" `
  -Location "East US" `
  -Image "Win2025Datacenter" `
  -Size "Standard_B2s" `
  -Credential (Get-Credential)
```

Create the Public VM:

```powershell
New-AzVM `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "demoVMPublic" `
  -Location "East US" `
  -Image "Win2022Datacenter" `
  -Size "Standard_B2s" `
  -Credential (Get-Credential)
```

## Implementation Walkthrough

The lab began by building a virtual network named `demoVNet1` with two distinct subnets: `Public` and `Private`. This subnet separation created the foundation for network segmentation. After the virtual network was created, the **Private** subnet was enhanced with a **Microsoft.Storage service endpoint**, allowing resources in that subnet to reach Azure Storage through an Azure backbone-integrated path. :contentReference[oaicite:1]{index=1}

Two network security groups were then created to control traffic for each subnet. The NSG for the **Private** subnet allowed internal outbound traffic but explicitly denied outbound internet access, while still allowing inbound RDP from within the virtual network. The NSG for the **Public** subnet was configured primarily to allow RDP. This demonstrated how subnet-level NSGs can enforce different traffic policies based on workload role. :contentReference[oaicite:2]{index=2}

Next, a storage account and SMB file share were created. The storage account network settings were changed from broad public access to **Enabled from selected virtual networks**, and only the **Private** subnet was added as an allowed network path. This was the key access control point that enforced storage connectivity boundaries. Two virtual machines were then deployed—`demoVM1` in the **Private** subnet and `demoVMPublic` in the **Public** subnet. Running the same PowerShell drive-mapping script on both machines produced different results: the Private subnet VM successfully mapped the share as `Z:`, while the Public subnet VM received an **Access is denied** error. This validated that storage account access was controlled by the combination of subnet selection, service endpoints, and storage firewall rules. :contentReference[oaicite:3]{index=3}

## Results & Validation

| Test | Result |
|---|---|
| Virtual network creation | Successful |
| Public subnet creation | Successful |
| Private subnet creation | Successful |
| Microsoft.Storage service endpoint on Private subnet | Successful |
| Private subnet NSG deployment | Successful |
| Public subnet NSG deployment | Successful |
| Storage account creation | Successful |
| File share creation | Successful |
| Storage firewall restriction to Private subnet | Successful |
| Private subnet VM deployment | Successful |
| Public subnet VM deployment | Successful |
| File share mapping from Private subnet VM | Successful |
| File share mapping from Public subnet VM | Access denied as expected |

Key observations:

- The **Private** subnet could reach the storage account because it had the Microsoft.Storage service endpoint and was explicitly allowed in storage networking
- The **Public** subnet could not map the file share because it was not allowed by the storage account network rules
- NSGs supported the subnet design by controlling RDP and outbound behavior
- Azure service endpoints helped extend secure storage access into the approved subnet

## Validation Walkthrough

1. Verified that `demoVNet1` was created with the address space `10.0.0.0/16`.
2. Confirmed that the `Public` subnet used `10.0.0.0/24`.
3. Confirmed that the `Private` subnet used `10.0.1.0/24`.
4. Verified that a **Microsoft.Storage** service endpoint was enabled only on the `Private` subnet.
5. Confirmed that `demoNsgPrivate1` and `demoNsgPublic1` were created and associated with the correct subnets.
6. Verified that `demoStorageacc545` and the file share `demofileshare1` were created successfully.
7. Copied the PowerShell script for mapping the file share as drive `Z:`.
8. Confirmed that the storage account networking was set to **Enabled from selected virtual networks**.
9. Verified that only the `Private` subnet was added to the allowed network list.
10. Connected to `demoVM1` through RDP and ran the mapping script.
11. Confirmed that the `Z:` drive was created successfully in File Explorer.
12. Connected to `demoVMPublic` through RDP and ran the same mapping script.
13. Confirmed that PowerShell returned `New-PSDrive: Access is denied`.
14. Verified that the different results were caused by subnet-specific storage access controls.

## Real-World Use Case

This pattern is common when organizations want to allow access to storage only from controlled internal application subnets.

Example: **Private Application Tier Access to Azure Storage**

| Component | Role |
|---|---|
| Private subnet | Hosts approved internal workloads |
| Service endpoint | Extends secure access path to Azure Storage |
| Storage account firewall | Restricts allowed network sources |
| Public subnet | Hosts less trusted or externally oriented systems |
| File share | Shared storage used by internal workloads |

Typical workflow:

```text
Internal VM in Private Subnet
            ↓
Uses Microsoft.Storage Service Endpoint
            ↓
Storage Firewall Evaluates Allowed Subnet
            ↓
Access Granted to File Share

Public Subnet VM
            ↓
No Allowed Storage Path
            ↓
Storage Firewall Denies Access
```

This design is useful for internal application tiers, controlled file share access, segmented environments, and scenarios where only selected subnets should reach protected storage services.

## Key Takeaways

This lab demonstrated several important Azure networking and storage security concepts:

- Azure virtual networks can be segmented with Public and Private subnets for different trust levels
- Service endpoints allow approved subnets to connect securely to Azure platform services such as Storage
- Network security groups provide traffic control at the subnet level
- Storage account network restrictions can limit access to selected virtual networks and subnets
- The same file share mapping script produced different outcomes based on subnet and network policy
- This architecture reflects a practical Azure security design for controlled storage access

Understanding Azure service endpoints, subnet segmentation, NSGs, and storage firewall rules is valuable for cloud administrators, network engineers, and infrastructure teams designing secure Azure environments.

