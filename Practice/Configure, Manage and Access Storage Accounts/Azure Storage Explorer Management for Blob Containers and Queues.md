# Azure Storage Explorer Management for Blob Containers and Queues

## Introduction

Azure Storage Explorer is a standalone graphical management tool that allows administrators to work with Azure Storage resources outside the Azure Portal. It provides a convenient way to browse storage accounts, create and manage containers, upload blobs, create queues, and inspect storage resources through a desktop-style interface.

In this lab, Azure Storage Explorer was connected to an Azure subscription, a new Azure Storage Account was created from Azure Cloud Shell, and the storage account was then managed through Storage Explorer. A blob container was created, a file was uploaded as a blob, and a queue was created. Finally, the deployments were verified in the Azure Portal.

This lab demonstrates how Azure administrators can combine **CLI-based resource deployment** with **GUI-based storage management** for day-to-day operational tasks.

## Objectives

The objectives of this lab were to:

- Connect Azure Storage Explorer to an Azure subscription
- Create an Azure Storage Account using Azure Cloud Shell
- Refresh and locate the storage account in Azure Storage Explorer
- Create a blob container in the storage account
- Upload a file as a blob
- Create a queue in the storage account
- Verify the blob container and queue in the Azure Portal
- Understand how Storage Explorer simplifies Azure Storage administration

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
                    | Storage     |
                    | Account     |
                    | StorageV2   |
                    +------+------+
                           |
        +------------------+------------------+
        |                                     |
+-------+--------+                    +-------+--------+
| Blob Containers|                    | Queues         |
| demoblobcontainer1                  | demoqueue1     |
+-------+--------+                    +-------+--------+
        |                                     |
+-------+--------+                            |
| Uploaded Blob  |                            |
| Local File     |                            |
+----------------+                            |
                           ^
                           |
                +----------+-----------+
                | Azure Storage        |
                | Explorer             |
                +----------+-----------+
                           |
                +----------+-----------+
                | Azure Cloud Shell    |
                | az storage account   |
                +----------------------+
