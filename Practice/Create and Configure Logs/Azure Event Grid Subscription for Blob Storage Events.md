# Azure Event Grid Subscription for Blob Storage Events

## Introduction

Azure Event Grid is an event routing service that enables event-driven architectures in Azure. It allows services such as Blob Storage to publish events, and it delivers those events to subscribed endpoints such as webhooks, Azure Functions, Logic Apps, or custom applications.

In this lab, a Blob Storage account was created with Azure PowerShell in Cloud Shell, a prebuilt web application was deployed to act as a message endpoint, and an Event Grid subscription was configured on the storage account. A blob upload was then used to trigger an event, which was delivered to the web application and displayed in the browser.

This lab demonstrates how Azure Event Grid supports near-real-time event delivery for storage operations and how webhook endpoints can be used to visualize and validate the event flow.

## Objectives

The objectives of this lab were to:

- Create an Azure Storage Account using Azure PowerShell
- Deploy a prebuilt Event Grid viewer web application
- Create a webhook endpoint for event delivery
- Subscribe the storage account to Azure Event Grid
- Validate the initial subscription handshake event
- Create a blob container and upload a test file
- Trigger a Blob Storage event
- Confirm event delivery to the web application endpoint

## Architecture Diagram

```text
                +----------------------+
                |   Azure Subscription |
                +----------+-----------+
                           |
                +----------+-----------+
                |       Resource Group |
                |     rg_centralus_xxx |
                +----------+-----------+
                           |
          +----------------+----------------+
          |                                 |
+---------+---------+             +---------+---------+
| Blob Storage      |             | App Service       |
| Account           |             | Event Viewer Web  |
| Hot Access Tier   |             | App               |
| Public Access Off |             | /api/updates      |
+---------+---------+             +---------+---------+
          |                                 ^
          |                                 |
          |                         Webhook Endpoint
          |                                 |
          +----------- Event Grid ----------+
                          Subscription
                               |
                     Blob Created Event
                               |
                     Browser shows event data
```

This architecture shows Blob Storage publishing events into Azure Event Grid, which then forwards those events to a deployed webhook viewer application in App Service.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser session is recommended to avoid Azure portal cache issues.

---

### Step 2 — Open Azure Cloud Shell in PowerShell

In the Azure Portal, select:

```text
Cloud Shell
```

Choose:

```text
PowerShell
```

On the startup prompt, select the assigned subscription and choose:

```text
Apply
```

After the session starts, PowerShell is ready for Azure resource deployment.

---

### Step 3 — Create the Storage Account

Run the following commands one by one in Cloud Shell PowerShell:

```powershell
$resourceGroup = "<resource_group_name>"
$location = "centralus"
$storageName = "<storage-account-name>"

$storageAccount = New-AzStorageAccount `
  -ResourceGroupName $resourceGroup `
  -Name $storageName `
  -Location $location `
  -SkuName Standard_LRS `
  -Kind BlobStorage `
  -AccessTier Hot `
  -AllowBlobPublicAccess $false

$ctx = $storageAccount.Context
```

This creates a Blob Storage account with:

- Standard LRS redundancy
- Hot access tier
- Blob public access disabled

After deployment, verify the storage account exists in the target resource group.

—
<img width="1523" height="203" alt="image" src="https://github.com/user-attachments/assets/c8279e9f-e82b-408f-b570-d67d0dfdbfea" />


### Step 4 — Deploy the Message Endpoint Web App

Create the Event Grid viewer application by running:

```powershell
$sitename = "<your-site-name>"

New-AzResourceGroupDeployment `
  -ResourceGroupName $resourceGroup `
  -TemplateUri "https://raw.githubusercontent.com/Azure-Samples/azure-event-grid-viewer/master/azuredeploy.json" `
  -siteName $sitename `
  -hostingPlanName viewerhost `
  -branch "main" `
  -sku "B1"
```

This deployment creates:

- An App Service Plan
- A Web App
- Source code for the Azure Event Grid viewer

After deployment completes:

1. Open the App Service resource
2. Copy the **Default domain**
3. Open it in a browser

Expected result:

- The web app loads successfully
- No events are displayed yet

Keep this page open so incoming Event Grid messages can be observed live.

—
<img width="1523" height="309" alt="image" src="https://github.com/user-attachments/assets/fb1c143f-8bfe-43f9-83b4-37a86420d6cb" />


### Step 5 — Create the Event Grid Subscription

Run the following commands in Cloud Shell PowerShell:

```powershell
$storageId = (Get-AzStorageAccount -ResourceGroupName $resourceGroup -AccountName $storageName).Id

