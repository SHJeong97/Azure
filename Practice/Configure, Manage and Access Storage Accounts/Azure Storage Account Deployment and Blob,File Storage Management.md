# Azure Storage Account Deployment and Blob/File Storage Management

## Introduction

In this project, I deployed an Azure Storage Account and configured multiple storage services including Blob Storage and Azure File Shares. The implementation demonstrates how Azure storage accounts manage different data services and how redundancy, performance, and access tiers influence storage architecture.

Azure Storage provides scalable cloud storage for unstructured data such as files, images, and application data. By deploying a storage account and interacting with containers and file shares, administrators can manage application data efficiently while ensuring redundancy and availability.

This project demonstrates how to deploy storage infrastructure, upload blob objects, and manage file shares using Azure services.

---

## Objectives

- Understand Azure Storage performance tiers
- Understand redundancy models (LRS, ZRS, GRS, GZRS)
- Deploy an Azure Storage Account
- Create a Blob Storage container
- Upload a Blob object
- Create an Azure File Share
- Upload files to Azure File Storage

---

# Full Implementation

## Create Storage Account

### Azure CLI (Bash)

```bash
az storage account create \
--name demostorageacctest1<name> \
--resource-group <resource-group-name> \
--location eastus \
--sku Standard_LRS \
--kind StorageV2
``` 
###Azure PowerShell
```powershell
New-AzStorageAccount `
-ResourceGroupName "<resource-group-name>" `
-Name "demostorageacctest1<name>" `
-Location "East US" `
-SkuName Standard_LRS `
-Kind StorageV2
``` 

## Create Blob Container
### Azure CLI (Bash)
```bash
az storage container create \
--account-name demostorageacctest1<name> \
--name democontainer1 \
--auth-mode login
``` 
### Azure PowerShell
```powershell
$ctx = (Get-AzStorageAccount -ResourceGroupName "<resource-group-name>" -Name "demostorageacctest1<name>").Context

New-AzStorageContainer `
-Name "democontainer1" `
-Context $ctx
``` 

## Upload Blob Object
### Azure CLI (Bash)
```bash
az storage blob upload \
--account-name demostorageacctest1<name> \
--container-name democontainer1 \
--name sample.html \
--file sample.html \
--auth-mode login
``` 
### Azure PowerShell
```powershell
Set-AzStorageBlobContent `
-Container "democontainer1" `
-File "sample.html" `
-Blob "sample.html" `
-Context $ctx
``` 

## Create File Share
### Azure CLI (Bash)
```bash
az storage share create \
--account-name demostorageacctest1<name> \
--name demofile1 \
--quota 100
``` 
### Azure PowerShell
```powershell
New-AzStorageShare `
-Name "demofile1" `
-Context $ctx
``` 

## Upload File to File Share
### Azure CLI (Bash)
```bash
az storage file upload \
--account-name demostorageacctest1<name> \
--share-name demofile1 \
--source <localfile>
``` 
### Azure PowerShell
```powershell
Set-AzStorageFileContent `
-ShareName "demofile1" `
-Source "<localfile>" `
-Path "<localfile>" `
-Context $ctx
``` 

##  Implementation Walkthrough
### Step 1 — Storage Account Deployment
A Storage Account was created using the following configuration:
| Configuration | Value     |
| ------------- | --------- |
| Performance   | Standard  |
| Redundancy    | LRS       |
| Region        | East US   |
| Storage Type  | StorageV2 |

LRS replicates data three times within a single data center to protect against hardware failures.
<img width="1523" height="1197" alt="image" src="https://github.com/user-attachments/assets/05062749-bb4b-4bc8-ab9e-a7e5bb6489c5" />


### Step 2 — Container Creation
A Blob container named democontainer1 was created to store unstructured data such as HTML files, images, and documents.
Blob containers act as logical storage directories inside the storage account.
<img width="1523" height="381" alt="image" src="https://github.com/user-attachments/assets/859eb8f3-08c5-41ff-9001-288893fca240" />


### Step 3 — Blob Upload
A sample HTML file named sample.html was created locally and uploaded to the Blob container.
Example content:
<h1>This is a sample document!</h1>
Once uploaded, the blob becomes accessible through Azure Storage.
<img width="1316" height="388" alt="image" src="https://github.com/user-attachments/assets/86df6691-680b-4a58-8cef-f0b849d30f27" />



### Step 4 — Azure File Share Creation
An Azure File Share named demofile1 was created.
Azure File Shares allow cloud-hosted SMB file systems that can be mounted by Windows, Linux, and macOS machines.
Access Tier selected:
| Tier | Use Case                 |
| ---- | ------------------------ |
| Hot  | Frequently accessed data |


### Step 5 — File Upload
A file from the local computer was uploaded into the file share.
This demonstrates how Azure File Storage can be used as a cloud-based file server.
<img width="973" height="795" alt="image" src="https://github.com/user-attachments/assets/0673e1ed-2fab-4de1-a374-611e51d52b41" />


##  Results & Validation
The following results confirm successful implementation:
- Storage Account deployed successfully


- Blob container created


- HTML blob uploaded successfully


- File share created


- File uploaded to Azure File Storage


- Storage resources visible in Azure Portal


All storage services operated correctly.

##  Validation Walkthrough
- Verified Storage Account creation in Azure Portal.


- Confirmed redundancy configuration (LRS).


- Created Blob container successfully.


- Uploaded HTML file to Blob Storage.


- Confirmed blob appeared in container.


- Created Azure File Share.


- Uploaded file to file share.


- Verified files were visible in the storage interface.


All validation steps completed successfully.

##  Key Takeaways
- Azure Storage Accounts provide scalable cloud storage services.


- LRS ensures data durability within a single data center.


- Blob Storage is designed for unstructured object storage.


- Containers organize blobs within storage accounts.


- Azure File Shares provide SMB-based shared file storage.


- Storage accounts integrate with many Azure services such as backups, machine learning, and serverless applications.


This project strengthens Azure Administrator skills in storage deployment, data management, and cloud storage architecture.