```

This architecture shows a storage account created through Azure Cloud Shell, then managed through Azure Storage Explorer to create a blob container, upload a blob, and create a queue.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser session is recommended to avoid Azure portal cache issues.

---

### Step 2 — Connect Azure Storage Explorer to Azure

Open **Azure Storage Explorer** on the local system.

From the home page, select:

```text
Sign in to Azure
```

Or use the profile icon in the left pane and choose:

```text
Sign in with Azure
```

When prompted for the environment, select:

```text
Azure
```

Complete the browser-based sign-in flow using the provided Azure credentials.

After sign-in:

- Confirm the correct Azure account is displayed
- Confirm the **Payg-Lab2** subscription is selected
- Select:

```text
Open Explorer
```

This connects Storage Explorer to the Azure subscription and displays the available storage resources.

—
<img width="752" height="400" alt="image" src="https://github.com/user-attachments/assets/9c7c7dc8-32fb-45ce-8a37-255d9e0f4e4c" />


### Step 3 — Open Azure Cloud Shell

In the Azure Portal, open:

```text
Cloud Shell
```

Choose:

```text
Bash
```

In the setup pane, select:

| Setting | Value |
|---|---|
| Cloud Shell Option | No storage account required |
| Subscription | Payg-Lab2 |

Select:

```text
Create
```

This opens a Bash-based Azure Cloud Shell session for CLI resource creation.

---

### Step 4 — Create the Storage Account

Run the following command in Azure Cloud Shell:

```bash
az storage account create --name <storagename> --resource-group <resource-group-name> --sku Standard_LRS --kind StorageV2
```

Replace:

- `<storagename>` with a globally unique storage account name
- `<resource-group-name>` with the assigned lab resource group

This command creates a new Azure Storage Account using:

- Standard performance
- Locally-redundant storage (LRS)
- StorageV2 kind

After the command completes, note the storage account name.

—
<img width="1523" height="222" alt="image" src="https://github.com/user-attachments/assets/53dc4f5b-ac4b-4c2b-9f4c-60f7ef8cbbdf" />


### Step 5 — Locate the Storage Account in Storage Explorer

Return to **Azure Storage Explorer**.

In the **Explorer** pane:

1. Select:

```text
Refresh All
```

2. Expand:

```text
Payg-Lab2 Subscription
```

3. Locate the newly created storage account

Expand the storage account to reveal its storage service areas:

- Blob Containers
- File Shares
- Queues
- Tables

This confirms the storage account is visible and manageable through Storage Explorer.

---

### Step 6 — Create a Blob Container

In Storage Explorer, right-click:

```text
Blob Containers
```

Select:

```text
Create Blob Container
```

Enter the container name:

```text
demoblobcontainer1
```

Press Enter to create the container.

The new container appears in the resource tree and opens in a tab on the right side.

—


### Step 7 — Upload a Blob

Open the `demoblobcontainer1` container tab.

Select:

```text
Upload → Upload Files
```

In the upload dialog:

1. Select the ellipsis (`...`)
2. Browse to a small file on the local device
3. Select **Open**
4. Select **Upload**

After the upload finishes, the file appears in the container.

This confirms the blob was uploaded successfully to Azure Storage.

—
<img width="1523" height="763" alt="image" src="https://github.com/user-attachments/assets/8e33ecc4-7c94-45ad-8963-3cab7bc1b915" />


### Step 8 — Create a Queue

In Storage Explorer, expand the storage account and right-click:

```text
Queues
```

Select:

```text
Create Queue
```

Enter the queue name:

```text
demoqueue1
```

Press Enter to create the queue.

The queue appears in the resource tree and opens in a tab on the right side.

This queue can later be used by applications for message storage and asynchronous processing.

—
<img width="1523" height="656" alt="image" src="https://github.com/user-attachments/assets/8aa20476-ef85-43cc-8f7c-4cd42bf75a41" />


### Step 9 — Verify the Deployments in Azure Portal

Return to the Azure Portal and open the storage account.

From the left menu:

1. Select:

```text
Containers
```

2. Open:

```text
demoblobcontainer1
```

3. Confirm the uploaded file is visible

Then select:

```text
Queues
```

Confirm that:

```text
demoqueue1
```

is present.

This validates that both the blob container and queue were created successfully and are visible in the Azure Portal as well as in Storage Explorer.
<img width="1523" height="727" alt="image" src="https://github.com/user-attachments/assets/6fdb1dc9-961d-4cb0-b318-fac4e9e38037" />


### Azure CLI (Bash)

Create the storage account:

```bash
az storage account create \
  --name mystorageacct123 \
  --resource-group rg_eastus_XXXXX \
  --sku Standard_LRS \
  --kind StorageV2
```

Create the blob container:

```bash
az storage container create \
  --account-name mystorageacct123 \
  --name demoblobcontainer1
```

Upload a blob:

```bash
az storage blob upload \
  --account-name mystorageacct123 \
  --container-name demoblobcontainer1 \
  --name samplefile.txt \
  --file samplefile.txt
```

Create the queue:

```bash
az storage queue create \
  --account-name mystorageacct123 \
  --name demoqueue1
```

List blob containers:

```bash
az storage container list \
  --account-name mystorageacct123 \
  --output table
```

List queues:

```bash
az storage queue list \
  --account-name mystorageacct123 \
  --output table
```

### Azure PowerShell

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

Create the blob container:

```powershell
New-AzStorageContainer `
  -Name "demoblobcontainer1" `
  -Context $ctx
```

Upload a blob:

```powershell
Set-AzStorageBlobContent `
  -Context $ctx `
  -Container "demoblobcontainer1" `
  -File ".\samplefile.txt" `
  -Blob "samplefile.txt"
