# Azure Storage Account Immutable Blob Policy with Time-Based Retention

## Introduction

Azure Storage supports immutable blob storage to help protect critical data from modification or deletion for a defined retention period. This capability is important for compliance, audit requirements, records management, and security scenarios where stored data must remain unchanged after it is written.

In this lab, an Azure Storage Account was created, a blob container was deployed, and a file was uploaded into the container. A **time-based retention immutable policy** was then applied to the storage account so the uploaded blob could be read but not modified. Finally, an attempt was made to edit the uploaded file, and Azure correctly blocked the operation because the immutable policy was in effect.

## Objectives

The objectives of this lab were to:

- Create an Azure Storage Account
- Create a blob container inside the storage account
- Upload a file into the container
- Configure an immutable policy for the storage account
- Apply a **time-based retention** policy for 1 day
- Verify that the uploaded file could no longer be modified
- Understand the difference between **time-based retention** and **legal hold**

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
                    +------+------+
                           |
                    +------+------+
                    | Container    |
                    | democontainer1
                    +------+------+
                           |
                    +------+------+
                    | Blob File    |
                    | samplefile.txt
                    +------+------+
                           |
               +-----------+-----------+
               | Immutable Access      |
               | Policy                |
               | Time-based Retention  |
               | 1 Day                 |
               +-----------+-----------+
                           |
                 Read Allowed / Edit Blocked
```

This architecture shows a blob stored in an Azure container protected by a time-based immutable retention policy that prevents modification during the retention period.

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
Create a resource → Storage Account
```

Fill in the required deployment details for the assigned resource group and create the storage account.

After deployment completes:

1. Open the storage account
2. Select **Containers**
3. Create a new container

Container configuration:

| Setting | Value |
|---|---|
| Container Name | democontainer1 |
| Access Level | Based on lab selection |

After the container is created, open it and upload a file such as:

```text
samplefile.txt
```

Verify that the blob appears successfully in the container.

—
<img width="1523" height="995" alt="image" src="https://github.com/user-attachments/assets/d2114906-2b6d-4d16-b508-98ab131a68ac" />
<img width="1145" height="880" alt="image" src="https://github.com/user-attachments/assets/9ffc50d3-d368-4979-a841-9645055318c4" />



### Step 3 — Create an Immutable Policy

Inside the storage account, navigate to:

```text
Access Policy
```

Select:

```text
+ Add Policy
```

Configure the immutable policy with:

| Setting | Value |
|---|---|
| Policy Type | Time Based Retention |
| Retention Period | 1 Day |

Save the policy.

After saving, verify that the **time-based retention policy** is applied successfully.

#### Time-Based Retention vs Legal Hold

| Policy Type | Behavior |
|---|---|
| Time-based retention | Protects data for a fixed number of days; data can be created and read but not modified or deleted during retention |
| Legal hold | Protects data until the hold is explicitly removed; data can be created and read but not modified or deleted |

—
<img width="1523" height="647" alt="image" src="https://github.com/user-attachments/assets/05a5b3c2-36ff-428f-8ea9-87bd2f1464d6" />


### Step 4 — Attempt to Edit the Uploaded File

Return to:

```text
Containers → democontainer1
```

Open the uploaded blob:

```text
samplefile.txt
```

Select:

```text
Edit
```

Try appending a new line such as:

```text
This is a new line
```

Then select:

```text
Save
```

Expected result:

- Azure blocks the edit operation
- The file cannot be modified because the immutable retention policy is active

This confirms the blob is protected from changes during the retention period.

<img width="1523" height="633" alt="image" src="https://github.com/user-attachments/assets/eb47e1ef-1f35-49de-a34d-781a1216e9ea" />


### Azure CLI (Bash)

Create the storage account:

```bash
az storage account create \
  --name mystorageacct123 \
  --resource-group rg_eastus_XXXXX \
  --location eastus \
  --sku Standard_LRS \
  --kind StorageV2
```

Create the container:

```bash
az storage container create \
  --name democontainer1 \
  --account-name mystorageacct123
```

