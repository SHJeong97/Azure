# Azure Storage Monitoring and Troubleshooting with Log Analytics

## Introduction

Azure Storage is a scalable cloud storage platform that supports blobs, files, tables, and queues for a wide range of workloads such as backups, application data, analytics, and content delivery. To operate storage securely and efficiently, administrators need visibility into how the storage account is being used.

Azure Log Analytics, part of Azure Monitor, provides centralized collection and querying of telemetry data. By sending storage diagnostic logs into a Log Analytics workspace, administrators can investigate operations such as blob uploads and downloads, identify access patterns, and troubleshoot unexpected usage or performance issues.

In this lab, an Azure Storage account was created, a blob container was added, three sample files were uploaded, a Log Analytics workspace was deployed, and a diagnostic setting was configured to send blob read events to Log Analytics. A blob download was then performed to generate activity, and a Kusto Query Language (KQL) query was used to retrieve and analyze the logged `GetBlob` operation.

## Objectives

The objectives of this lab were to:

- Create an Azure Storage account
- Create a blob container in the storage account
- Upload multiple sample blob files
- Create a Log Analytics workspace
- Configure diagnostic settings for blob read logging
- Download a blob to generate monitored storage activity
- Query blob read activity using KQL in Log Analytics
- Understand how Azure Storage telemetry supports troubleshooting and monitoring

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
          +----------------+----------------+
          |                                 |
+---------+---------+             +---------+---------+
| Storage Account   |             | Log Analytics     |
| Standard / GRS    |             | Workspace         |
| Hot Access Tier   |             | MonitorLAWorkspace|
+---------+---------+             +---------+---------+
          |                                 ^
          |                                 |
          |                         Diagnostic Setting
          |                           StorageRead Logs
          |                                 |
+---------+---------+                       |
| Blob Container    |                       |
| monitor-blobs-    |-----------------------+
| container         |
+---------+---------+
          |
+---------+---------+
| sample1.txt       |
| sample2.txt       |
| sample3.txt       |
+---------+---------+
          |
     Download Blob
          |
     GetBlob Event
          |
      KQL Query
```

This architecture shows Azure Storage sending blob read telemetry to a Log Analytics workspace through diagnostic settings, where KQL queries can be used to investigate download activity.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser session is recommended to avoid Azure portal cache issues.

---

### Step 2 — Create the Storage Account

Navigate to:

```text
Storage Accounts → Create
```

Configure the storage account with the following settings:

| Setting | Value |
|---|---|
| Subscription | Available subscription |
| Resource Group | Assigned resource group |
| Storage Account Name | Unique lowercase name |
| Region | Default lab region |
| Performance | Standard |
| Redundancy | Geo-redundant storage (GRS) |

Under the **Advanced** tab, verify:

| Setting | Value |
|---|---|
| Access Tier | Hot |

Review and create the storage account.

After deployment completes, select:

```text
Go to resource
```

—
<img width="1523" height="1520" alt="image" src="https://github.com/user-attachments/assets/4263089f-a33a-41da-a929-a0249964ddfc" />


### Step 3 — Add a Blob Container

From the storage account overview page, navigate to:

```text
Data storage → Containers
```

Select:

```text
+ Container
```

Create the container with:

| Setting | Value |
|---|---|
| Name | monitor-blobs-container |

Leave the remaining settings at default values and create the container.

---

### Step 4 — Upload Files to the Blob Container

Create three sample text files locally using Notepad.

#### sample1.txt

```text
Sample File 1 - Blob Monitoring Test

This is a test file for upload.
```

#### sample2.txt

```text
Sample File 2 - Blob Monitoring Test

This is another test file for upload.
```

#### sample3.txt

```text
Sample File 3 - Blob Monitoring Test

