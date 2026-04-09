# Azure File Share Deployment and SMB Access via Virtual Machine

## Introduction

Azure File Shares provide fully managed file storage in the cloud that can be accessed using the Server Message Block (SMB) protocol. This service allows organizations to store and share files across multiple systems while maintaining centralized management and scalability.

Unlike Blob Storage, which is designed for object storage, Azure File Shares provide traditional file system functionality that can be mounted as a network drive on Windows, Linux, or macOS systems.

In this lab, an Azure Storage Account was created, an Azure File Share was deployed, and a Windows Server virtual machine was configured to access the file share using SMB over TCP port 445.

---

## Objectives

The objectives of this lab were to:

- Deploy an Azure Storage Account
- Create an Azure File Share
- Upload files to the file share
- Deploy a Windows Server virtual machine
- Configure network security rules for remote access
- Connect to the VM using Remote Desktop Protocol (RDP)
- Mount the Azure File Share as a network drive using SMB

---

## Architecture Diagram

```
                 +----------------------+
                 |   Azure Subscription |
                 +----------+-----------+
                            |
                 +----------+-----------+
                 |       Resource Group |
                 |     rg_eastus_xxxxx  |
                 +----------+-----------+
                            |
                   +--------+--------+
                   | Storage Account |
                   |  Standard LRS   |
                   +--------+--------+
                            |
                     +------+------+
                     |  File Share |
                     |  demofile1  |
                     +------+------+
                            |
                       SMB Protocol
                         TCP 445
                            |
                    +-------+-------+
                    |  Azure VM     |
                    | Windows Server|
                    | mydemoVM1 |
                    +-------+-------+
                            |
                        RDP Access
                        Port 3389
                            |
                      Administrator
```

This architecture demonstrates how an Azure Virtual Machine connects to Azure File Storage through the SMB protocol while administrators access the VM using RDP.

---

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```
https://portal.azure.com
```

Log in using the provided credentials.

Using an incognito browser window is recommended to avoid authentication caching issues.

---

### Step 2 — Create Storage Account

Navigate to:

```
Storage Accounts → Create
```

Configuration:

| Setting | Value |
|------|------|
| Resource Group | rg_eastus_XXXXX |
| Region | East US |
| Performance | Standard |
| Redundancy | Locally Redundant Storage (LRS) |

Deploy the storage account.

—
<img width="1327" height="1878" alt="image" src="https://github.com/user-attachments/assets/5721ef6c-5874-433e-b9a1-950d1fefe65a" />


### Step 3 — Create Azure File Share

Navigate to:

```
Storage Account → File Shares → + File Share
```

Configuration:

| Setting | Value |
|------|------|
| Name | demofile1 |
| Tier | Hot |

Deploy the file share.


---
<img width="1153" height="830" alt="image" src="https://github.com/user-attachments/assets/2b488bb7-ff56-47cf-b6ad-52eb7804022a" />

### Step 4 — Upload File to File Share

Open the file share and upload a file from your local computer.

Steps:

```
File Share → Upload → Select File → Upload
```

After uploading, verify the file appears in the directory.

—
<img width="1523" height="517" alt="image" src="https://github.com/user-attachments/assets/681e430d-ea62-4e2e-9961-f487032ad637" />


### Step 5 — Deploy Virtual Machine

Navigate to:

```
Virtual Machines → Create → Azure Virtual Machine
```

Configuration:

| Setting | Value |
|------|------|
| VM Name | demoVM1 |
| Image | Windows Server 2025 Datacenter |
| Size | B2s |
| Region | West Europe |
| Public inbound ports | None |

Administrator credentials must be configured during deployment.

—
<img width="1523" height="1719" alt="image" src="https://github.com/user-attachments/assets/8f22cf79-bf9c-4920-b561-a24a46fb6121" />


### Step 6 — Configure RDP Access

Create an inbound rule for RDP:

| Setting | Value |
|------|------|
| Source | Service Tag |
| Source service tag | Internet |
| Destination Port | 3389 |
| Protocol | TCP |
| Action | Allow |
| Priority | 100 |

This allows administrators to remotely access the VM.

