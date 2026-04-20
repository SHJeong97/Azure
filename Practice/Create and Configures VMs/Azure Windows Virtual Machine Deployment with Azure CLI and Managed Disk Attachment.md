# Azure Windows Virtual Machine Deployment with Azure CLI and Managed Disk Attachment

## Introduction

Azure Virtual Machines provide flexible Infrastructure as a Service (IaaS) compute resources that allow administrators to deploy operating systems, attach storage, and manage workloads without maintaining physical hardware. Azure CLI makes this process faster and more repeatable by allowing infrastructure to be created from commands instead of only through the portal.

In this lab, a Windows Server virtual machine was created using **Azure CLI** in Cloud Shell. After the VM was deployed, a new managed disk was attached to it using Azure CLI. The virtual machine was then accessed through **RDP**, and the new disk was initialized and configured inside Windows Server using **Server Manager**.

This lab demonstrates how Azure administrators can combine command-line infrastructure deployment with operating system-level storage configuration.

## Objectives

The objectives of this lab were to:

- Open Azure Cloud Shell in Bash mode
- Create a Windows virtual machine using Azure CLI
- Attach a new managed disk to the virtual machine
- Connect to the virtual machine using RDP
- Initialize and configure the attached disk in Windows Server
- Verify that the new disk appeared as a usable drive
- Understand how Azure CLI can automate VM and storage deployment tasks

## Architecture Diagram

```text
                +----------------------+
                |   Azure Subscription |
                |      Payg-Lab2       |
                +----------+-----------+
                           |
                +----------+-----------+
                |       Resource Group |
                |     rg_eastus_xxxxx  |
                +----------+-----------+
                           |
                    +------+------+
                    | Windows VM   |
                    | myVM         |
                    | Win2022      |
                    +------+------+
                           |
         +-----------------+-----------------+
         |                                   |
+--------+--------+                 +--------+--------+
| OS Disk         |                 | Managed Data    |
| Standard_LRS    |                 | Disk            |
| Existing System |                 | 30 GB / Std LRS |
+-----------------+                 +-----------------+
                           |
                    +------+------+
                    | RDP Access   |
                    | Admin User   |
                    +------+------+
                           |
                    +------+------+
                    | Windows      |
                    | Server       |
                    | New Volume    |
                    +-------------+
```

This architecture shows a Windows virtual machine created with Azure CLI, a new managed disk attached to it, and Windows Server used to initialize the disk and create a new usable volume.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser session is recommended to avoid Azure portal cache issues.

---

### Step 2 — Open Azure Cloud Shell

In the Azure portal, select:

```text
Cloud Shell
```

Choose:

```text
Bash
```

In the startup pane, configure:

| Setting | Value |
|---|---|
| Cloud Shell Option | No storage account required |
| Subscription | Payg-Lab2 |

Select:

```text
Apply
```

This opens a Bash-based Cloud Shell session for Azure CLI commands.

---

### Step 3 — Create the Virtual Machine Using Azure CLI

If needed, find the resource group name:

```bash
az group list
```

Run the VM creation command:

```bash
az vm create \
  --resource-group <myResourceGroup> \
  --name myVM \
  --image win2022datacenter \
  --size Standard_B2s \
  --public-ip-sku Standard \
  --admin-username azureuser \
  --storage-sku Standard_LRS
```

When prompted:

1. Enter the **Admin Password**
2. Re-enter it to confirm

This command creates the virtual machine and required dependent resources such as:

- Network security group
- Public IP address
- Network interface
- Virtual network
- Subnet

Wait until the deployment completes successfully.

—


### Step 4 — Attach a New Managed Disk

After the VM is created, attach a new disk using Azure CLI:

```bash
az vm disk attach \
  --resource-group <resource-group-name> \
  --vm-name myVM \
  --name <disk-name> \
  --size-gb 30 \
  --sku Standard_LRS \
  --new
```

Replace:

- `<resource-group-name>` with the assigned resource group
- `<disk-name>` with a name of your choice

This command creates and attaches a new 30 GB managed disk to the running virtual machine.

—


### Step 5 — Connect to the Virtual Machine Using RDP

In the Azure Portal, search for:

```text
Virtual machines
```

Open:

```text
myVM
```

Select:

```text
Connect → Connect
```

For Windows:

1. Select **Download RDP File**
2. Open the downloaded RDP file
3. Select **Connect**
4. Choose **More choices**
5. Select **Use a different account**
6. Enter the administrator username and password created earlier
7. Accept the certificate warning if prompted

After sign-in completes, wait for Windows Server to finish loading.

If prompted with:

```text
Do you want to allow your PC to be discoverable by other PCs and devices on this network?
```

select:

```text
Yes
```

---

### Step 6 — Set Up the Attached Disk Inside Windows Server

Inside the virtual machine, open:

```text
Server Manager → File and Storage Services
```

Locate the newly attached disk.

Right-click the disk and select:

```text
New Volume
```

In the volume wizard:

- Keep the default selections
- Select **Next** through the wizard steps
- Select **Create** when prompted

After the wizard completes, open File Explorer.

Expected result:

- A new disk drive is visible and ready for use

This confirms the Azure managed disk was successfully attached, initialized, and formatted inside the guest operating system.


## Azure CLI (Bash)

Create the Windows VM:

```bash
az vm create \
  --resource-group <myResourceGroup> \
  --name myVM \
  --image win2022datacenter \
  --size Standard_B2s \
  --public-ip-sku Standard \
  --admin-username azureuser \
  --storage-sku Standard_LRS
```

Attach a new managed disk:

