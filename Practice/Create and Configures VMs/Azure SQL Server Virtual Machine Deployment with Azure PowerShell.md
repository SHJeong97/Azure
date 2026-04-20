# Azure SQL Server Virtual Machine Deployment with Azure PowerShell

## Introduction

Azure Virtual Machines allow administrators to deploy full infrastructure workloads in the cloud, including operating systems, networking, storage, and application platforms such as Microsoft SQL Server. This makes Azure VMs useful when organizations need database workloads with operating system-level access and configuration control.

In this lab, Azure PowerShell in Cloud Shell was used to build the full infrastructure required for a SQL Server virtual machine. A virtual network, subnet, public IP, network security group, and network interface were created first. Then a Windows virtual machine image with **SQL Server 2022 Developer Edition on Windows Server 2022** was deployed. Finally, the VM was accessed over RDP and SQL Server Management Studio (SSMS) was opened to verify that SQL Server was installed and operational.

## Objectives

The objectives of this lab were to:

- Open Azure Cloud Shell in PowerShell mode
- Define reusable deployment variables
- Create a virtual network and subnet
- Allocate a static public IP address
- Create a network security group with RDP and SQL Server rules
- Create a network interface for the VM
- Deploy a Windows virtual machine with SQL Server 2022
- Connect to the VM using RDP
- Verify SQL Server installation using SQL Server Management Studio

## Architecture Diagram

```text
                +----------------------+
                |   Azure Subscription |
                |       PAYG-LA        |
                +----------+-----------+
                           |
                +----------+-----------+
                |       Resource Group |
                |   <lab resource group> |
                +----------+-----------+
                           |
                +----------+-----------+
                |   Virtual Network    |
                |       myVnet         |
                |     10.0.0.0/16      |
                +----------+-----------+
                           |
                    +------+------+
                    |   mySubnet   |
                    | 10.0.0.0/24  |
                    +------+------+
                           |
                    +------+------+
                    |     NIC      |
                    |    myNIC     |
                    +------+------+
                           |
          +----------------+----------------+
          |                                 |
+---------+---------+             +---------+---------+
| Public IP         |             | Network Security  |
| myPublicIP        |             | Group             |
| Static            |             | myNetworkSecurity |
+---------+---------+             | Group             |
                                  +---------+---------+
                                            |
                             +--------------+--------------+
                             |                             |
                    +--------+--------+           +--------+--------+
                    | Allow-RDP       |           | Allow-SQL       |
                    | TCP 3389        |           | TCP 1433        |
                    +-----------------+           +-----------------+
                                            |
                                    +-------+-------+
                                    |   SQL VM      |
                                    |   mySqlVM     |
                                    | Windows +     |
                                    | SQL 2022 Dev  |
                                    +-------+-------+
                                            |
                                   RDP / SSMS Validation
```

This architecture shows the Azure networking components created with PowerShell and the SQL Server VM attached to them, with inbound access enabled for both RDP and SQL Server.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser session is recommended to avoid Azure portal cache issues.

---

### Step 2 — Configure Deployment Variables

Open **Cloud Shell** in the Azure Portal and choose:

```text
PowerShell
```

On the startup pane, select:

```text
No Storage Account required
```

Choose the **PAYG-LA** subscription and select **Apply**.

Then define the core variables:

```powershell
$resourceGroupName = "<Your-Resource-Group>"
$location = "EastUS"
```

These variables are reused throughout the deployment and reduce repeated manual input.

---

### Step 3 — Create the Virtual Network and Subnet

Define and create the virtual network:

```powershell
$virtualNetworkName = "myVnet"
$subnetName = "mySubnet"

$vnet = New-AzVirtualNetwork `
  -ResourceGroupName $resourceGroupName `
  -Location $location `
  -Name $virtualNetworkName `
  -AddressPrefix "10.0.0.0/16"

$subnet = Add-AzVirtualNetworkSubnetConfig `
  -Name $subnetName `
  -AddressPrefix "10.0.0.0/24" `
  -VirtualNetwork $vnet

$subnetId = ($vnet.Subnets | Where-Object { $_.Name -eq $subnetName }).Id

$vnet | Set-AzVirtualNetwork
```

This creates:

- A virtual network named `myVnet`
- A subnet named `mySubnet`
- Address space `10.0.0.0/16`
- Subnet range `10.0.0.0/24`

—
<img width="1523" height="327" alt="image" src="https://github.com/user-attachments/assets/e03b1cfd-1527-4549-b071-fec2233fcdef" />


### Step 4 — Create the Public IP Address

Create a static public IP for VM accessibility:

```powershell
$publicIpName = "myPublicIP"

