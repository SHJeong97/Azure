# Azure File Share Mapping, Snapshots, and Restore Operations

## Introduction

Azure File Shares provide fully managed SMB file storage in Azure that can be mounted by Windows systems like traditional network drives. This makes them useful for lift-and-shift file services, shared team storage, application data, and backup or recovery workflows.

In this lab, an Azure Storage Account was created, an SMB file share was deployed, and a Windows virtual machine was provisioned to simulate an on-premises server. The file share was mapped to a Windows drive, snapshots were created, file changes were made, and earlier versions of the file were restored using both the Azure Portal and Windows Previous Versions.

This lab demonstrates how Azure File Shares can support shared storage, point-in-time protection, and file recovery operations in a cloud environment.

## Objectives

The objectives of this lab were to:

- Create an Azure Storage Account
- Create an SMB Azure File Share
- Upload a file to the share
- Deploy a Windows virtual machine
- Connect to the VM using RDP
- Map the Azure File Share to a Windows drive
- Create share snapshots
- Modify a file after snapshots are taken
- Browse snapshot contents
- Restore a file from a snapshot
- Use Windows Previous Versions to access snapshot history

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
| Storage Account|                    | Windows VM     |
| Standard LRS   |                    | Server 2025    |
+-------+--------+                    +-------+--------+
        |                                     |
+-------+--------+                    +-------+--------+
| File Share     |<----- SMB -------->| Mapped Drive   |
| qsfileshare    |                    | Windows Drive  |
+-------+--------+                    +-------+--------+
        |                                     |
+-------+--------+                            |
| sample.html    |                            |
| Uploaded File  |                            |
+-------+--------+                            |
        |                                     |
+-------+--------+                            |
| Share Snapshot |                            |
| Point-in-time  |                            |
| Recovery State |                            |
+----------------+                            |
                           Previous Versions / Restore
