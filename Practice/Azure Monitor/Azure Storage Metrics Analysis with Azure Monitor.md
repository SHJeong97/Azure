# Azure Storage Metrics Analysis with Azure Monitor

## Introduction

Azure Storage metrics provide near real-time visibility into the performance, health, and usage patterns of storage accounts. By analyzing metrics such as ingress, egress, availability, and latency, administrators can identify trends, troubleshoot issues, and understand how storage services are being used.

In this lab, an Azure Storage account was created with **Geo-redundant storage (GRS)** and **Hot** blob access tier. A blob container was added, three sample files were uploaded, and Azure Monitor Metrics was used to visualize **Ingress** activity. The metric view was then refined by splitting data by **API name** and filtering specifically for the **PutBlob** operation to isolate direct upload traffic.

This lab demonstrates how Azure Monitor can be used to investigate storage behavior and understand which API operations are driving storage activity.

## Objectives

The objectives of this lab were to:

- Create an Azure Storage account
- Create a blob container in the storage account
- Upload multiple sample files to generate storage activity
- Visualize blob storage metrics in Azure Monitor
- Review the **Ingress** metric for uploaded data
- Split metrics by **API name**
- Filter metrics to isolate the **PutBlob** operation
- Understand how Azure Storage metrics support monitoring and troubleshooting

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
                    +------+------+
                    | Storage     |
                    | Account     |
                    | Standard GRS|
                    | Hot Tier    |
                    +------+------+
                           |
                    +------+------+
                    | Blob         |
                    | Container    |
                    | monitor-     |
                    | blobs-       |
                    | container    |
                    +------+------+
                           |
         +-----------------+-----------------+
         |                 |                 |
+--------+--------+ +------+--------+ +------+--------+
| sample1.txt     | | sample2.txt   | | sample3.txt   |
| Uploaded Blob   | | Uploaded Blob | | Uploaded Blob |
+-----------------+ +---------------+ +---------------+
                           |
                    +------+------+
                    | Azure Monitor|
                    | Metrics      |
                    +------+------+
                           |
         +-----------------+-----------------+
         |                                   |
+--------+--------+                 +--------+--------+
| Split by API    |                 | Filter API      |
| API Name        |                 | PutBlob         |
+-----------------+                 +-----------------+
```

This architecture shows blob upload activity flowing into Azure Storage, with Azure Monitor Metrics used to visualize total ingress, split the metric by API name, and isolate direct upload operations using a filter.

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

Configure the storage account with the following values:

| Setting | Value |
|---|---|
| Subscription | Available subscription |
| Resource Group | Available resource group |
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

Leave the default settings unchanged and create the container.

---
<img width="1523" height="1622" alt="image" src="https://github.com/user-attachments/assets/55d2ad3a-6782-493f-8365-2601fc1e2f33" />

### Step 4 — Upload Files to the Blob Container

Create the following local text files:

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

In the Azure Portal:

1. Open `monitor-blobs-container`
2. Select **Upload**
3. Upload `sample1.txt`
4. Wait approximately 1 minute
5. Upload `sample2.txt`
6. Wait approximately 1 minute
7. Upload `sample3.txt`

After all three uploads are complete, wait a few minutes so Azure Monitor has time to record the related metrics.

—


### Step 5 — Visualize Blob Storage Metrics

From the storage account, navigate to:

```text
Monitoring → Metrics
```

Configure the metrics view:

| Setting | Value |
|---|---|
| Time Range | Last hour |
| Time Granularity | Automatic |
| Chart Type | Bar chart |
| Metric Namespace | Blob |
| Metric | Ingress |

Apply the settings.

The chart displays upload-related ingress activity for the blob storage account. Each bar corresponds to bytes ingressed during blob upload operations.

—


### Step 6 — Split Metrics by API

In the Metrics view, select:

```text
Apply splitting
```

Configure the split dimension:

| Setting | Value |
|---|---|
| Splitting Dimension | API name |

This updates the chart so ingress traffic is grouped by the API operations that generated it.

—


### Step 7 — Filter Metrics

In the same Metrics view, select:

```text
Add filter
```

Configure the filter:

| Setting | Value |
|---|---|
| Property | API name |
| Value | PutBlob |

This narrows the chart so only ingress activity generated by the `PutBlob` API is shown.

The final chart isolates the direct blob upload operations and excludes other auxiliary or background storage API calls.

## Azure CLI (Bash)

Create the storage account:

```bash
az storage account create \
  --name mystoragemetrics123 \
  --resource-group rg_eastus_XXXXX \
  --location eastus \
  --sku Standard_GRS \
  --kind StorageV2 \
  --access-tier Hot
```

Create the blob container:

```bash
az storage container create \
  --account-name mystoragemetrics123 \
  --name monitor-blobs-container
```

Upload the sample files:

```bash
az storage blob upload \
  --account-name mystoragemetrics123 \
  --container-name monitor-blobs-container \
  --name sample1.txt \
  --file sample1.txt