$publicIp = New-AzPublicIpAddress `
  -ResourceGroupName $resourceGroupName `
  -Location $location `
  -Name $publicIpName `
  -AllocationMethod Static
```

This public IP will later be associated with the VM NIC.

—
<img width="1523" height="111" alt="image" src="https://github.com/user-attachments/assets/b6370567-1e00-492d-a649-f3f3a4963a95" />


### Step 5 — Create the Network Security Group and Rules

Create the NSG:

```powershell
$nsgName = "myNetworkSecurityGroup"

$nsg = New-AzNetworkSecurityGroup `
  -ResourceGroupName $resourceGroupName `
  -Location $location `
  -Name $nsgName
```

Create the RDP rule:

```powershell
$nsgRuleRdp = New-AzNetworkSecurityRuleConfig `
  -Name "Allow-RDP" `
  -Protocol Tcp `
  -Direction Inbound `
  -Priority 1000 `
  -SourceAddressPrefix * `
  -SourcePortRange * `
  -DestinationAddressPrefix * `
  -DestinationPortRange 3389 `
  -Access Allow
```

Create the SQL Server rule:

```powershell
$nsgRuleSql = New-AzNetworkSecurityRuleConfig `
  -Name "Allow-SQL" `
  -Protocol Tcp `
  -Direction Inbound `
  -Priority 1001 `
  -SourceAddressPrefix * `
  -SourcePortRange * `
  -DestinationAddressPrefix * `
  -DestinationPortRange 1433 `
  -Access Allow
```

Add both rules and apply the NSG:

```powershell
$nsg.SecurityRules.Add($nsgRuleRdp)
$nsg.SecurityRules.Add($nsgRuleSql)

Set-AzNetworkSecurityGroup -NetworkSecurityGroup $nsg
```

This NSG allows:

- RDP on TCP 3389
- SQL Server access on TCP 1433

—
<img width="1523" height="652" alt="image" src="https://github.com/user-attachments/assets/5736cda2-8794-4a66-b06a-89a39255a9db" />


### Step 6 — Create the Network Interface

Create the NIC and associate it with the subnet, public IP, and NSG:

```powershell
$nicName = "myNIC"

$subnet = Get-AzVirtualNetwork `
  -ResourceGroupName $resourceGroupName `
  -Name $virtualNetworkName | Get-AzVirtualNetworkSubnetConfig -Name $subnetName

$subnetId = $subnet.Id

$nic = New-AzNetworkInterface `
  -Name $nicName `
  -ResourceGroupName $resourceGroupName `
  -Location $location `
  -SubnetId $subnetId `
  -PublicIpAddressId $publicIp.Id `
  -NetworkSecurityGroupId $nsg.Id
```

This prepares the VM networking stack before compute deployment.

—
<img width="1523" height="213" alt="image" src="https://github.com/user-attachments/assets/8584d993-9cab-44bb-af39-3a799ba2d6f5" />


### Step 7 — Deploy the SQL Server Virtual Machine

Define the VM variables:

```powershell
$vmName = "mySqlVM"
$vmSize = "Standard_B2ms"
$osDiskType = "StandardSSD_LRS"
$adminUsername = "<your-username>"
$adminPassword = ConvertTo-SecureString "<YourStrongPassword123!>" -AsPlainText -Force
```

Build the VM configuration:

```powershell
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize $vmSize

$vmConfig = Set-AzVMOperatingSystem `
  -VM $vmConfig `
  -Windows `
  -ComputerName $vmName `
  -Credential (New-Object System.Management.Automation.PSCredential ($adminUsername, $adminPassword))

$vmConfig = Set-AzVMSourceImage `
  -VM $vmConfig `
  -PublisherName "MicrosoftSQLServer" `
  -Offer "sql2022-ws2022" `
  -Skus "SQLDEV-GEN2" `
  -Version "latest"

$vmConfig = Set-AzVMBootDiagnostic -VM $vmConfig -Disable

$vmConfig = Add-AzVMNetworkInterface -VM $vmConfig -Id $nic.Id

$vmConfig = Set-AzVMOSDisk `
  -VM $vmConfig `
  -Name "${vmName}_OSDisk" `
  -StorageAccountType $osDiskType `
  -CreateOption FromImage
```

Deploy the VM:

```powershell
New-AzVM `
  -ResourceGroupName $resourceGroupName `
  -Location $location `
  -VM $vmConfig
```

This deploys a Windows Server VM with SQL Server 2022 Developer Edition preinstalled.

—
<img width="1523" height="639" alt="image" src="https://github.com/user-attachments/assets/e8f20a51-6a3d-4cba-ac84-6c5df5d61d1e" />


### Step 8 — Connect to the Virtual Machine

In Azure Portal:

1. Open the resource group
2. Select the VM named `mySqlVM`
3. Choose:

```text
Connect → Connect
```

4. Select:

```text
Download RDP File
```

5. Open the RDP file
6. Select **Connect**
7. Enter the username and password created earlier
8. Accept the certificate warning if prompted

After authentication completes, the Windows desktop loads.

---

### Step 9 — Verify SQL Server with SQL Server Management Studio

Inside the RDP session:

1. Open the **Start** menu
2. Search for:

```text
SQL Server Management Studio
```

This confirms that SQL Server tooling is installed on the VM.

Open SQL Server Management Studio.

In the **Connect to Server** dialog, use:

| Setting | Value |
|---|---|
| Server type | Database Engine |
| Server name | VM name (pre-filled) |
| Authentication | Windows Authentication |
| Trust server certificate | Enabled |

Select:

```text
Connect
```

Expected result:

- SSMS opens successfully
- The VM connects to its local SQL Server instance

This confirms that SQL Server was installed and is operational on the Azure VM.

## Azure CLI (Bash)

Create the virtual network:

```bash
az network vnet create \
  --resource-group rg_eastus_XXXXX \
  --name myVnet \
  --location eastus \
  --address-prefix 10.0.0.0/16 \
  --subnet-name mySubnet \
  --subnet-prefix 10.0.0.0/24
```

Create the static public IP:

```bash
az network public-ip create \
  --resource-group rg_eastus_XXXXX \
  --name myPublicIP \
  --location eastus \
  --allocation-method Static
```

Create the NSG:

```bash
az network nsg create \
  --resource-group rg_eastus_XXXXX \
  --name myNetworkSecurityGroup \
  --location eastus
```

Create the RDP rule:

```bash
az network nsg rule create \
  --resource-group rg_eastus_XXXXX \
  --nsg-name myNetworkSecurityGroup \
  --name Allow-RDP \
  --priority 1000 \
  --direction Inbound \
  --protocol Tcp \
  --destination-port-ranges 3389 \
  --access Allow
```

Create the SQL rule:

```bash
az network nsg rule create \
  --resource-group rg_eastus_XXXXX \
  --nsg-name myNetworkSecurityGroup \
  --name Allow-SQL \
  --priority 1001 \
  --direction Inbound \
  --protocol Tcp \
  --destination-port-ranges 1433 \
  --access Allow
```

Create the NIC:

```bash
az network nic create \
  --resource-group rg_eastus_XXXXX \
  --name myNIC \
  --vnet-name myVnet \
  --subnet mySubnet \
  --network-security-group myNetworkSecurityGroup \
  --public-ip-address myPublicIP
```

Create the SQL VM:

```bash
az vm create \
  --resource-group rg_eastus_XXXXX \
  --name mySqlVM \
  --nics myNIC \
  --image MicrosoftSQLServer:sql2022-ws2022:SQLDEV-GEN2:latest \
  --size Standard_B2ms \
  --admin-username azureadmin \
  --admin-password 'YourStrongPassword123!' \
  --storage-sku StandardSSD_LRS
```

## Azure PowerShell

Create the virtual network:

```powershell
$virtualNetworkName = "myVnet"
$subnetName = "mySubnet"

$vnet = New-AzVirtualNetwork `
  -ResourceGroupName $resourceGroupName `
  -Location $location `
  -Name $virtualNetworkName `
  -AddressPrefix "10.0.0.0/16"

$subnet = Add-AzVirtualNetworkSubnetConfig `
  -Name $subnetName `
  -AddressPrefix "10.0.0.0/24" `
  -VirtualNetwork $vnet

$vnet | Set-AzVirtualNetwork
```

Create the public IP:

```powershell
$publicIp = New-AzPublicIpAddress `
  -ResourceGroupName $resourceGroupName `
  -Location $location `
  -Name "myPublicIP" `
  -AllocationMethod Static
```

Create the NSG and rules:

```powershell
$nsg = New-AzNetworkSecurityGroup `
  -ResourceGroupName $resourceGroupName `
  -Location $location `
  -Name "myNetworkSecurityGroup"
```

Create the NIC:

```powershell
$nic = New-AzNetworkInterface `
  -Name "myNIC" `
  -ResourceGroupName $resourceGroupName `
  -Location $location `
  -SubnetId $subnet.Id `
  -PublicIpAddressId $publicIp.Id `
  -NetworkSecurityGroupId $nsg.Id
```

Create the SQL VM:

```powershell
New-AzVM `
  -ResourceGroupName $resourceGroupName `
  -Location $location `
  -VM $vmConfig