This is another test file for upload.
```

Return to the Azure Portal and open:

```text
monitor-blobs-container
```

Upload each file one at a time:

1. Upload `sample1.txt`
2. Wait approximately 1 minute
3. Upload `sample2.txt`
4. Wait approximately 1 minute
5. Upload `sample3.txt`

After the uploads are complete, wait a few more minutes so Azure has time to capture telemetry.

—
<img width="1523" height="589" alt="image" src="https://github.com/user-attachments/assets/5d80b0e0-c3c5-44f5-ac65-9aa490a1328a" />


### Step 5 — Create a Log Analytics Workspace

Navigate to:

```text
Log Analytics workspaces → Create
```

Configure the workspace:

| Setting | Value |
|---|---|
| Subscription | Available subscription |
| Resource Group | Assigned resource group |
| Name | MonitorLAWorkspace (or another unique name) |
| Region | Default lab region |

Review and create the workspace.

Wait for deployment to complete.

—
<img width="1389" height="698" alt="image" src="https://github.com/user-attachments/assets/2bd63eaf-8d01-4384-978f-38babd2027ed" />


### Step 6 — Create a Diagnostic Setting for the Storage Account

Return to the storage account and navigate to:

```text
Monitoring → Diagnostic settings
```

If prompted, choose the:

```text
blob
```

service.

Select:

```text
+ Add diagnostic setting
```

Configure the setting:

| Setting | Value |
|---|---|
| Diagnostic Setting Name | BlobStorageDiagnostics |
| Category | StorageRead |
| Destination | Send to Log Analytics workspace |
| Log Analytics Workspace | MonitorLAWorkspace |

Save the diagnostic setting.

This routes blob read events into Log Analytics.

—
<img width="1523" height="616" alt="image" src="https://github.com/user-attachments/assets/938bea24-07f0-44dd-8f30-dd23b607b0ae" />


### Step 7 — Download a Blob to Generate Activity

Navigate to:

```text
Data storage → Containers → monitor-blobs-container
```

Locate one of the uploaded files.

Select the ellipsis (`...`) next to the file and choose:

```text
Download
```

This triggers a blob read operation that will appear as a `GetBlob` event in the logs.

---

### Step 8 — View Logged Activity with a Log Analytics Query

From the storage account, navigate to:

```text
Monitoring → Logs
```

Close the **Queries hub** window if it appears.

Switch to **KQL mode** and paste the following query:

```kusto
StorageBlobLogs
| where TimeGenerated > ago(1h) and OperationName == "GetBlob"
| project TimeGenerated, AuthenticationType, RequesterObjectId, OperationName, Uri
```

Select:

```text
Run
```

Expected result:

- The query returns blob download activity from the past hour
- The results include:
  - `TimeGenerated`
  - `AuthenticationType`
  - `RequesterObjectId`
  - `OperationName`
  - `Uri`

This confirms that the blob download event was captured and stored in Log Analytics.
<img width="1523" height="331" alt="image" src="https://github.com/user-attachments/assets/006104b4-b9ca-4c4d-add3-59dcb653f6da" />


### Azure CLI (Bash)

Create the storage account:

```bash
az storage account create \
  --name mystoragemonitor123 \
  --resource-group rg_eastus_XXXXX \
  --location eastus \
  --sku Standard_GRS \
  --kind StorageV2 \
  --access-tier Hot
```

Create the blob container:

```bash
az storage container create \
  --account-name mystoragemonitor123 \
  --name monitor-blobs-container
```

Upload the sample files:

```bash
az storage blob upload \
  --account-name mystoragemonitor123 \
  --container-name monitor-blobs-container \
  --name sample1.txt \
  --file sample1.txt
```

```bash
az storage blob upload \
  --account-name mystoragemonitor123 \
  --container-name monitor-blobs-container \
  --name sample2.txt \
  --file sample2.txt
```

```bash
az storage blob upload \
  --account-name mystoragemonitor123 \
  --container-name monitor-blobs-container \
  --name sample3.txt \
  --file sample3.txt
```

Create the Log Analytics workspace:

```bash
az monitor log-analytics workspace create \
  --resource-group rg_eastus_XXXXX \
  --workspace-name MonitorLAWorkspace \
  --location eastus
```

Create the diagnostic setting:

```bash
az monitor diagnostic-settings create \
  --name BlobStorageDiagnostics \
  --resource "/subscriptions/<subscription-id>/resourceGroups/rg_eastus_XXXXX/providers/Microsoft.Storage/storageAccounts/mystoragemonitor123/blobServices/default" \
  --workspace "/subscriptions/<subscription-id>/resourceGroups/rg_eastus_XXXXX/providers/Microsoft.OperationalInsights/workspaces/MonitorLAWorkspace" \
  --logs '[{"category":"StorageRead","enabled":true}]'
```

Download a blob:

```bash
az storage blob download \
  --account-name mystoragemonitor123 \
  --container-name monitor-blobs-container \
  --name sample1.txt \
  --file downloaded-sample1.txt
```

### Azure PowerShell

Create the storage account:

```powershell
New-AzStorageAccount `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "mystoragemonitor123" `
  -Location "East US" `
  -SkuName "Standard_GRS" `
  -Kind "StorageV2" `
  -AccessTier "Hot"
```

Get the storage context:

```powershell
$ctx = (Get-AzStorageAccount `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "mystoragemonitor123").Context
```

Create the blob container:

```powershell
New-AzStorageContainer `
  -Name "monitor-blobs-container" `
  -Context $ctx
```

Upload the sample files:

```powershell
Set-AzStorageBlobContent `
  -Context $ctx `
  -Container "monitor-blobs-container" `
  -File ".\sample1.txt" `
  -Blob "sample1.txt"
```

```powershell
Set-AzStorageBlobContent `
  -Context $ctx `
  -Container "monitor-blobs-container" `
  -File ".\sample2.txt" `
  -Blob "sample2.txt"