```

Create the queue:

```powershell
New-AzStorageQueue `
  -Name "demoqueue1" `
  -Context $ctx
```

View blob containers:

```powershell
Get-AzStorageContainer -Context $ctx
```

View queues:

```powershell
Get-AzStorageQueue -Context $ctx
```

## Implementation Walkthrough

The lab began by connecting **Azure Storage Explorer** to the assigned Azure subscription. This step established a desktop management interface for browsing and interacting with Azure Storage resources. After authenticating successfully and selecting the correct subscription, Storage Explorer displayed the account context required for later blob and queue operations.

Next, **Azure Cloud Shell** was used in Bash mode to create a new Azure Storage Account through the Azure CLI. This demonstrated an important operational pattern: core Azure resources can be provisioned through infrastructure commands, while day-to-day object management can then be performed through a graphical tool.

Once the storage account was visible in Storage Explorer, a blob container named `demoblobcontainer1` was created and a local file was uploaded into it. Then a queue named `demoqueue1` was created under the same storage account. Finally, both the container and queue were verified in the Azure Portal to confirm the storage resources were successfully deployed and accessible through multiple management interfaces.

## Results & Validation

| Test | Result |
|---|---|
| Azure Storage Explorer sign-in | Successful |
| Subscription connection | Successful |
| Storage account creation | Successful |
| Storage account visibility in Storage Explorer | Successful |
| Blob container creation | Successful |
| Blob file upload | Successful |
| Queue creation | Successful |
| Azure Portal verification | Successful |

Key observations:

- Azure Storage Explorer provided a convenient GUI for storage resource management
- The storage account created in Cloud Shell appeared after refreshing Storage Explorer
- Blob containers and queues could be created without using only the Azure Portal
- Uploaded files were immediately visible inside the blob container
- The same resources were visible in both Storage Explorer and the Azure Portal

## Validation Walkthrough

1. Verified that Azure Storage Explorer connected successfully to the **Payg-Lab2** subscription.
2. Opened Azure Cloud Shell in Bash mode and selected **No storage account required**.
3. Ran the storage account creation command and confirmed it completed successfully.
4. Returned to Storage Explorer and selected **Refresh All**.
5. Located the newly created storage account under the subscription tree.
6. Created the blob container `demoblobcontainer1`.
7. Uploaded a local file into the container and confirmed the blob appeared in the container tab.
8. Created the queue `demoqueue1`.
9. Opened the storage account in the Azure Portal.
10. Verified that the blob container existed and the uploaded file was present.
11. Verified that the queue `demoqueue1` existed under the storage account.

## Real-World Use Case

Azure Storage Explorer is useful when administrators need a quick and visual way to manage storage resources without relying only on scripts or portal navigation.

Example: **Operational Storage Management**

| Component | Role |
|---|---|
| Azure Cloud Shell | Creates core infrastructure |
| Azure Storage Explorer | Manages storage objects visually |
| Blob Container | Stores uploaded files |
| Queue | Holds application messages |
| Azure Portal | Validates resource deployment |

Typical workflow:

```text
Create Storage Account with CLI
            ↓
Open Storage Explorer
            ↓
Create Blob Container and Queue
            ↓
Upload Files and Inspect Resources
            ↓
Verify Deployment in Azure Portal
```

This pattern is useful for administrators supporting storage operations, application testing, troubleshooting message queues, and managing uploaded content across Azure environments.

## Key Takeaways

This lab demonstrated several important Azure storage administration concepts:

- Azure Storage Explorer provides a GUI-based interface for managing Azure Storage resources
- Azure CLI can be used to create storage infrastructure quickly from Cloud Shell
- Blob containers can be created and populated directly from Storage Explorer
- Queues can be created visually for application messaging scenarios
- Azure Portal and Storage Explorer together provide complementary management experiences

Understanding how to use Azure Storage Explorer is valuable for cloud administrators, support engineers, and operations teams that manage Azure Storage resources regularly.