—
<img width="1523" height="978" alt="image" src="https://github.com/user-attachments/assets/948d31c2-f1b2-4a51-937c-eaf7edc7be3a" />


### Step 7 — Connect to Virtual Machine

Download the RDP file and connect to the VM using Remote Desktop.

Enter the administrator credentials to authenticate.

---

### Step 8 — Mount Azure File Share

Navigate to the file share in the Azure Portal and select:

```
Connect
```

Copy the PowerShell script displayed.

Run the script in **PowerShell (Administrator)** inside the VM.

This command mounts the Azure File Share as a network drive.

Example:

```powershell
net use Z: \\<storageaccount>.file.core.windows.net\demofile1 /u:<storageaccount> <storage-key>
```

Verify the mounted drive:

```powershell
Z:
dir
```

The uploaded file should appear in the directory listing.

—



### Azure CLI (Bash)

Create storage account:

```bash
az storage account create \
  --name demostorageacc533 \
  --resource-group rg_eastus_XXXXX \
  --location eastus \
  --sku Standard_LRS
```

Create file share:

```bash
az storage share create \
  --name demofile1 \
  --account-name demostorageacc533
```

Upload file:

```bash
az storage file upload \
  --share-name demofile1 \
  --source sample.txt \
  --account-name demostorageacc533
```

---

### Azure PowerShell

Create storage account:

```powershell
New-AzStorageAccount `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "demostorageacc533" `
  -Location "EastUS" `
  -SkuName Standard_LRS `
  -Kind StorageV2
```

Create file share:

```powershell
$ctx = (Get-AzStorageAccount -ResourceGroupName "rg_eastus_XXXXX" -Name "demostorageacc533").Context

New-AzStorageShare `
  -Name "demofile1" `
  -Context $ctx
```

Upload file:

```powershell
Set-AzStorageFileContent `
  -ShareName "demofile1" `
  -Source "sample.txt" `
  -Path "sample.txt" `
  -Context $ctx
```

---

## Implementation Walkthrough

The lab demonstrated how Azure File Shares integrate with compute resources such as virtual machines.

The workflow included:

1. Deploying a storage account for file services.
2. Creating an Azure File Share with the Hot performance tier.
3. Uploading files to the file share.
4. Deploying a Windows Server virtual machine.
5. Allowing RDP access to the VM.
6. Mounting the Azure File Share using SMB protocol.

Once mounted, the file share behaves like a traditional network drive.

---

## Results & Validation

| Test | Result |
|-----|------|
| Storage account deployment | Successful |
| File share creation | Successful |
| File upload | Successful |
| VM deployment | Successful |
| RDP connectivity | Successful |
| SMB connection | Successful |
| File access from VM | Successful |

Key observation:

Azure File Shares allow cloud-hosted storage to function similarly to traditional on-premises file servers.

---

## Validation Walkthrough

1. Verified the storage account was successfully deployed.
2. Confirmed the file share was created within the storage account.
3. Uploaded a test file to the file share.
4. Deployed a Windows Server VM.
5. Configured an inbound security rule for RDP access.
6. Connected to the VM using Remote Desktop.
7. Mounted the Azure File Share using the provided script.
8. Verified the file share appeared as drive **Z:**.
9. Confirmed the uploaded file was accessible from the VM.

---

## Real-World Use Case

Azure File Shares are commonly used to replace traditional on-premises file servers.

Example: **Enterprise File Storage**

| System | Role |
|------|------|
| Azure File Share | Centralized file storage |
| Azure VM | Application server |
| SMB Protocol | File access |
| RDP | Administrative access |

Typical workflow:

```
Users / Applications → Azure VM → SMB (TCP 445) → Azure File Share
```

This architecture enables organizations to maintain centralized storage while supporting hybrid or cloud-native infrastructure.

---

## Key Takeaways

This lab demonstrated key Azure file storage concepts:

- Azure File Shares provide managed file storage accessible through SMB.
- File shares can be mounted as network drives on virtual machines.
- RDP enables administrative access to cloud-hosted servers.
- SMB connectivity allows seamless file sharing between compute resources and storage.

Understanding Azure File Shares is essential for cloud engineers managing hybrid environments, shared storage systems, and enterprise workloads.