```

This architecture shows an Azure File Share hosted in a storage account, mapped to a Windows VM over SMB, with share snapshots providing point-in-time recovery for file restore operations.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser session is recommended to avoid Azure portal cache issues.

---

### Step 2 — Create a Storage Account

Navigate to:

```text
Storage Accounts → Create
```

Configure the storage account with the following settings:

| Setting | Value |
|---|---|
| Resource Group | Existing assigned resource group |
| Storage Account Name | Unique name |
| Region | East US |
| Preferred Storage Type | Azure Blob Storage or Azure Data Lake Storage Gen 2 |
| Performance | Standard |
| Redundancy | Locally-redundant storage (LRS) |

Leave the remaining settings at default values, then review and create the storage account.

---

### Step 3 — Create the File Share

After deployment completes, open the storage account and navigate to:

```text
File shares → + File share
```

Configure the file share:

| Setting | Value |
|---|---|
| Name | qsfileshare |
| Tier | Transaction optimized |
| Backup | Disabled |

Review and create the file share.

Create a local text or HTML test file, then upload it to the share. The uploaded file used in the lab was:

```text
sample.html
```

Confirm the file appears in the file share.

—
<img width="1523" height="663" alt="image" src="https://github.com/user-attachments/assets/f513d96b-ca56-4b18-aa9d-76b6ee39a318" />


### Step 4 — Deploy the Windows Virtual Machine

Navigate to:

```text
Virtual Machines → Create
```

Configure the VM:

| Setting | Value |
|---|---|
| Resource Group | Existing assigned resource group |
| Name | Name of your choice |
| Region | East US |
| Availability Options | No infrastructure redundancy required |
| Security Type | Standard |
| Image | Windows Server 2025 Datacenter: Azure Edition - x64 Gen2 |
| Size | B2s |
| Inbound Ports | RDP, HTTP |
| OS Disk Type | Standard SSD |

Set the administrator username and password, then review and create the VM.

---

### Step 5 — Connect to the Virtual Machine

Open the deployed VM and select:

```text
Connect → Native RDP
```

Download the RDP file and connect using the administrator credentials you created during deployment.

After authentication completes, you are connected to the Windows VM.

---

### Step 6 — Map the Azure File Share to a Windows Drive

In the Azure Portal, open the file share:

```text
qsfileshare
```

Select:

```text
Connect
```

Choose a drive letter, then select:

```text
Show script
```

Copy the provided PowerShell script.

Inside the VM:

1. Open PowerShell
2. Paste the script
3. Run it

This maps the Azure File Share as a Windows drive.

Verify that the share is accessible from File Explorer.

—
<img width="1523" height="1030" alt="image" src="https://github.com/user-attachments/assets/91722245-4d29-47f7-a351-7b87b8b8ecc6" />



### Step 7 — Create the First Share Snapshot

In the Azure Portal, open the file share and navigate to:

```text
Snapshots
```

Select:

```text
+ Add snapshot
```

Create the snapshot.

This captures a point-in-time version of the share.

---

### Step 8 — Modify the File in the Mounted Share

Inside the VM, open File Explorer and browse to the mapped drive.

Open:

```text
sample.html
```

Modify the file contents and save the changes.

Example modified text used in the lab included:

```text
This is a modified!
```

—


### Step 9 — Create the Second Snapshot

Return to the Azure Portal and create another share snapshot after the file has been modified.

This preserves a later point-in-time version of the share after the change.

—


### Step 10 — Browse a Share Snapshot

Open the file share and navigate to:

```text
Snapshots
```

Select the first snapshot in the list.

Open:

```text
sample.html
```

This allows you to inspect the earlier version of the file stored in the snapshot.

---

### Step 11 — Restore from a Snapshot

From the snapshot view, right-click:

```text
sample.html
```

Select:

```text
Restore
```

Choose:

```text
Overwrite original file
```

Confirm the restore operation.

Inside the VM, reopen the file and verify that the earlier, unmodified version has been restored.

---


### Step 12 — Delete a Share Snapshot

Before deleting snapshots, check the storage account for locks:

```text
Settings → Locks
```

Remove any locks if present.

Return to:

```text
File share → Snapshots
```

Select the last snapshot and delete it.

---

### Step 13 — Use Previous Versions in Windows

Inside the VM, locate the mounted file share in File Explorer.

Right-click:

```text
sample.html → Properties
```

Open the:

```text
Previous Versions
```

tab.

This displays the available share snapshots from Azure File Share.

Select:

```text
Open
```

to browse a previous version, or:

```text
Restore
```

to restore the contents recursively to the original location.


## Azure CLI (Bash)

Create the storage account:

```bash
az storage account create \
  --name mystorageacct123 \
  --resource-group rg_eastus_XXXXX \
  --location eastus \
  --sku Standard_LRS \
  --kind StorageV2
```

Create the file share:

```bash
az storage share-rm create \
  --resource-group rg_eastus_XXXXX \
  --storage-account mystorageacct123 \
  --name qsfileshare \
  --enabled-protocols SMB
```

Upload the file:

```bash
az storage file upload \
  --account-name mystorageacct123 \
  --share-name qsfileshare \
  --source sample.html
```

Create a share snapshot:

```bash
az storage share snapshot \
  --account-name mystorageacct123 \
  --name qsfileshare
```

List share snapshots:

```bash
az storage share list \
  --account-name mystorageacct123 \
  --include-snapshots \
  --output table
```

Show the SMB mount command:

```bash
az storage share-rm generate-sas \
  --storage-account mystorageacct123 \
  --name qsfileshare \
  --permissions rcwdl
```

## Azure PowerShell

Create the storage account:

```powershell
New-AzStorageAccount `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "mystorageacct123" `
  -Location "East US" `
  -SkuName "Standard_LRS" `
  -Kind "StorageV2"
