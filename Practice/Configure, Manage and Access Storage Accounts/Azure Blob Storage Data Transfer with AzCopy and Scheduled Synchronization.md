# Azure Blob Storage Data Transfer with AzCopy and Scheduled Synchronization

## Introduction

Azure Blob Storage provides scalable cloud object storage for large volumes of unstructured data such as documents, backups, application data, and media files. Organizations often need to transfer data from on-premises systems to Azure storage in a reliable and automated way.

Azure provides **AzCopy**, a command-line utility designed for high-performance data transfers between local systems and Azure Blob Storage. AzCopy supports large file transfers, parallel operations, and resumable uploads, making it suitable for enterprise data migration and synchronization tasks.

In this lab, an Azure Storage Account was deployed with **Geo-Redundant Storage (GRS)** and **Hierarchical Namespace enabled**. A Blob container was created, AzCopy was installed and used to upload local files to Azure Blob Storage, and a scheduled task was configured to automate future data synchronization.

---

## Objectives

The objectives of this lab were to:

- Deploy an Azure Storage Account
- Configure **Geo-Redundant Storage (GRS)**
- Enable **Hierarchical Namespace**
- Create a Blob container
- Install and authenticate AzCopy
- Upload local files to Azure Blob Storage
- Synchronize new files using AzCopy
- Automate uploads using a scheduled task

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
                  |  Storage Account|
                  |  Standard GRS   |
                  | Hierarchical NS |
                  +--------+--------+
                           |
                     +-----+------+
                     | Blob Container |
                     |  democontainer |
                     +-----+------+
                           |
                     Azure Blob Storage
                           ^
                           |
                     AzCopy Utility
                           |
                +----------+-----------+
                |   Local File System  |
                |  Upload / Sync Data  |
                +----------+-----------+
                           |
                   Windows Scheduled Task
```

This architecture demonstrates how AzCopy transfers data from a local environment to Azure Blob Storage and how scheduled automation ensures ongoing synchronization.

---

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure portal:

```
https://portal.azure.com
```

Log in using the provided credentials. Using an **incognito browser session** is recommended to avoid cached authentication issues.

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
| Storage Account Name | whizstorage<yourname> |
| Region | East US |
| Performance | Standard |
| Redundancy | Geo-Redundant Storage (GRS) |

Advanced settings:

```
Hierarchical Namespace → Enabled
```

Deploy the storage account and open the resource once deployment completes.

—
<img width="1316" height="1548" alt="image" src="https://github.com/user-attachments/assets/b86054f9-901b-4eb4-b509-72b034b142b3" />


### Step 3 — Create Blob Container

Navigate to:

```
Storage Account → Containers → + Container
```

Create container:

```
democontainer
```

The container will store files uploaded using AzCopy.

—
<img width="1523" height="488" alt="image" src="https://github.com/user-attachments/assets/1bed2998-c4b6-4514-85d5-93ee68d7653b" />


### Step 4 — Install AzCopy

Download AzCopy:

```
https://aka.ms/downloadazcopy-v10-windows
```

Extract the downloaded zip file.

Open **Command Prompt** and navigate to the AzCopy directory:

```bash
cd <azcopy-folder-path>
```

---

### Step 5 — Authenticate AzCopy

Authenticate with Azure:

```bash
azcopy login
```

A browser window will open.

Enter the authentication code displayed in the terminal and log in with your Azure credentials.

After authentication completes, the terminal will display:

```
Login succeeded
```

—
<img width="1523" height="233" alt="image" src="https://github.com/user-attachments/assets/3c579141-3768-45f9-be1c-9a0f667144d9" />
<img width="1231" height="872" alt="image" src="https://github.com/user-attachments/assets/d2959c09-d6cb-42de-9480-ead37c052b49" />
<img width="1523" height="184" alt="image" src="https://github.com/user-attachments/assets/afb65436-094c-44e0-be0a-b9fe75d72c67" />




### Step 6 — Upload Local Files Using AzCopy

Upload all files from a local directory to Blob storage:

```bash
azcopy copy "C:\localfolder\*" "https://<storageaccount>.blob.core.windows.net/democontainer" --recursive
```

All files in the local folder will now be uploaded to Azure Blob Storage.

—
<img width="1523" height="700" alt="image" src="https://github.com/user-attachments/assets/9d0f7245-8938-4896-a6e3-d83017564b34" />
<img width="1523" height="513" alt="image" src="https://github.com/user-attachments/assets/f882143f-482d-41c0-b99a-9f5d89e30a5c" />



### Step 7 — Synchronize Modified Files

AzCopy can synchronize files based on modification time.

Example command:

```bash
azcopy sync "C:\localfolder" "https://<storageaccount>.blob.core.windows.net/democontainer"
```

This command uploads:

- New files
- Updated files
- Modified files

Only changed data is transferred.

—
<img width="1523" height="513" alt="image" src="https://github.com/user-attachments/assets/1df1ff18-c9c4-4d9e-8cdd-eb291b9f8dc6" />
<img width="1523" height="552" alt="image" src="https://github.com/user-attachments/assets/8b479013-fae8-4d1e-b8dd-b764d609cdd5" />



### Step 8 — Automate Uploads with Scheduled Task

Create a script file:

```
script.bat
```

Example script:

```bash
azcopy sync "C:\localfolder" "https://<storageaccount>.blob.core.windows.net/democontainer"
```

Create a scheduled task:

```bash
schtasks /create /sc hourly /tn "AzureBlobSync" /tr "C:\scripts\script.bat"
```

This task automatically synchronizes local files with Azure Blob Storage at scheduled intervals.

---
<img width="1523" height="188" alt="image" src="https://github.com/user-attachments/assets/963c6234-747a-4a23-9dd1-737b8409c52f" />

### Azure CLI (Bash)

Create storage account:

```bash
az storage account create \
  --name whizstorage123 \
  --resource-group rg_eastus_XXXXX \
  --location eastus \
  --sku Standard_GRS \
  --kind StorageV2
