# Azure DNS Zone and Alias Record for Virtual Machine Public IP

## Introduction

Azure DNS is a scalable, reliable, and globally distributed DNS hosting service that allows administrators to manage DNS records using Azure infrastructure. A **DNS zone** acts as the administrative container for DNS records associated with a domain, while **alias records** allow those records to reference Azure resources directly.

In this lab, a virtual network and subnet were created, a Windows virtual machine was deployed with a dynamic public IP, IIS was installed on the VM, and an Azure DNS zone was created. An **alias A record** was then configured to point to the VM’s Azure public IP resource, allowing name resolution through the DNS zone instead of relying only on the raw IP address.

This lab demonstrates how Azure DNS alias records simplify DNS management by dynamically referencing Azure resources.

## Objectives

The objectives of this lab were to:

- Create an Azure Virtual Network and subnet
- Deploy a Windows virtual machine with a public IP
- Install IIS on the virtual machine
- Create an Azure DNS zone
- Create an alias A record in the DNS zone
- Map the alias record to the VM public IP resource
- Validate that the web server is reachable through the assigned public IP

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
        +------------------+------------------+
        |                                     |
+-------+--------+                    +-------+--------+
| Virtual Network|                    |   Azure DNS    |
|   demoVNet1    |                    |  XXXXXXDNS.com |
| 10.10.0.0/16   |                    +-------+--------+
+-------+--------+                            |
        |                                     |
+-------+--------+                    +-------+--------+
|   WebSubnet    |                    | Alias A Record |
| 10.10.0.0/24   |                    |  -> Public IP  |
+-------+--------+                    +-------+--------+
        |                                     |
+-------+--------+                            |
| Windows VM     |----------------------------+
| IIS Installed  |
| Dynamic Public |
| IP Attached    |
+-------+--------+
        |
   HTTP / HTTPS
        |
    Web Browser