```

Get the storage context:

```powershell
$ctx = (Get-AzStorageAccount `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "mystorageacct123").Context
```

Create the file share:

```powershell
New-AzStorageShare `
  -Name "qsfileshare" `
  -Context $ctx
```

Upload the file:

```powershell
Set-AzStorageFileContent `
  -ShareName "qsfileshare" `
  -Source ".\sample.html" `
  -Path "sample.html" `
  -Context $ctx
```

Create a snapshot:

```powershell
Get-AzStorageShare `
  -Name "qsfileshare" `
  -Context $ctx | Snapshot-AzStorageShare
```

List shares and snapshots:

```powershell
Get-AzStorageShare -Context $ctx
```

## Implementation Walkthrough

The lab began by creating an Azure Storage Account in East US with Standard performance and LRS redundancy. Inside that account, an SMB file share named `qsfileshare` was created with the **Transaction optimized** tier. A test file was then uploaded into the share so there would be content available for later snapshot and restore operations.

Next, a Windows Server virtual machine was deployed to simulate an on-premises-style server. After connecting to the VM with RDP, the Azure file share connection script was copied from the portal and executed in PowerShell. This mapped the file share as a Windows drive, making the Azure-hosted file share behave like a traditional network drive inside the VM.

Once the share was mounted, the lab moved into data protection operations. A snapshot was created, the file was modified, and a second snapshot was taken. Earlier file versions were then browsed from the snapshot list, and the original file was restored by overwriting the changed version. Finally, Windows **Previous Versions** was used to view and restore file history directly from the mounted share, showing how Azure File Share snapshots integrate with familiar Windows recovery workflows.

## Results & Validation

| Test | Result |
|---|---|
| Storage account creation | Successful |
| File share creation | Successful |
| File upload to share | Successful |
| Windows VM deployment | Successful |
| RDP connection | Successful |
| File share mapped to Windows drive | Successful |
| Share snapshot creation | Successful |
| Snapshot browse operation | Successful |
| File restore from snapshot | Successful |
| Previous Versions access in Windows | Successful |
| Snapshot deletion | Successful |

Key observations:

- Azure File Shares can be mounted to Windows systems like traditional SMB shares
- Share snapshots provide point-in-time recovery without separate backup tooling
- File changes after a snapshot can be reversed through restore operations
- Windows Previous Versions integrates naturally with Azure File Share snapshots
- Snapshot-based recovery is useful for accidental modification or overwrite scenarios

## Validation Walkthrough

1. Verified that the Azure Storage Account was created successfully.
2. Confirmed that the `qsfileshare` file share was created with the correct tier.
3. Uploaded `sample.html` and verified that it appeared in the file share.
4. Deployed the Windows VM and connected successfully using RDP.
5. Copied the file share mapping script from the portal and ran it in PowerShell on the VM.
6. Verified that the share was mounted as a Windows drive.
7. Created the first share snapshot successfully.
8. Modified `sample.html` from the mapped drive and saved the changes.
9. Created the second share snapshot successfully.
10. Opened the first snapshot and verified the earlier file contents were available.
11. Restored `sample.html` from the snapshot using **Overwrite original file**.
12. Reopened the file in the VM and confirmed the earlier version was restored.
13. Opened **Previous Versions** in Windows and confirmed snapshot history was visible.
14. Opened and restored previous versions successfully from the Windows interface.
15. Deleted the last snapshot after checking for and removing any resource locks.

## Real-World Use Case

Azure File Share snapshots are useful when organizations need lightweight file-level recovery for shared storage.

Example: **Shared Department File Recovery**

| Component | Role |
|---|---|
| Azure Storage Account | Hosts the file service |
| Azure File Share | Shared team data location |
| Windows VM / Client | Accesses the mapped drive |
| Share Snapshots | Point-in-time file recovery |
| Previous Versions | Familiar restore interface for users |

Typical workflow:

```text
User Saves File to Azure File Share
            ↓
Scheduled or Manual Snapshot Created
            ↓
File Is Modified or Overwritten
            ↓
Earlier Version Is Opened from Snapshot
            ↓
Original File Is Restored
```

This pattern is useful for department shares, lift-and-shift file servers, user file recovery, and environments where quick rollback of changed files is required.

## Key Takeaways

This lab demonstrated several important Azure file storage concepts:

- Azure File Shares provide SMB-based shared storage in Azure
- Windows systems can map Azure file shares like traditional network drives
- Share snapshots capture point-in-time versions of files and directories
- Files can be restored from snapshots through both Azure Portal and Windows Previous Versions
- Snapshot-based recovery is an effective way to protect against accidental modification or overwrite

Understanding Azure File Share mapping and snapshot recovery is valuable for cloud administrators, infrastructure engineers, and operations teams managing shared storage and file recovery in Azure.