```

```bash
az storage blob upload \
  --account-name mystoragemetrics123 \
  --container-name monitor-blobs-container \
  --name sample2.txt \
  --file sample2.txt
```

```bash
az storage blob upload \
  --account-name mystoragemetrics123 \
  --container-name monitor-blobs-container \
  --name sample3.txt \
  --file sample3.txt
```

List blob containers:

```bash
az storage container list \
  --account-name mystoragemetrics123 \
  --output table
```

List uploaded blobs:

```bash
az storage blob list \
  --account-name mystoragemetrics123 \
  --container-name monitor-blobs-container \
  --output table
```

## Azure PowerShell

Create the storage account:

```powershell
New-AzStorageAccount `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "mystoragemetrics123" `
  -Location "East US" `
  -SkuName "Standard_GRS" `
  -Kind "StorageV2" `
  -AccessTier "Hot"
```

Get the storage context:

```powershell
$ctx = (Get-AzStorageAccount `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "mystoragemetrics123").Context
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

List containers:

```powershell
Get-AzStorageContainer -Context $ctx
```

List blobs:

```powershell
Get-AzStorageBlob `
  -Context $ctx `
  -Container "monitor-blobs-container"
```

## Implementation Walkthrough

The lab began by creating an Azure Storage account configured with **Standard** performance, **Geo-redundant storage (GRS)**, and the **Hot** access tier. This provided the storage platform needed to generate measurable blob transaction activity. A blob container named `monitor-blobs-container` was then created to store the files used for metric generation.

Next, three sample text files were created locally and uploaded into the blob container at separate intervals. This staggered upload pattern was important because it created discrete storage events, making the Ingress metric easier to observe as separate bars in Azure Monitor.

After the uploads, the Metrics blade of the storage account was opened and configured to show the **Blob** metric namespace with the **Ingress** metric over the **Last hour** in a **Bar chart** format. This provided a visual view of uploaded data volume. The analysis was then refined in two ways: first by applying **splitting** on the **API name** dimension, and second by applying a **filter** for only the `PutBlob` API. This isolated the actual upload operation and removed unrelated storage activity from the chart.

## Results & Validation

| Test | Result |
|---|---|
| Storage account creation | Successful |
| Blob container creation | Successful |
| sample1.txt upload | Successful |
| sample2.txt upload | Successful |
| sample3.txt upload | Successful |
| Ingress metric visualization | Successful |
| Metric split by API name | Successful |
| PutBlob filter application | Successful |

Key observations:

- Azure Monitor captured blob ingress activity generated by file uploads
- The bar chart made separate upload events easier to interpret visually
- Splitting by API name provided a more granular view of what operations generated traffic
- Filtering on `PutBlob` isolated the direct blob upload API calls
- Azure Storage metrics can be used for performance investigation and operational analysis

## Validation Walkthrough

1. Verified that the storage account was created successfully in the assigned resource group.
2. Confirmed that the storage account used **Standard** performance, **GRS**, and **Hot** access tier.
3. Created the `monitor-blobs-container` blob container.
4. Uploaded `sample1.txt`, `sample2.txt`, and `sample3.txt` successfully.
5. Waited between uploads to generate distinct metric entries.
6. Opened the **Metrics** blade for the storage account.
7. Configured the chart to use **Blob** namespace and **Ingress** metric.
8. Changed the chart type to **Bar chart** and verified ingress bars were visible.
9. Applied **splitting** by **API name** and confirmed the chart updated.
10. Added a filter for **API name = PutBlob**.
11. Confirmed that the final chart displayed only ingress activity generated by `PutBlob`.

## Real-World Use Case

Azure Storage metrics are useful when administrators need quick visibility into storage behavior without starting with full log analysis.

Example: **Blob Upload Trend Analysis**

| Component | Role |
|---|---|
| Storage Account | Hosts blob data |
| Blob Container | Stores uploaded files |
| Azure Monitor Metrics | Visualizes storage performance and usage |
| API Split | Shows which operations generated traffic |
| PutBlob Filter | Isolates direct upload events |

Typical workflow:

```text
Application Uploads Files to Blob Storage
                ↓
Azure Storage Generates Ingress Activity
                ↓
Azure Monitor Captures Metrics
                ↓
Admin Splits by API Name
                ↓
Admin Filters for PutBlob to Confirm Upload Pattern
```

This pattern is useful for storage troubleshooting, usage analysis, upload validation, anomaly detection, and understanding how applications interact with Azure Blob Storage.

## Key Takeaways

This lab demonstrated several important Azure monitoring concepts:

- Azure Storage metrics provide near real-time visibility into storage activity
- The **Ingress** metric shows the volume of uploaded data
- Splitting metrics by **API name** helps identify which operations generated traffic
- Filtering metrics isolates the most relevant storage behavior for analysis
- Azure Monitor Metrics is a fast and effective tool for troubleshooting and performance investigation

Understanding Azure Storage metrics is valuable for cloud administrators, support engineers, and operations teams responsible for monitoring storage health, usage, and performance.