```

This architecture shows a Windows virtual machine hosted in Azure, a DNS zone created in Azure DNS, and an alias A record referencing the VM’s Azure public IP resource.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser session is recommended to avoid Azure portal cache issues.

---

### Step 2 — Create a Virtual Network and Subnet

Navigate to:

```text
Virtual Networks → Create
```

Configure the virtual network:

| Setting | Value |
|---|---|
| Virtual Network Name | demoVNet1 |
| Region | East US |
| Address Space | 10.10.0.0/16 |

Create the subnet with:

| Setting | Value |
|---|---|
| Subnet Name | WebSubnet |
| Subnet Address Range | 10.10.0.0/24 |

Review and create the virtual network.

—
<img width="1355" height="1639" alt="image" src="https://github.com/user-attachments/assets/19e20bf4-826f-43a0-898b-83fd1a1c8133" />


### Step 3 — Create the Virtual Machine

Navigate to:

```text
Virtual Machines → Create
```

Configure the virtual machine with the following settings:

| Setting | Value |
|---|---|
| Virtual Machine Name | Unique name |
| Region | East US |
| Availability Option | No infrastructure redundancy required |
| Security Type | Standard |
| Image | Windows Server 2025 Datacenter: Azure Edition - x64 Gen2 |
| Size | B2s |
| Public Inbound Ports | None on basics page |

Under **Disks**:

| Setting | Value |
|---|---|
| OS Disk Type | Standard SSD |

Under **Networking**:

| Setting | Value |
|---|---|
| Virtual Network | demoVNet1 |
| Subnet | WebSubnet |
| Public IP | Default public IP |
| NIC Network Security Group | Basic |
| Public Inbound Ports | Allow selected ports |
| Inbound Ports | HTTP (80), HTTPS (443), RDP (3389) |

Review and create the virtual machine.

—
<img width="1523" height="1881" alt="image" src="https://github.com/user-attachments/assets/046fbbf9-e2c8-4bca-a343-d0ebab540d0e" />


### Step 4 — Install IIS on the Virtual Machine

After deployment, open the VM resource and connect using RDP.

Inside the VM:

1. Open **Server Manager**
2. Select **Manage → Add Roles and Features**
3. Add the **Web Server (IIS)** role
4. Complete the installation wizard

After IIS is installed, open a browser inside the VM and navigate to:

```text
http://localhost/
```

Expected result:

- The default IIS page loads successfully

This confirms the VM is serving web traffic locally.

—
<img width="1523" height="747" alt="image" src="https://github.com/user-attachments/assets/b95d4001-1aee-425c-883b-196d170d49a7" />


### Step 5 — Create a DNS Zone

Navigate to:

```text
DNS Zones → Create
```

Configure the DNS zone:

| Setting | Value |
|---|---|
| Name | XXXXXXDNS.com |
| Resource Location | East US |

Create the DNS zone.

—
<img width="1358" height="998" alt="image" src="https://github.com/user-attachments/assets/37ade3b2-a50e-4ee2-87c0-6fc5620c054a" />


### Step 6 — Create an Alias Record

Open the DNS zone and navigate to:

```text
Record sets → + Add
```

Configure the record:

| Setting | Value |
|---|---|
| Type | A |
| Alias Record Set | Yes |
| Alias Type | Azure resource |
| Azure Resource | Public IP address resource |

Add the record.

This alias record references the Azure public IP resource directly instead of using a static IP value.

—
<img width="1523" height="723" alt="image" src="https://github.com/user-attachments/assets/8bc730e7-666b-4db4-9fe9-a38f8d43fd10" />


### Step 7 — Test the Alias Record Setup

Open the virtual machine overview page and copy the **public IP address**.

Paste the IP address into a browser.

Expected result:

- The IIS default page loads successfully

This confirms the VM is reachable over HTTP and the public IP resource is functioning correctly.

### Azure CLI (Bash)

Create the virtual network:

```bash
az network vnet create \
  --resource-group rg_eastus_XXXXX \
  --name demoVNet1 \
  --location eastus \
  --address-prefix 10.10.0.0/16 \
  --subnet-name WebSubnet \
  --subnet-prefix 10.10.0.0/24
```

Create the virtual machine:

```bash
az vm create \
  --resource-group rg_eastus_XXXXX \
  --name demoVM1 \
  --image Win2025Datacenter \
  --size Standard_B2s \
  --admin-username azureadmin \
  --admin-password 'StrongPassword123!' \
  --vnet-name demoVNet1 \
  --subnet WebSubnet
```

Open required inbound ports:

```bash
az vm open-port \
  --resource-group rg_eastus_XXXXX \
  --name demoVM1 \
  --port 80

az vm open-port \
  --resource-group rg_eastus_XXXXX \
  --name demoVM1 \
  --port 443

az vm open-port \
  --resource-group rg_eastus_XXXXX \
  --name demoVM1 \
  --port 3389
```

Create the DNS zone:

```bash
az network dns zone create \
  --resource-group rg_eastus_XXXXX \
  --name xxxxxxdns.com
```

Create an alias A record set:

```bash
az network dns record-set a create \
  --resource-group rg_eastus_XXXXX \
  --zone-name xxxxxxdns.com \
  --name www
```

Show the VM public IP:

```bash
az vm show \
  --resource-group rg_eastus_XXXXX \
  --name demoVM1 \
  --show-details \
  --query publicIps \
  --output tsv
```

### Azure PowerShell

Create the subnet and virtual network:

```powershell
$subnet = New-AzVirtualNetworkSubnetConfig `
  -Name "WebSubnet" `
  -AddressPrefix "10.10.0.0/24"

New-AzVirtualNetwork `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "demoVNet1" `
  -Location "East US" `
  -AddressPrefix "10.10.0.0/16" `
  -Subnet $subnet
```

Create the virtual machine:

```powershell
New-AzVM `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "demoVM1" `
  -Location "East US" `
  -Image "Win2025Datacenter" `
  -Size "Standard_B2s" `
  -Credential (Get-Credential)
```