$endpoint = "https://$sitename.azurewebsites.net/api/updates"

$obj = New-AzEventGridWebHookEventSubscriptionDestinationObject -EndpointUrl $endpoint

New-AzEventGridSubscription `
  -EventSubscriptionName gridBlobQuickStart `
  -Destination $obj `
  -Scope $storageId
```

This creates a subscription so that storage events from the Blob Storage account are sent to the App Service webhook endpoint.

After the subscription is created, look at the web app.

Expected result:

- A **subscription validation event** appears
- Expanding the event shows the validation payload used by Event Grid to confirm the endpoint

This confirms that the webhook endpoint accepted the subscription handshake.

—
<img width="1523" height="206" alt="image" src="https://github.com/user-attachments/assets/a3f21186-28e9-4d85-8a07-f8fce7ea3da7" />


### Step 6 — Trigger a Blob Storage Event

Create a blob container and upload a file:

```powershell
$containerName = "gridcontainer"

New-AzStorageContainer -Name $containerName -Context $ctx

echo $null >> gridTestFile.txt

Set-AzStorageBlobContent `
  -File gridTestFile.txt `
  -Container $containerName `
  -Context $ctx `
  -Blob gridTestFile.txt
```

This sequence:

- Creates a new blob container
- Creates a local test file
- Uploads the file into Blob Storage

The upload action triggers a storage event.

—
<img width="1523" height="425" alt="image" src="https://github.com/user-attachments/assets/da408f6b-3340-40a3-b255-e616b73a0187" />


### Step 7 — View the Delivered Event

Return to the browser tab showing the Event Grid viewer web app.

Expected result:

- A new blob event appears in the event list
- Expanding the event shows the event payload

This confirms that:

- Blob Storage published the event
- Event Grid routed it successfully
- The webhook endpoint received and displayed it
<img width="1523" height="445" alt="image" src="https://github.com/user-attachments/assets/e135404d-f45c-445c-b006-3640b2d9d374" />


## Azure CLI (Bash)

Create the storage account:

```bash
az storage account create \
  --name mystorageacct123 \
  --resource-group rg_centralus_XXXXX \
  --location centralus \
  --sku Standard_LRS \
  --kind BlobStorage \
  --access-tier Hot \
  --allow-blob-public-access false
```

Deploy the Event Grid viewer web app:

```bash
az deployment group create \
  --resource-group rg_centralus_XXXXX \
  --template-uri https://raw.githubusercontent.com/Azure-Samples/azure-event-grid-viewer/master/azuredeploy.json \
  --parameters siteName=myeventviewer123 hostingPlanName=viewerhost branch=main sku=B1
```

Create the Event Grid subscription:

```bash
az eventgrid event-subscription create \
  --name gridBlobQuickStart \
  --source-resource-id /subscriptions/<subscription-id>/resourceGroups/rg_centralus_XXXXX/providers/Microsoft.Storage/storageAccounts/mystorageacct123 \
  --endpoint https://myeventviewer123.azurewebsites.net/api/updates
```

Create the container:

```bash
az storage container create \
  --name gridcontainer \
  --account-name mystorageacct123
```

Upload the test blob:

```bash
az storage blob upload \
  --account-name mystorageacct123 \
  --container-name gridcontainer \
  --name gridTestFile.txt \
  --file gridTestFile.txt
```

List event subscriptions:

```bash
az eventgrid event-subscription list \
  --source-resource-id /subscriptions/<subscription-id>/resourceGroups/rg_centralus_XXXXX/providers/Microsoft.Storage/storageAccounts/mystorageacct123
```

## Azure PowerShell

Create the storage account:

```powershell
$resourceGroup = "rg_centralus_XXXXX"
$location = "centralus"
$storageName = "mystorageacct123"

$storageAccount = New-AzStorageAccount `
  -ResourceGroupName $resourceGroup `
  -Name $storageName `
  -Location $location `
  -SkuName Standard_LRS `
  -Kind BlobStorage `
  -AccessTier Hot `
  -AllowBlobPublicAccess $false

$ctx = $storageAccount.Context
```

Deploy the Event Grid viewer:

```powershell
$sitename = "myeventviewer123"

New-AzResourceGroupDeployment `
  -ResourceGroupName $resourceGroup `
  -TemplateUri "https://raw.githubusercontent.com/Azure-Samples/azure-event-grid-viewer/master/azuredeploy.json" `
  -siteName $sitename `
  -hostingPlanName viewerhost `
  -branch "main" `
  -sku "B1"
