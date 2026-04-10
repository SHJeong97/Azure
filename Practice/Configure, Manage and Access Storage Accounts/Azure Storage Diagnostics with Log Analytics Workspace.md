# Azure Storage Diagnostics with Log Analytics Workspace

## Introduction

Azure Monitor and Log Analytics provide centralized monitoring, telemetry collection, and analysis for Azure resources. By enabling diagnostic settings on a resource, administrators can forward logs and metrics to a Log Analytics workspace for investigation, reporting, and operational visibility.

In this lab, a **Log Analytics workspace** was created, a **Storage Account** was deployed, and **diagnostic settings** were configured to send storage logs and metrics to Log Analytics. A blob container was then created, a file was uploaded, and a built-in query called **Frequent operations chart** was used to visualize storage activity.

This lab demonstrates how Azure administrators can move from simple resource deployment to basic monitoring and observability.

---

## Objectives

The objectives of this lab were to:

- Create an Azure Log Analytics workspace
- Deploy an Azure Storage Account
- Configure diagnostic settings for blob storage
- Send storage logs and metrics to Log Analytics
- Create a blob container and upload a file
- Run a log query to analyze storage operations
- Understand how Azure monitoring supports troubleshooting and visibility

---

## Architecture Diagram

```
                +----------------------+
                |   Azure Subscription |
                +----------+-----------+
                           |
                +----------+-----------+
                |       Resource Group |
                |  rg_centralindia_xxx |
                +----------+-----------+
                           |
          +----------------+----------------+
          |                                 |
+---------+---------+             +---------+---------+
| Log Analytics     |             | Storage Account   |
| Workspace         |             | Standard / LRS    |
| demoAnalytics...  |             +---------+---------+
+---------+---------+                       |
          ^                                 |
          |                                 |
          |                      +----------+----------+
          |                      | Diagnostic Settings |
          |                      | StorageRead         |
          |                      | StorageWrite        |
          |                      | StorageDelete       |
          |                      | Transaction Metrics |
          |                      +----------+----------+
          |                                 |
          |                      +----------+----------+
          |                      | Blob Container      |
          |                      | blob                |
          |                      +----------+----------+
          |                                 |
          +-------------------------- Uploaded Blob
```

This architecture shows how Azure Storage diagnostics forward operational logs and metrics to a Log Analytics workspace for centralized monitoring and query-based analysis.

---

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser window is recommended to avoid cached authentication issues.

---

### Step 2 — Create a Log Analytics Workspace

Navigate to:

```text
Create a resource → Log Analytics Workspace
```

Configure the workspace with the following settings:

| Setting | Value |
|---|---|
| Resource Group | rg_centralindia_XXXXX |
| Name | demoAnalyticsWorkspace |
| Region | Central India |

Review the configuration and create the workspace.

—<img width="1523" height="1117" alt="image" src="https://github.com/user-attachments/assets/e6657523-2dbc-438a-9e28-5cf30960666b" />


### Step 3 — Create a Storage Account

Navigate to:

```text
Storage Accounts → Create
```

Configure the storage account:

| Setting | Value |
|---|---|
| Resource Group | rg_centralindia_XXXXX |
| Storage Account Name | Unique name |
| Region | Central India |
| Performance | Standard |
| Redundancy | LRS |

Under the **Advanced** tab, enable:

```text
Allow enabling anonymous access on individual containers
```

Review and create the storage account.

---
<img width="1523" height="1569" alt="image" src="https://github.com/user-attachments/assets/0099f079-3e6e-472f-b4ee-f56005656682" />

### Step 4 — Configure Diagnostic Settings

From the storage account, navigate to:

```text
Monitoring → Diagnostic settings
```

Enable blob service diagnostics and create a diagnostic setting with the following configuration:

| Setting | Value |
|---|---|
| Diagnostic Setting Name | send logs to analyticsWorkspace |
| Logs | StorageRead, StorageWrite, StorageDelete |
| Metrics | Transaction |
| Destination | Log Analytics Workspace |
| Workspace | demoAnalyticsWorkspace |

