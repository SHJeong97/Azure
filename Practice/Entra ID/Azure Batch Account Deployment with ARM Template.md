# Azure Batch Account Deployment with ARM Template

## Introduction

Azure Batch is a cloud service used to run large-scale parallel and high-performance computing workloads in Azure. It helps automate job scheduling, task execution, and resource provisioning for compute-intensive processing without requiring administrators to manually manage all of the underlying infrastructure.

In this lab, an **ARM template** was reviewed and then deployed through **Azure Cloud Shell** to provision two connected resources:

- An **Azure Storage Account**
- An **Azure Batch Account**

The template used parameters, variables, resource dependencies, and outputs to automate the deployment. This lab demonstrates how Azure Resource Manager templates support repeatable infrastructure deployment and how Azure Batch can be integrated with a storage account for auto-storage functionality.

## Objectives

The objectives of this lab were to:

- Review the structure of an ARM template for Azure Batch deployment
- Understand ARM template parameters, variables, resources, and outputs
- Upload the ARM template into Azure Cloud Shell
- Deploy the template using Azure CLI
- Create an Azure Storage Account and Azure Batch Account through Infrastructure as Code
- Verify that the resources were created successfully in Azure Portal

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
                  +--------+--------+
                  | ARM Template    |
                  |  template.json  |
                  +--------+--------+
                           |
                    Azure Cloud Shell
                           |
          +----------------+----------------+
          |                                 |
+---------+---------+             +---------+---------+
| Storage Account   |             | Azure Batch       |
| StorageV2         |             | Account           |
| Standard_LRS      |             | AutoStorage Link  |
+---------+---------+             +---------+---------+
          |                                 |
          +--------------- resourceId ------+
```

This architecture shows an ARM template deploying both the storage account and the Azure Batch account, with the Batch account configured to use the storage account for auto-storage.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser session is recommended to avoid Azure portal cache issues.

---

### Step 2 — Explore the ARM Template

Download the ARM template file:

```text
template.json
```

Extract the zip file if required and review the template contents.

The template includes the following major sections:

| Section | Purpose |
|---|---|
| `$schema` | Defines the ARM template schema version |
| `contentVersion` | Tracks template version |
| `parameters` | Accepts deployment input values |
| `variables` | Builds reusable internal values |
| `resources` | Defines Azure resources to be deployed |
| `outputs` | Returns deployment values after completion |

#### Parameters

| Parameter | Purpose |
|---|---|
| `batchAccountName` | Sets the Azure Batch account name |
| `storageAccountsku` | Sets the storage account SKU |
| `location` | Sets the deployment region |

#### Variables

| Variable | Purpose |
|---|---|
| `storageAccountName` | Dynamically builds the storage account name |

#### Resources

| Resource Type | Purpose |
|---|---|
| `Microsoft.Storage/storageAccounts` | Creates the Azure Storage Account |
| `Microsoft.Batch/batchAccounts` | Creates the Azure Batch Account |

#### Resource Dependency

The Batch account uses:

```text
dependsOn
```

to ensure that the Storage Account is created first.

The Batch account also uses:

```text
autoStorage
```

to reference the Storage Account resource ID.

---

### Step 3 — Open Azure Cloud Shell

In Azure Portal, select:

```text
Cloud Shell
```

Choose:

```text
Bash
```

When prompted, select:

```text
No storage account required
```

Choose the available subscription and open the Bash session.

This provides a command-line environment for uploading the template and deploying the resources.

---

### Step 4 — Upload the ARM Template

In the Cloud Shell toolbar, select:

```text
Manage files → Upload
```

Upload:

```text
template.json
```

The file is uploaded into the Cloud Shell home directory and is ready for deployment.

---

### Step 5 — Deploy the ARM Template

Run the deployment command:

```bash
az deployment group create \
  --resource-group <resource-group-name> \
  --template-file template.json \
  --parameters batchAccountName=<batch-name> location=eastus
```

Replace:

- `<resource-group-name>` with the assigned resource group
- `<batch-name>` with the Azure Batch account name you want to deploy

This command provisions:

- A Storage Account
- An Azure Batch Account linked to that storage account

The deployment may take a few minutes to finish.

—
<img width="1523" height="158" alt="image" src="https://github.com/user-attachments/assets/994d66cd-4a7b-42d5-a164-ee6b51666dff" />


### Step 6 — Verify the Deployment

After the deployment completes successfully:

1. Review the output in Cloud Shell
2. Open the assigned resource group in Azure Portal
3. Confirm that the following resources exist:

- Azure Storage Account
- Azure Batch Account

This verifies that the ARM template executed successfully and created the required infrastructure.
<img width="1523" height="1017" alt="image" src="https://github.com/user-attachments/assets/01dde55d-68bd-4463-879a-60be464a5122" />


## Azure CLI (Bash)

Deploy the ARM template:

```bash
az deployment group create \
  --resource-group rg_eastus_XXXXX \
  --template-file template.json \
  --parameters batchAccountName=mybatchdemo123 location=eastus