Upload the blob:

```bash
az storage blob upload \
  --account-name mystorageacct123 \
  --container-name democontainer1 \
  --name samplefile.txt \
  --file samplefile.txt
```

Create an immutable time-based retention policy:

```bash
az storage container immutability-policy create \
  --account-name mystorageacct123 \
  --container-name democontainer1 \
  --period 1
```

View the immutable policy:

```bash
az storage container immutability-policy show \
  --account-name mystorageacct123 \
  --container-name democontainer1
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

Create the container:

```powershell
New-AzStorageContainer `
  -Name "democontainer1" `
  -Context $ctx
```

Upload the blob:

```powershell
Set-AzStorageBlobContent `
  -Context $ctx `
  -Container "democontainer1" `
  -File ".\samplefile.txt" `
  -Blob "samplefile.txt"
```

View container information:

```powershell
Get-AzStorageContainer `
  -Name "democontainer1" `
  -Context $ctx
```

## Implementation Walkthrough

The lab began by creating an Azure Storage Account and then creating a blob container named `democontainer1`. After the container was available, a file was uploaded successfully, confirming that the storage account was ready to accept blob data.

Next, an immutable access policy was created from the **Access Policy** section. For this lab, the selected protection type was **time-based retention** with a retention period of **1 day**. This configuration is significant because it allows the blob to remain readable while preventing modification or deletion during the active retention window.

To validate the behavior, the uploaded file was opened in edit mode and a new line was appended. When the save operation was attempted, Azure blocked the modification. This demonstrated that the immutable policy was functioning correctly and that the blob had become write-protected for the configured retention period.

## Results & Validation

| Test | Result |
|---|---|
| Storage account creation | Successful |
| Container creation | Successful |
| Blob upload | Successful |
| Immutable policy creation | Successful |
| Time-based retention set to 1 day | Successful |
| File edit attempt after policy | Blocked as expected |

Key observations:

- Azure allowed blob upload before the immutable policy restricted changes
- The time-based retention policy prevented file modification
- The blob remained readable but not editable
- Immutable policies are effective for protecting stored data from accidental or unauthorized changes

## Validation Walkthrough

1. Verified that the Azure Storage Account was created successfully.
2. Confirmed that the container `democontainer1` was created inside the storage account.
3. Uploaded `samplefile.txt` and verified that it appeared in the blob container.
4. Opened **Access Policy** and created a new immutable policy.
5. Selected **Time Based Retention** and set the retention period to **1 day**.
6. Confirmed that the policy was visible and active after saving.
7. Opened the uploaded file and selected **Edit**.
8. Attempted to append the line `This is a new line`.
9. Selected **Save** and confirmed that Azure blocked the edit operation.
10. Verified that the immutable policy prevented blob modification as expected.

## Real-World Use Case

Azure immutable blob storage is commonly used in environments where records must remain tamper-resistant.

Example: **Compliance and Audit Record Protection**

| Component | Role |
|---|---|
| Storage Account | Holds compliance data |
| Blob Container | Stores uploaded records |
| Immutable Policy | Prevents modification or deletion |
| Retention Period | Defines required preservation window |

Typical workflow:

```text
File Uploaded to Blob Storage
           ↓
Immutable Policy Applied
           ↓
Blob Can Be Read
           ↓
Edit or Delete Attempt Is Blocked
           ↓
Retention Period Expires
```

This pattern is useful for financial records, audit logs, legal records, security evidence, and regulated business documents that must not be altered after storage.

## Key Takeaways

This lab demonstrated several important Azure storage governance concepts:

- Azure Storage supports immutable blob protection for compliance and security scenarios
- Time-based retention policies prevent modification and deletion for a fixed duration
- Legal hold differs from time-based retention because it remains active until explicitly cleared
- Immutable storage helps protect records from tampering or accidental changes
- Validation through an edit attempt confirmed that the policy was working correctly

Understanding immutable storage policies is valuable for cloud administrators, compliance teams, security engineers, and operations teams responsible for protecting sensitive or regulated data in Azure.