Save the diagnostic setting.

This forwards storage activity logs and metrics to the Log Analytics workspace.

—
<img width="1523" height="963" alt="image" src="https://github.com/user-attachments/assets/726613cb-4a61-47f5-afca-68ea7c4ebfcf" />


### Step 5 — Create Container and Upload Blob

Navigate to:

```text
Storage Account → Containers → + Container
```

Configure the container:

| Setting | Value |
|---|---|
| Name | blob |
| Public Access Level | Blob |

Open the container and upload a file from your system.

This action generates storage operations that can later appear in the collected logs.

—
<img width="1120" height="903" alt="image" src="https://github.com/user-attachments/assets/19eabfd5-d758-4669-bd63-0f7e2f7e8af8" />


### Step 6 — Run Log Query in Log Analytics

Open the Log Analytics workspace and navigate to:

```text
Logs
```

Search for the built-in query:

```text
Frequent operations chart
```

Run the query.

If logs do not appear immediately, wait **5–10 minutes** and run the query again.

The results will display as a **pie chart**, showing the most frequent storage operations captured by diagnostics.

—
<img width="1448" height="916" alt="image" src="https://github.com/user-attachments/assets/2e368d25-ad2a-4962-857d-cd083d1badca" />
<img width="1523" height="969" alt="image" src="https://github.com/user-attachments/assets/1205a64f-f1da-4a20-aaf7-cbaabb8f89fa" />



### Azure CLI (Bash)

Create the Log Analytics workspace:

```bash
az monitor log-analytics workspace create \
  --resource-group rg_centralindia_XXXXX \
  --workspace-name demoAnalyticsWorkspace \
  --location centralindia
```

Create the storage account:

```bash
az storage account create \
  --name mystorageacct123 \
  --resource-group rg_centralindia_XXXXX \
  --location centralindia \
  --sku Standard_LRS
```

Create a blob container:

```bash
az storage container create \
  --name blob \
  --public-access blob \
  --account-name mystorageacct123
```

Upload a blob:

```bash
az storage blob upload \
  --container-name blob \
  --file sample.txt \
  --name sample.txt \
  --account-name mystorageacct123
```

Create diagnostic settings:

```bash
az monitor diagnostic-settings create \
  --name "send logs to analyticsWorkspace" \
  --resource "/subscriptions/<subscription-id>/resourceGroups/rg_centralindia_XXXXX/providers/Microsoft.Storage/storageAccounts/mystorageacct123/blobServices/default" \
  --workspace "/subscriptions/<subscription-id>/resourceGroups/rg_centralindia_XXXXX/providers/Microsoft.OperationalInsights/workspaces/demoAnalyticsWorkspace" \
  --logs '[{"category":"StorageRead","enabled":true},{"category":"StorageWrite","enabled":true},{"category":"StorageDelete","enabled":true}]' \
  --metrics '[{"category":"Transaction","enabled":true}]'
```

---

### Azure PowerShell

Create the Log Analytics workspace:

```powershell
New-AzOperationalInsightsWorkspace `
  -ResourceGroupName "rg_centralindia_XXXXX" `
  -Name "demoAnalyticsWorkspace" `
  -Location "Central India" `
  -Sku "PerGB2018"
```

Create the storage account:

```powershell
New-AzStorageAccount `
  -ResourceGroupName "rg_centralindia_XXXXX" `
  -Name "mystorageacct123" `
  -Location "Central India" `
  -SkuName "Standard_LRS" `
  -Kind "StorageV2"
```

Create the blob container:

```powershell
$ctx = (Get-AzStorageAccount -ResourceGroupName "rg_centralindia_XXXXX" -Name "mystorageacct123").Context

New-AzStorageContainer `
  -Name "blob" `
  -Permission Blob `
  -Context $ctx
```

Upload a blob:

```powershell
Set-AzStorageBlobContent `
  -File "sample.txt" `
  -Container "blob" `
  -Blob "sample.txt" `
  -Context $ctx
```

Create diagnostic settings:

```powershell
$workspace = Get-AzOperationalInsightsWorkspace -ResourceGroupName "rg_centralindia_XXXXX" -Name "demoAnalyticsWorkspace"
$storage = Get-AzStorageAccount -ResourceGroupName "rg_centralindia_XXXXX" -Name "mystorageacct123"

Set-AzDiagnosticSetting `
  -Name "send logs to analyticsWorkspace" `
  -ResourceId "$($storage.Id)/blobServices/default" `
  -WorkspaceId $workspace.ResourceId `
  -Enabled $true
```

---

## Implementation Walkthrough

This lab demonstrated how Azure monitoring can be applied to a storage resource.

First, a **Log Analytics workspace** was created to serve as the centralized destination for logs and metrics. Next, a **Storage Account** was deployed and configured. Diagnostic settings were then enabled specifically for blob service operations, including **StorageRead**, **StorageWrite**, **StorageDelete**, and **Transaction metrics**.

After that, a blob container was created and a file was uploaded to generate storage activity. Finally, the Log Analytics workspace was used to run the **Frequent operations chart** query, which visually summarized the recorded storage events.

This workflow demonstrates a practical Azure observability pattern:

- Resource generates logs
- Diagnostic settings forward telemetry
- Log Analytics collects and analyzes data

---

## Results & Validation

| Test | Result |
|---|---|
| Log Analytics workspace creation | Successful |
| Storage account deployment | Successful |
| Diagnostic settings configuration | Successful |
| Container creation | Successful |
| Blob upload | Successful |
| Log query execution | Successful |

Key observations:

- Storage operations can be forwarded to a centralized Log Analytics workspace
- Blob activity generates actionable logs and metrics
- Built-in queries simplify analysis and visualization
- There may be a short ingestion delay before logs appear

---

## Validation Walkthrough

1. Verified that the Log Analytics workspace `demoAnalyticsWorkspace` was successfully created.
2. Verified that the storage account was deployed in the same resource group.
3. Opened diagnostic settings for the blob service.
4. Confirmed that `StorageRead`, `StorageWrite`, `StorageDelete`, and `Transaction` were enabled.
5. Confirmed the destination was set to the Log Analytics workspace.
6. Created the `blob` container and uploaded a test file.
7. Opened the Log Analytics workspace and ran the **Frequent operations chart** query.
8. Verified that storage activity appeared in the results after log ingestion completed.

---

## Real-World Use Case

Azure Storage diagnostics and Log Analytics are commonly used for **monitoring, troubleshooting, and audit visibility**.

Example: **Operational Monitoring for Storage Workloads**

| Component | Role |
|---|---|
| Storage Account | Generates blob activity |
| Diagnostic Settings | Forwards logs and metrics |
| Log Analytics Workspace | Centralized analysis |
| Queries / Charts | Visualize operations and trends |

Typical workflow:

```text
Blob Upload / Read / Delete
        ↓
Diagnostic Settings Collect Telemetry
        ↓
Log Analytics Workspace Stores Logs
        ↓
Admin Runs Queries for Monitoring and Troubleshooting
```

This approach helps administrators identify abnormal access patterns, monitor workload activity, and support operational investigations.

---

## Key Takeaways

This lab demonstrated several important Azure monitoring concepts:

- Log Analytics provides centralized analysis for Azure telemetry
- Diagnostic settings allow resource logs and metrics to be routed to monitoring destinations
- Azure Storage blob operations can be monitored through collected logs
- Built-in queries such as **Frequent operations chart** simplify data visualization
- Monitoring and observability are essential for troubleshooting, audit readiness, and operational awareness

Understanding diagnostic settings and Log Analytics is essential for cloud administrators, Azure engineers, and operations teams responsible for monitoring Azure environments.