```

Optional direct creation of the storage account:

```bash
az storage account create \
  --name mystoragedemo123 \
  --resource-group rg_eastus_XXXXX \
  --location eastus \
  --sku Standard_LRS \
  --kind StorageV2
```

Optional direct creation of the Batch account:

```bash
az batch account create \
  --name mybatchdemo123 \
  --resource-group rg_eastus_XXXXX \
  --location eastus \
  --storage-account mystoragedemo123
```

Show deployment details:

```bash
az deployment group show \
  --resource-group rg_eastus_XXXXX \
  --name <deployment-name>
```

List Batch accounts in the resource group:

```bash
az batch account list \
  --resource-group rg_eastus_XXXXX \
  --output table
```

## Azure PowerShell

Deploy the ARM template:

```powershell
New-AzResourceGroupDeployment `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -TemplateFile "template.json" `
  -batchAccountName "mybatchdemo123" `
  -location "eastus"
```

Optional direct creation of the storage account:

```powershell
New-AzStorageAccount `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "mystoragedemo123" `
  -Location "East US" `
  -SkuName "Standard_LRS" `
  -Kind "StorageV2"
```

Optional direct creation of the Batch account:

```powershell
New-AzBatchAccount `
  -AccountName "mybatchdemo123" `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Location "East US" `
  -AutoStorageAccountId "/subscriptions/<subscription-id>/resourceGroups/rg_eastus_XXXXX/providers/Microsoft.Storage/storageAccounts/mystoragedemo123"
```

View deployment details:

```powershell
Get-AzResourceGroupDeployment `
  -ResourceGroupName "rg_eastus_XXXXX"
```

View Batch accounts:

```powershell
Get-AzResource `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -ResourceType "Microsoft.Batch/batchAccounts"
```

## Implementation Walkthrough

The lab began by reviewing the ARM template structure to understand how Azure infrastructure could be defined declaratively. The template used parameters for deployment customization, a variable for generating the storage account name, and two Azure resources: a Storage Account and a Batch Account. The Batch Account referenced the Storage Account through the `autoStorage` property, and `dependsOn` ensured the correct deployment order.

Next, Azure Cloud Shell was opened in Bash mode so the template file could be uploaded and deployed without requiring any local CLI installation. The `template.json` file was uploaded directly into the Cloud Shell home directory and then executed with `az deployment group create`, passing in the resource group name, batch account name, and location.

After deployment, the Azure Portal resource group view was used to verify the results. Both the Storage Account and Azure Batch Account appeared in the resource group, confirming that the ARM template successfully provisioned the required infrastructure and linked the Batch account to its auto-storage account.

## Results & Validation

| Test | Result |
|---|---|
| ARM template review | Successful |
| Cloud Shell setup | Successful |
| Template upload | Successful |
| ARM template deployment | Successful |
| Storage account creation | Successful |
| Azure Batch account creation | Successful |
| Azure Portal verification | Successful |

Key observations:

- ARM templates allow repeatable Infrastructure as Code deployment
- Resource dependencies ensure correct provisioning order
- The Batch account successfully referenced the Storage Account as auto-storage
- Cloud Shell provided a simple deployment environment without local tooling
- Azure Portal verification confirmed the deployed resources were available

## Validation Walkthrough

1. Verified that `template.json` was downloaded and reviewed successfully.
2. Confirmed that the ARM template contained parameters, variables, resources, and outputs.
3. Opened Azure Cloud Shell in Bash mode.
4. Uploaded `template.json` into the Cloud Shell home directory.
5. Ran the deployment command with the required resource group, batch account name, and location.
6. Confirmed that the deployment command completed successfully in Azure CLI.
7. Opened the target resource group in Azure Portal.
8. Verified that the Storage Account was created.
9. Verified that the Azure Batch Account was created.
10. Confirmed that the Batch account deployment used the Storage Account for auto-storage.

## Real-World Use Case

Azure Batch is useful when organizations need to process large numbers of parallel compute tasks without building a custom scheduling platform.

Example: **Parallel Processing Workflow**

| Component | Role |
|---|---|
| ARM Template | Automates repeatable deployment |
| Storage Account | Stores task input/output and auto-storage data |
| Azure Batch Account | Manages batch workloads and compute jobs |
| Resource Group | Organizes deployment scope |

Typical workflow:

```text
ARM Template Deployed
          ↓
Storage Account Created
          ↓
Azure Batch Account Created
          ↓
Batch Uses AutoStorage for Job Data
          ↓
Compute Workloads Can Be Submitted
```

This pattern is useful for rendering jobs, scientific simulations, data processing pipelines, and large-scale automation tasks that require repeatable infrastructure deployment.

## Key Takeaways

This lab demonstrated several important Azure infrastructure concepts:

- ARM templates enable Infrastructure as Code for Azure deployments
- Azure Batch accounts can be linked to Storage Accounts through auto-storage
- Parameters and variables make templates reusable and flexible
- `dependsOn` ensures resources are deployed in the correct order
- Azure Cloud Shell provides a simple way to deploy ARM templates without local setup

Understanding ARM template deployment for Azure Batch is valuable for cloud engineers, Azure administrators, and operations teams responsible for repeatable compute infrastructure provisioning.