```bash
az vm disk attach \
  --resource-group <resource-group-name> \
  --vm-name myVM \
  --name myDataDisk1 \
  --size-gb 30 \
  --sku Standard_LRS \
  --new
```

Show VM details:

```bash
az vm show \
  --resource-group <resource-group-name> \
  --name myVM \
  --show-details
```

List attached disks:

```bash
az vm show \
  --resource-group <resource-group-name> \
  --name myVM \
  --query "storageProfile.dataDisks"
```

## Azure PowerShell

Create the Windows VM:

```powershell
New-AzVM `
  -ResourceGroupName "<resource-group-name>" `
  -Name "myVM" `
  -Location "East US" `
  -Image "Win2022Datacenter" `
  -Size "Standard_B2s" `
  -Credential (Get-Credential)
```

Attach a new managed disk:

```powershell
$vm = Get-AzVM `
  -ResourceGroupName "<resource-group-name>" `
  -Name "myVM"

$diskConfig = New-AzDiskConfig `
  -Location $vm.Location `
  -CreateOption Empty `
  -DiskSizeGB 30 `
  -SkuName Standard_LRS

$disk = New-AzDisk `
  -ResourceGroupName "<resource-group-name>" `
  -DiskName "myDataDisk1" `
  -Disk $diskConfig

$vm = Add-AzVMDataDisk `
  -VM $vm `
  -Name "myDataDisk1" `
  -CreateOption Attach `
  -ManagedDiskId $disk.Id `
  -Lun 0

Update-AzVM `
  -ResourceGroupName "<resource-group-name>" `
  -VM $vm
```

View VM disk configuration:

```powershell
Get-AzVM `
  -ResourceGroupName "<resource-group-name>" `
  -Name "myVM"
```

## Implementation Walkthrough

The lab started by opening Azure Cloud Shell in Bash mode and using Azure CLI to deploy a Windows Server 2022 virtual machine named `myVM`. This step demonstrated how Azure CLI can provision not only the VM itself but also the supporting resources such as networking, public IP, and security configuration. Because the VM was created from the command line, the deployment was repeatable and much faster than manually stepping through every portal screen.

Once the VM was running, a new managed disk was attached using the `az vm disk attach` command. This showed how Azure separates compute and storage management, allowing additional disks to be provisioned and connected after a VM already exists. The attached disk was created as a **new** 30 GB Standard_LRS managed disk.

After the infrastructure-side attachment was complete, the VM was accessed through RDP from the Azure Portal. Inside Windows Server, Server Manager was used to initialize the disk and create a new volume. This final step was important because attaching the disk in Azure does not automatically make it usable inside the guest operating system. The disk had to be brought online, formatted, and assigned as a volume before it appeared as a usable drive in File Explorer.

## Results & Validation

| Test | Result |
|---|---|
| Cloud Shell Bash setup | Successful |
| Windows VM creation with Azure CLI | Successful |
| Managed disk attachment | Successful |
| RDP connection to VM | Successful |
| Disk initialization in Windows | Successful |
| New volume creation | Successful |
| New drive visible in File Explorer | Successful |

Key observations:

- Azure CLI can provision a Windows VM and supporting resources quickly
- Managed disks can be attached after VM deployment without rebuilding the VM
- Azure-side disk attachment alone does not make the disk immediately usable inside Windows
- Windows Server still requires disk initialization and volume creation
- Server Manager provides a straightforward way to configure newly attached disks

## Validation Walkthrough

1. Verified that Azure Cloud Shell opened successfully in Bash mode.
2. Ran the `az vm create` command and confirmed the virtual machine `myVM` was created.
3. Entered and confirmed the administrator password during VM creation.
4. Ran the `az vm disk attach` command and confirmed the new 30 GB managed disk was attached.
5. Opened the VM resource in Azure Portal and confirmed the VM status and RDP options were available.
6. Downloaded the RDP file and connected successfully to the virtual machine.
7. Signed in using the administrator username and password created earlier.
8. Opened **Server Manager → File and Storage Services**.
9. Located the newly attached disk and started the **New Volume** wizard.
10. Completed the wizard using the default settings.
11. Opened File Explorer and confirmed a new disk drive appeared and was ready to use.

## Real-World Use Case

This pattern is common when administrators need to expand storage capacity for a running virtual machine without redeploying it.

Example: **Application Server Storage Expansion**

| Component | Role |
|---|---|
| Windows VM | Hosts the workload |
| OS Disk | Stores the operating system |
| Managed Data Disk | Provides extra application or file storage |
| Azure CLI | Automates deployment and attachment |
| Windows Server Volume Wizard | Makes the disk usable inside the OS |

Typical workflow:

```text
Deploy Windows VM
        ↓
Attach New Managed Disk
        ↓
Connect by RDP
        ↓
Initialize Disk in Windows
        ↓
Create New Volume
        ↓
Application Gains Additional Storage
```

This pattern is useful for file servers, application servers, database support volumes, log storage, and scenarios where storage needs increase after the original VM deployment.

## Key Takeaways

This lab demonstrated several important Azure compute and storage concepts:

- Azure CLI can be used to deploy Windows virtual machines quickly
- Managed disks can be attached to an existing VM after deployment
- Azure creates supporting resources such as NICs, public IPs, NSGs, and subnets automatically during CLI deployment
- Newly attached disks must still be initialized and formatted inside the guest operating system
- Combining Azure CLI with Windows Server administration is a practical operational skill for Azure administrators

Understanding Azure VM deployment and managed disk attachment is valuable for cloud administrators, infrastructure engineers, and operations teams responsible for compute and storage management in Azure.