```

Create the Event Grid subscription:

```powershell
$storageId = (Get-AzStorageAccount -ResourceGroupName $resourceGroup -AccountName $storageName).Id
$endpoint = "https://$sitename.azurewebsites.net/api/updates"
$obj = New-AzEventGridWebHookEventSubscriptionDestinationObject -EndpointUrl $endpoint

New-AzEventGridSubscription `
  -EventSubscriptionName gridBlobQuickStart `
  -Destination $obj `
  -Scope $storageId
```

Create the container and upload the blob:

```powershell
$containerName = "gridcontainer"

New-AzStorageContainer `
  -Name $containerName `
  -Context $ctx

echo $null >> gridTestFile.txt

Set-AzStorageBlobContent `
  -File gridTestFile.txt `
  -Container $containerName `
  -Context $ctx `
  -Blob gridTestFile.txt
```

## Implementation Walkthrough

The lab began by opening Azure Cloud Shell in PowerShell mode and creating a Blob Storage account in the assigned resource group. The storage account used the **BlobStorage** kind, **Standard_LRS** redundancy, the **Hot** access tier, and disabled blob public access. This created the event source that would later publish blob-related notifications.

Next, a prebuilt Event Grid viewer web application was deployed through an ARM template hosted on GitHub. This web application served as a webhook endpoint that could receive and display Event Grid messages. Once the App Service deployment completed, its default domain was opened in a browser to confirm that the site was running and ready to receive events.

The storage account was then subscribed to Azure Event Grid by creating an Event Grid subscription whose destination pointed to the web app’s `/api/updates` endpoint. Immediately after subscription creation, the viewer displayed a **subscription validation event**, which confirmed that the endpoint and Event Grid handshake process were working correctly.

Finally, a blob container named `gridcontainer` was created and a test file named `gridTestFile.txt` was uploaded into that container. The upload triggered a blob event, which Azure Event Grid routed to the viewer web application. The event appeared in the browser, confirming end-to-end event flow from Blob Storage to Event Grid to the webhook endpoint.

## Results & Validation

| Test | Result |
|---|---|
| Cloud Shell PowerShell setup | Successful |
| Blob Storage account creation | Successful |
| Event viewer web app deployment | Successful |
| App Service browser validation | Successful |
| Event Grid subscription creation | Successful |
| Subscription validation event received | Successful |
| Blob container creation | Successful |
| Test blob upload | Successful |
| Blob event delivery to webhook | Successful |

Key observations:

- Blob Storage successfully acted as an Event Grid event source
- The App Service viewer acted as a working webhook endpoint
- Event Grid sent a validation event before sending operational events
- Uploading a blob generated a storage event automatically
- The browser-based event viewer provided clear confirmation of end-to-end event routing

## Validation Walkthrough

1. Verified that Cloud Shell opened successfully in **PowerShell** mode.
2. Created the Blob Storage account and confirmed it appeared in the resource group.
3. Deployed the Event Grid viewer web app from the ARM template.
4. Opened the App Service default domain and confirmed the viewer site loaded.
5. Created the Event Grid subscription against the storage account.
6. Confirmed that the web app displayed the **subscription validation event**.
7. Created the `gridcontainer` blob container.
8. Created and uploaded `gridTestFile.txt`.
9. Returned to the Event Grid viewer page.
10. Confirmed that a new blob event appeared and that its payload could be expanded in the web app.

## Real-World Use Case

Azure Event Grid is commonly used when organizations need storage operations to trigger downstream automation or notifications.

Example: **Blob Upload Event Processing**

| Component | Role |
|---|---|
| Blob Storage | Event source |
| Event Grid | Event routing service |
| Webhook / App Service | Receives event payload |
| Uploaded blob | Triggering action |

Typical workflow:

```text
User or App Uploads Blob
          ↓
Blob Storage Publishes Event
          ↓
Event Grid Evaluates Subscription
          ↓
Webhook Endpoint Receives Event
          ↓
App Displays or Processes Event Data
```

This pattern is useful for serverless automation, file processing pipelines, notifications, metadata extraction, and downstream integration workflows triggered by blob creation events.

## Key Takeaways

This lab demonstrated several important Azure event-driven architecture concepts:

- Azure Event Grid routes events from Azure services to subscribed endpoints
- Blob Storage can publish events such as blob creation automatically
- Webhook endpoints can receive and process Event Grid messages
- Event Grid uses a validation event to confirm endpoint readiness
- Blob upload events can be observed and verified in near real time

Understanding Azure Event Grid with Blob Storage is valuable for cloud administrators, developers, and automation engineers building event-driven solutions in Azure.