```

```powershell
Set-AzStorageBlobContent `
  -Context $ctx `
  -Container "monitor-blobs-container" `
  -File ".\sample3.txt" `
  -Blob "sample3.txt"
```

Create the Log Analytics workspace:

```powershell
New-AzOperationalInsightsWorkspace `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "MonitorLAWorkspace" `
  -Location "East US" `
  -Sku "PerGB2018"
```

Download a blob to generate activity:

```powershell
Get-AzStorageBlobContent `
  -Context $ctx `
  -Container "monitor-blobs-container" `
  -Blob "sample1.txt" `
  -Destination ".\downloaded-sample1.txt"
```

## Implementation Walkthrough

The lab began by creating an Azure Storage account configured with **Standard** performance, **Geo-redundant storage (GRS)**, and the **Hot** blob access tier. A blob container named `monitor-blobs-container` was then created inside the account, and three sample text files were uploaded at short intervals. This generated blob activity that could later be observed in monitoring data.

Next, a Log Analytics workspace was created to serve as the centralized destination for storage diagnostic telemetry. After the workspace was provisioned, the storage account’s **Diagnostic settings** were configured for the **blob service**, and the `StorageRead` category was enabled. This routed blob read activity into the Log Analytics workspace.

To generate a tracked read operation, one of the uploaded blobs was downloaded from the container. Finally, the **Logs** interface for the storage account was opened, and a KQL query was executed against the `StorageBlobLogs` table. The query filtered for `GetBlob` operations within the last hour and displayed details such as the request time, authentication type, requester identity, operation name, and blob URI. This validated that the storage account telemetry was being collected and could be queried for troubleshooting and monitoring.

## Results & Validation

| Test | Result |
|---|---|
| Storage account creation | Successful |
| Blob container creation | Successful |
| Blob uploads | Successful |
| Log Analytics workspace creation | Successful |
| Diagnostic setting creation | Successful |
| Blob download to generate activity | Successful |
| KQL query execution | Successful |
| GetBlob log visibility | Successful |

Key observations:

- Azure Storage activity can be captured and queried through Log Analytics
- Blob uploads created content, but the `StorageRead` category specifically tracked read activity
- Downloading a blob generated a `GetBlob` event
- KQL made it possible to filter and project only the relevant details for troubleshooting
- Centralized telemetry collection improves visibility into storage access behavior

## Validation Walkthrough

1. Verified that the storage account was created successfully in the assigned resource group.
2. Confirmed that the storage account used **Standard** performance, **GRS**, and **Hot** access tier.
3. Created the `monitor-blobs-container` container successfully.
4. Uploaded `sample1.txt`, `sample2.txt`, and `sample3.txt` into the container.
5. Verified that the Log Analytics workspace was created successfully.
6. Configured the storage account diagnostic setting named `BlobStorageDiagnostics`.
7. Confirmed that the `StorageRead` category was enabled and pointed to the Log Analytics workspace.
8. Downloaded one of the uploaded blobs from the container.
9. Opened the **Logs** blade for the storage account and switched to KQL mode.
10. Ran the `StorageBlobLogs` query filtered on `OperationName == "GetBlob"`.
11. Confirmed that the results included the blob read event and displayed the expected columns.

## Real-World Use Case

This monitoring pattern is useful when administrators need visibility into storage access, operational behavior, or troubleshooting activity.

Example: **Blob Access Monitoring and Troubleshooting**

| Component | Role |
|---|---|
| Storage Account | Stores business or application data |
| Blob Container | Holds uploaded files |
| Diagnostic Setting | Routes telemetry to monitoring workspace |
| Log Analytics Workspace | Centralized log storage and analysis |
| KQL Query | Filters and investigates blob operations |

Typical workflow:

```text
User or App Uploads and Downloads Blobs
               ↓
Storage Diagnostic Setting Captures Read Activity
               ↓
Logs Sent to Log Analytics Workspace
               ↓
Administrator Runs KQL Query
               ↓
GetBlob Operations Are Analyzed
```

This pattern is useful for security review, troubleshooting unexpected access, monitoring usage trends, and validating that storage operations are occurring as expected.

## Key Takeaways

This lab demonstrated several important Azure monitoring and storage concepts:

- Azure Storage diagnostic settings can send telemetry to Log Analytics
- Blob read operations can be captured through the `StorageRead` category
- Log Analytics provides centralized query-based investigation of storage activity
- Kusto Query Language enables detailed filtering and projection of Azure logs
- Monitoring storage access patterns improves troubleshooting, visibility, and operational awareness

Understanding Azure Storage monitoring with Log Analytics is valuable for cloud administrators, support engineers, and operations teams responsible for troubleshooting and securing Azure storage environments.