Create the DNS zone:

```powershell
New-AzDnsZone `
  -Name "xxxxxxdns.com" `
  -ResourceGroupName "rg_eastus_XXXXX"
```

Create an A record set:

```powershell
New-AzDnsRecordSet `
  -Name "www" `
  -RecordType A `
  -ZoneName "xxxxxxdns.com" `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Ttl 3600
```

Get the VM public IP:

```powershell
Get-AzPublicIpAddress `
  -ResourceGroupName "rg_eastus_XXXXX"
```

## Implementation Walkthrough

The lab began by creating a virtual network named `demoVNet1` with the address space `10.10.0.0/16`, followed by a subnet named `WebSubnet` using `10.10.0.0/24`. This provided the network foundation required to host the virtual machine. A Windows Server 2025 VM was then deployed into that subnet with a basic dynamic public IP and inbound rules for HTTP, HTTPS, and RDP.

After the virtual machine was available, IIS was installed through Server Manager. The local web test using `http://localhost/` confirmed that the web server role was active and serving the default IIS page. This validated the workload before introducing DNS.

Next, an Azure DNS zone was created and an alias A record was added. Instead of manually entering an IP value, the alias record referenced the Azure public IP resource associated with the VM. This design improves manageability because Azure alias records can follow the referenced resource dynamically. Finally, the public IP was tested in a browser, confirming the IIS web page was reachable.

## Results & Validation

| Test | Result |
|---|---|
| Virtual network creation | Successful |
| Subnet creation | Successful |
| Virtual machine deployment | Successful |
| IIS installation | Successful |
| DNS zone creation | Successful |
| Alias A record creation | Successful |
| Public IP browser access | Successful |

Key observations:

- Azure DNS zones provide centralized DNS management inside Azure
- Alias records simplify DNS mapping to Azure resources
- The virtual machine successfully hosted the IIS default website
- The public IP resource could be used as the target for DNS-related testing

## Validation Walkthrough

1. Verified that `demoVNet1` and `WebSubnet` were created successfully.
2. Confirmed the Windows virtual machine was deployed in the correct subnet.
3. Verified that inbound rules allowed HTTP, HTTPS, and RDP traffic.
4. Connected to the VM using RDP.
5. Installed the Web Server (IIS) role successfully.
6. Opened `http://localhost/` inside the VM and confirmed the IIS default page loaded.
7. Created the Azure DNS zone successfully.
8. Added an alias A record in the DNS zone that referenced the VM public IP resource.
9. Copied the VM public IP from the overview page.
10. Opened the public IP in a browser and confirmed the IIS page loaded successfully.

## Real-World Use Case

Azure DNS alias records are useful when organizations want DNS records to reference Azure resources directly instead of manually tracking IP changes.

Example: **Public Web Server with Azure DNS**

| Component | Role |
|---|---|
| Azure DNS Zone | Hosts domain records |
| Alias A Record | Points to Azure public IP resource |
| Public IP Resource | Internet-facing endpoint |
| Windows VM with IIS | Web server workload |

Typical workflow:

```text
User enters domain name
          ↓
Azure DNS resolves alias record
          ↓
Alias references Azure public IP resource
          ↓
Traffic reaches VM web server
          ↓
IIS returns website content
```

This pattern is useful for simple web hosting scenarios, proof-of-concept environments, and Azure-based DNS management workflows.

## Key Takeaways

This lab demonstrated several important Azure networking and DNS concepts:

- Azure DNS zones provide managed DNS hosting inside Azure
- Alias records allow DNS records to reference Azure resources directly
- Virtual networks and subnets define the network boundary for virtual machines
- IIS installation provides a simple workload to validate connectivity
- DNS and public IP integration improves resource addressing and manageability

Understanding Azure DNS zones and alias records is useful for cloud administrators, Azure engineers, and infrastructure teams responsible for domain resolution and resource mapping in Azure.

