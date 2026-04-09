# Azure Blob Storage Access Tiers (Hot, Cool, Archive)

## Introduction

Azure Blob Storage is a scalable object storage service designed to store large volumes of unstructured data such as documents, images, backups, logs, and media files. One of its most powerful features is **Access Tiering**, which allows organizations to optimize storage costs by storing data based on how frequently it is accessed.

Azure provides three main access tiers:

| Access Tier | Description | Ideal Use Case |
|--------------|-------------|----------------|
| Hot | Optimized for frequently accessed data | Active application data |
| Cool | Lower storage cost but higher access cost | Infrequently accessed data |
| Archive | Lowest storage cost but highest retrieval latency | Long-term backup or compliance data |

In this lab, Azure Storage Accounts were created with **Cool and Hot access tiers**, containers were deployed, files were uploaded, and blob access tiers were modified to demonstrate lifecycle management in Azure Blob Storage.

---

## Objectives

The objectives of this lab were to:

- Deploy Azure Storage Accounts
- Configure storage tiers (Hot and Cool)
- Create Blob containers
- Upload files (blobs)
- Change blob access tiers to Archive
- Rehydrate archived data back to Hot
- Understand how storage tiers impact **cost, performance, and accessibility**

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
        +----------------+----------------+
        |                                 |
+---------------+                 +---------------+
| StorageAccount|                 | StorageAccount|
|   Cool Tier   |                 |    Hot Tier   |
| Standard LRS  |                 | Standard LRS  |
+-------+-------+                 +-------+-------+
        |                                 |
+---------------+                 +---------------+
| Blob Container|                 | Blob Container|
| democontainer1 |                 | democontainer2 |
+-------+-------+                 +-------+-------+
        |                                 |
    Uploaded File                     Uploaded File
        |                                 |
        +---------- Change Tier ----------+
                       |
                    Archive
                       |
                   Rehydrate
                       |
                      Hot
```

This architecture illustrates how Azure Blob Storage resources are structured and how data can move between access tiers for cost optimization.

---

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to:

```
https://portal.azure.com
```

Log in using the provided lab credentials.

If another account automatically signs in, log out or open the portal in **incognito mode**.

---

### Step 2 — Create Storage Account (Cool Tier)

Navigate to:

```
Storage Accounts → Create
```

Configuration:

| Setting | Value |
|------|------|
| Subscription | Pay-As-You-Go |
| Resource Group | rg_eastus_XXXXX |
| Region | East US |
| Performance | Standard |
| Redundancy | Locally Redundant Storage (LRS) |
| Access Tier | Cool |

After deployment, verify that the **default access tier is set to Cool**.
<img width="1523" height="1120" alt="image" src="https://github.com/user-attachments/assets/e40c19a2-7b32-47d8-b5fc-ffaf938d31e8" />

—


### Step 3 — Create Blob Container

Navigate to:

```
Storage Account → Data Storage → Containers
```

Create a container:

```
democontainer1
```

Upload a file from your local system.

The uploaded blob automatically inherits the **Cool access tier**.

---
<img width="1523" height="411" alt="image" src="https://github.com/user-attachments/assets/dad167f7-1aff-4928-b149-cc80d3088a82" />
<img width="1523" height="469" alt="image" src="https://github.com/user-attachments/assets/95e55009-d45a-41d9-805e-ee9f8f7497a0" />


### Step 4 — Create Storage Account (Hot Tier)

Create another storage account with the following configuration:

| Setting | Value |
|------|------|
| Subscription | Pay-As-You-Go |
| Resource Group | rg_eastus_XXXXX |
| Region | Central US |
| Performance | Standard |
| Redundancy | Locally Redundant Storage (LRS) |
| Access Tier | Hot |

After deployment, verify that the **default access tier is set to Hot**.

—
<img width="1523" height="1569" alt="image" src="https://github.com/user-attachments/assets/3a8b40fd-f972-4878-84dc-9f5011422080" />


### Step 5 — Upload File to Container

Create a new container:

```
democontainer2
```

Upload a file to the container.

Because the storage account uses the **Hot tier**, the file is optimized for frequent access.

—
<img width="1523" height="475" alt="image" src="https://github.com/user-attachments/assets/60bf4276-028e-4cbe-bf76-c99238d1ddcc" />


### Step 6 — Change Blob Access Tier

Open the uploaded blob and select:

```
Change Tier
```

Set the tier to:

```
Archive
```

Once archived:

- The file cannot be downloaded
- The contents cannot be viewed
- The blob must be **rehydrated** before access.

—
<img width="1523" height="759" alt="image" src="https://github.com/user-attachments/assets/c2fc0850-85b5-47d4-aa98-88c318377215" />


### Azure CLI (Bash)

Create storage account:

```bash
az storage account create \
  --name demostoragetest124 \
  --resource-group rg_eastus_XXXXX \
  --location eastus \
  --sku Standard_LRS \
  --kind StorageV2 \
  --access-tier Cool