```

## Implementation Walkthrough

The lab began by opening Azure Cloud Shell in **PowerShell** mode and defining reusable variables for the resource group and region. This simplified the later commands and created a more consistent deployment workflow. From there, the network foundation was built first: a virtual network named `myVnet`, a subnet named `mySubnet`, a static public IP, and a network security group named `myNetworkSecurityGroup`. The NSG included inbound rules for both **RDP (3389)** and **SQL Server (1433)**, which prepared the environment for both administrative access and database connectivity. :contentReference[oaicite:1]{index=1}

Next, a network interface named `myNIC` was created and associated with the subnet, the public IP, and the NSG. Only after the networking components were in place was the compute layer deployed. The virtual machine configuration used the Azure Marketplace image `MicrosoftSQLServer:sql2022-ws2022:SQLDEV-GEN2:latest`, which provisioned a Windows Server 2022 VM with SQL Server 2022 Developer Edition already installed. Boot diagnostics were disabled, the OS disk type was set to **StandardSSD_LRS**, and the VM size was defined as **Standard_B2ms**. :contentReference[oaicite:2]{index=2}

After deployment, the VM was accessed via RDP from the Azure Portal. Once inside the Windows session, **SQL Server Management Studio** was found in the Start menu and opened. The connection dialog was prefilled with the VM name, and **Windows Authentication** was used to connect to the local SQL Server instance. This final step confirmed that the SQL Server VM image was deployed correctly and that SQL Server was available for use on the VM. :contentReference[oaicite:3]{index=3}

## Results & Validation

| Test | Result |
|---|---|
| Cloud Shell PowerShell setup | Successful |
| Virtual network and subnet creation | Successful |
| Static public IP creation | Successful |
| Network security group creation | Successful |
| RDP rule creation | Successful |
| SQL rule creation | Successful |
| Network interface creation | Successful |
| SQL Server VM deployment | Successful |
| RDP access to VM | Successful |
| SQL Server Management Studio launch | Successful |
| SQL Server instance connection | Successful |

Key observations:

- Azure PowerShell can deploy the full network and compute stack for a SQL Server VM
- NSG rules were required to allow both RDP and SQL connectivity
- Using a SQL Server Marketplace image simplified deployment because SQL Server was preinstalled
- SSMS presence on the VM confirmed that the SQL image deployment completed correctly
- Windows Authentication allowed direct local validation of the SQL instance

## Validation Walkthrough

1. Verified that Azure Cloud Shell opened successfully in **PowerShell** mode.
2. Defined the `$resourceGroupName` and `$location` variables.
3. Ran the virtual network and subnet commands and confirmed `myVnet` and `mySubnet` were created.
4. Created the static public IP `myPublicIP`.
5. Created the NSG `myNetworkSecurityGroup`.
6. Added the `Allow-RDP` rule for TCP 3389.
7. Added the `Allow-SQL` rule for TCP 1433.
8. Created the NIC `myNIC` and verified it was attached to the subnet, public IP, and NSG.
9. Built the VM configuration using the SQL Server 2022 on Windows Server 2022 image.
10. Ran `New-AzVM` and confirmed that `mySqlVM` deployed successfully.
11. Downloaded the RDP file and connected to the VM using the administrator credentials.
12. Opened the Start menu and confirmed that **SQL Server Management Studio** was installed.
13. Launched SSMS and connected to the local SQL Server instance using **Windows Authentication**.
14. Confirmed that the SQL Server instance opened successfully inside SSMS.

## Real-World Use Case

This deployment pattern is useful when organizations need a full SQL Server environment with operating system access instead of a fully managed platform service.

Example: **Development or Test SQL Server in Azure VM**

| Component | Role |
|---|---|
| Virtual Network | Provides network boundary |
| NSG | Controls administrative and SQL access |
| Public IP | Enables remote access |
| SQL VM | Hosts Windows Server and SQL Server |
| SSMS | Used for database administration and validation |

Typical workflow:

```text
Build Network Infrastructure
          ↓
Create SQL Server VM Image
          ↓
Allow RDP and SQL Traffic
          ↓
Connect to VM by RDP
          ↓
Open SSMS and Validate Database Engine
```

This pattern is useful for development labs, training environments, lift-and-shift SQL workloads, and scenarios where administrators need deeper OS-level control than Azure SQL Database provides.

## Key Takeaways

This lab demonstrated several important Azure infrastructure concepts:

- Azure PowerShell can build a full network and SQL VM deployment workflow
- Virtual networks, public IPs, NICs, and NSGs must be configured before VM deployment
- NSG rules are essential for allowing administrative and database traffic
- Azure Marketplace SQL Server images reduce setup time by preinstalling SQL Server
- SQL Server Management Studio is a practical validation tool after deployment

Understanding SQL Server VM deployment in Azure is valuable for cloud administrators, infrastructure engineers, and database teams responsible for Windows-based database workloads in Azure.