```

Create container:

```bash
az storage container create \
  --name democontainer \
  --account-name whizstorage123
```

---

### Azure PowerShell

Create storage account:

```powershell
New-AzStorageAccount `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "whizstorage123" `
  -Location "EastUS" `
  -SkuName Standard_GRS `
  -Kind StorageV2 `
  -EnableHierarchicalNamespace $true
```

Create container:

```powershell
$ctx = (Get-AzStorageAccount -ResourceGroupName "rg_eastus_XXXXX" -Name "whizstorage123").Context

New-AzStorageContainer `
  -Name "democontainer" `
  -Context $ctx
```

---

## Implementation Walkthrough

The lab demonstrated how Azure Blob Storage can integrate with local environments through command-line utilities such as AzCopy.

The workflow included:

1. Deploying a storage account with geo-redundant storage.
2. Creating a container to store blob objects.
3. Installing AzCopy to perform high-performance file transfers.
4. Uploading local files to Azure storage.
5. Synchronizing modified files using AzCopy sync commands.
6. Automating transfers through scheduled tasks.

This process demonstrates how organizations can maintain continuous synchronization between on-premises data and cloud storage.

---

## Results & Validation

| Test | Result |
|-----|------|
| Storage account deployment | Successful |
| Blob container creation | Successful |
| AzCopy installation | Successful |
| AzCopy authentication | Successful |
| Local file upload | Successful |
| File synchronization | Successful |
| Scheduled automation | Successful |

Key observation:

AzCopy significantly improves the performance of bulk data transfers and supports resumable operations.

---

## Validation Walkthrough

1. Verified storage account deployment in Azure Portal.
2. Confirmed container creation within the storage account.
3. Installed AzCopy and navigated to the executable directory.
4. Authenticated AzCopy using Azure credentials.
5. Uploaded local files using AzCopy copy command.
6. Confirmed files appeared inside the Azure container.
7. Added new files to the local directory.
8. Ran AzCopy sync command to upload only modified files.
9. Created a scheduled task to automate the synchronization process.
10. Verified that newly created files appeared in the Azure container after scheduled execution.

---

## Real-World Use Case

AzCopy is commonly used for **enterprise data migration and backup automation**.

Example: **On-Premises Backup to Azure Cloud**

| System | Function |
|------|------|
| Local Server | Stores application data |
| AzCopy | Transfers files to Azure |
| Azure Blob Storage | Long-term storage |
| Scheduled Task | Automates periodic uploads |

Typical workflow:

```
Local Data → AzCopy Upload → Azure Blob Storage
        → Scheduled Sync → Continuous Cloud Backup
```

This architecture enables organizations to maintain secure off-site backups and improve disaster recovery capabilities.

---

## Key Takeaways

This lab demonstrated important Azure data transfer concepts:

- AzCopy enables high-performance data transfers to Azure Blob Storage
- Hierarchical Namespace supports advanced data organization
- Geo-Redundant Storage (GRS) improves data durability
- AzCopy sync allows incremental file uploads
- Scheduled automation enables continuous cloud data synchronization

Understanding AzCopy and storage automation is essential for cloud administrators and engineers responsible for managing enterprise data pipelines.