```

Create container:

```bash
az storage container create \
  --name democontainer1 \
  --account-name demostoragetest124
```

Upload blob:

```bash
az storage blob upload \
  --container-name democontainer1 \
  --file sample.html \
  --name sample.html \
  --account-name demostoragetest124
```

Change blob tier to archive:

```bash
az storage blob set-tier \
  --container-name democontainer1 \
  --name sample.html \
  --tier Archive \
  --account-name demostoragetest124
```

---

### Azure PowerShell

Create storage account:

```powershell
New-AzStorageAccount `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "demostoragetest124" `
  -Location "EastUS" `
  -SkuName Standard_LRS `
  -Kind StorageV2 `
  -AccessTier Cool
```

Create container:

```powershell
$ctx = (Get-AzStorageAccount -ResourceGroupName "rg_eastus_XXXXX" -Name "demostoragetest124").Context

New-AzStorageContainer `
  -Name "democontainer1" `
  -Context $ctx
```

Upload blob:

```powershell
Set-AzStorageBlobContent `
  -File "sample.html" `
  -Container "democontainer1" `
  -Blob "sample.html" `
  -Context $ctx
```

Change blob tier to archive:

```powershell
Set-AzStorageBlobTier `
  -Container "democontainer1" `
  -Blob "sample.html" `
  -StandardBlobTier Archive `
  -Context $ctx
```

---

## Implementation Walkthrough

Two storage accounts were created to demonstrate how Azure manages different storage tiers.

| Storage Account | Tier | Purpose |
|---|---|---|
| Storage Account 1 | Cool | Data accessed occasionally |
| Storage Account 2 | Hot | Frequently accessed data |

Containers were created within each storage account to store blob files.

Once uploaded, Azure automatically assigned the **default storage tier**.

The lab also demonstrated how blob access tiers can be modified dynamically to support data lifecycle strategies.

---

## Results & Validation

| Test | Result |
|-----|------|
| Storage account deployment | Successful |
| Container creation | Successful |
| Blob upload | Successful |
| Archive tier change | Successful |
| Blob rehydration | Successful |

Key observations:

- Archive tier prevents immediate access to data
- Rehydration restores accessibility
- Storage tiers affect both **cost and retrieval latency**

---

## Validation Walkthrough

1. Verified storage accounts were created in the Azure Portal.
2. Confirmed the **default access tier** for each storage account.
3. Verified blob containers were successfully created.
4. Uploaded files and confirmed blobs appeared in the containers.
5. Changed a blob access tier to **Archive**.
6. Confirmed download and editing options were disabled.
7. Changed the tier back to **Hot**.
8. Waited for rehydration and verified the blob became accessible again.

---

## Real-World Use Case

Azure Blob Storage tiering is commonly used for **data lifecycle management**.

Example: **Video Streaming Platform**

| Data Type | Storage Tier |
|------|------|
| Newly uploaded videos | Hot |
| Older content | Cool |
| Compliance archives | Archive |

Lifecycle workflow:

```
New Content → Hot Tier
After 60 Days → Cool Tier
After 1 Year → Archive Tier
```

This strategy significantly reduces long-term storage costs while keeping frequently accessed data readily available.

---

## Key Takeaways

This lab demonstrated important Azure storage concepts:

- Azure Blob Storage supports multiple **access tiers for cost optimization**
- Hot tier is best for frequently accessed data
- Cool tier reduces costs for infrequently accessed data
- Archive tier provides the lowest storage cost but requires **rehydration before access**
- Storage lifecycle strategies help organizations reduce **cloud storage expenses**

Understanding access tiering is essential for cloud engineers, Azure administrators, and DevOps professionals responsible for managing scalable storage systems.


