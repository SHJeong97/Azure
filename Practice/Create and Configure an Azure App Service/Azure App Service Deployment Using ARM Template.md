# Azure App Service Deployment Using ARM Template

## Introduction

Azure Resource Manager (ARM) templates allow administrators and cloud engineers to deploy Azure infrastructure in a consistent, repeatable, and automated way. Instead of manually creating resources through the portal every time, ARM templates define infrastructure as code, which improves standardization, reduces configuration drift, and supports scalable deployments.

In this lab, an ARM template was explored and then deployed through Azure Cloud Shell to provision an **Azure App Service Plan** and an **Azure Web App**. The deployment used parameters such as location, language stack, SKU, and sample application settings to automate the build of a working web application environment.

This lab demonstrates how infrastructure as code can simplify Azure web application deployment while reinforcing repeatable cloud engineering practices. 

---

## Objectives

The objectives of this lab were to:

- Explore the structure of an ARM template for Azure App Service deployment
- Upload the ARM template into Azure Cloud Shell
- Deploy an App Service Plan and Web App using Azure CLI
- Configure parameters such as region, SKU, language stack, and sample app option
- Verify that the deployment completed successfully
- Access the deployed web application in the browser

---

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
                 +---------+---------+
                 | ARM Template      |
                 | template.json     |
                 +---------+---------+
                           |
                    Azure Cloud Shell
                           |
        +------------------+------------------+
        |                                     |
+-------+--------+                   +--------+-------+
| App Service    |                   | Azure Web App  |
| Plan           |                   | ASP.NET Sample |
| SKU: F1 / B1   |                   | .NET Runtime   |
+----------------+                   +----------------+
```

This architecture shows how an ARM template is uploaded to Azure Cloud Shell and used to deploy an App Service Plan together with a Web App in a repeatable, automated workflow.

---

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser window is recommended to avoid Azure portal cache issues. 

---

### Step 2 — Explore the ARM Template

The lab provided an ARM template for deploying an **Azure App Service Plan** and **Azure Web App**.

Key parameters included:

| Parameter | Purpose |
|---|---|
| `webAppName` | Name of the Web App |
| `location` | Azure region for deployment |
| `sku` | App Service Plan pricing tier |
| `language` | Runtime stack such as .NET, PHP, Node, or HTML |
| `helloWorld` | Deploy sample application if set to true |
| `repoUrl` | Optional Git repository URL |

The template also included logic to deploy a sample application repo when `helloWorld=true`, making it possible to automatically publish working starter code during deployment. 

---

### Step 3 — Open Azure Cloud Shell

In the Azure Portal, open **Cloud Shell** and select **Bash**.

Mount a storage account for Cloud Shell usage:

```text
Mount Storage account → PAYG-Labs 2 → Apply
```

If prompted, create a storage account and file share for Cloud Shell persistence.

This step provides a working shell environment where the ARM template can be uploaded and deployed.

---

### Step 4 — Upload the ARM Template

From the Cloud Shell toolbar, select:

```text
Manage files → Upload
```

Upload:

```text
template.json
```

The template is uploaded into the Cloud Shell home directory and becomes available for deployment commands

---

### Step 5 — Deploy the ARM Template

Run the deployment command in Cloud Shell:

```bash
az deployment group create \
  --resource-group rg_eastus_XXXXX \
  --template-file template.json \
  --parameters location=eastus language=.net helloWorld=true sku=B1 webAppName=mywebappdemo123
```

This command deploys:

- An App Service Plan
- A Web App
- A sample ASP.NET application

The deployment may take a few minutes to complete.

---

### Step 6 — Verify the Deployment

After the deployment completes:

1. Open the resource group
2. Locate the newly created App Service
3. Open the Web App overview page
4. Select **Browse**

Expected result:

- The default ASP.NET sample page loads successfully in the browser

This confirms the ARM template successfully deployed the web application environment. 

---

### Azure CLI (Bash)

Deploy the ARM template:

```bash
az deployment group create \
  --resource-group rg_eastus_XXXXX \
  --template-file template.json \
  --parameters location=eastus language=.net helloWorld=true sku=B1 webAppName=mywebappdemo123
```

Optional direct App Service deployment without ARM template:

```bash
az appservice plan create \
  --name AppServicePlan-mywebappdemo123 \
  --resource-group rg_eastus_XXXXX \
  --sku B1 \
  --is-linux false
```

Create Web App:

```bash
az webapp create \
  --name mywebappdemo123 \
  --resource-group rg_eastus_XXXXX \
  --plan AppServicePlan-mywebappdemo123 \
  --runtime "DOTNET:8"
```

Browse the app:

```bash
az webapp browse \
  --name mywebappdemo123 \
  --resource-group rg_eastus_XXXXX
```

---

### Azure PowerShell

Deploy the ARM template:

```powershell
New-AzResourceGroupDeployment `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -TemplateFile "template.json" `
  -location "eastus" `
  -language ".net" `
  -helloWorld $true `
  -sku "B1" `
  -webAppName "mywebappdemo123"
```

Optional direct App Service Plan creation:

```powershell
New-AzAppServicePlan `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "AppServicePlan-mywebappdemo123" `
  -Location "East US" `
  -Tier "Basic" `
  -NumberofWorkers 1
```

Create the Web App:

```powershell
New-AzWebApp `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "mywebappdemo123" `
  -Location "East US" `
  -AppServicePlan "AppServicePlan-mywebappdemo123"
```

---

## Implementation Walkthrough

The lab demonstrated how Azure infrastructure can be deployed through **Infrastructure as Code** using an ARM template.

First, the ARM template was reviewed to understand its parameters and conditional logic. Then Azure Cloud Shell was opened and configured with persistent storage so the template file could be uploaded. After the template was uploaded, the deployment command was executed with parameters defining the location, pricing tier, language stack, and application name.

Because `helloWorld=true` was used, the template deployed a sample ASP.NET application automatically. Once deployment completed, the Web App was opened in the browser to confirm that the environment was working correctly.

This approach demonstrates real engineering thinking because it shows not only how to deploy Azure resources, but also how to automate consistent application infrastructure through reusable templates.

---

## Results & Validation

| Test | Result |
|---|---|
| ARM template review | Successful |
| Cloud Shell setup | Successful |
| Template upload | Successful |
| ARM template deployment | Successful |
| App Service Plan creation | Successful |
| Web App creation | Successful |
| Sample web application access | Successful |

Key observations:

- ARM templates make deployments repeatable and consistent
- Cloud Shell simplifies deployment without requiring a local Azure CLI setup
- Parameterized templates support reusable infrastructure across environments
- The sample application verified that the web hosting stack was functional

---

## Validation Walkthrough

1. Verified that Cloud Shell opened successfully in Bash mode.
2. Uploaded `template.json` into the Cloud Shell home directory.
3. Ran the `az deployment group create` command with the required parameters.
4. Confirmed that the deployment completed without errors.
5. Opened the resource group and verified the App Service Plan was created.
6. Verified that the Web App resource was deployed.
7. Opened the Web App overview page and selected **Browse**.
8. Confirmed that the default ASP.NET sample page loaded successfully.

---

## Real-World Use Case

ARM templates are commonly used in organizations that need **standardized and repeatable web application deployments**.

Example: **Development Team Web App Deployment Standard**

| Component | Role |
|---|---|
| ARM Template | Defines deployment standard |
| App Service Plan | Provides compute hosting |
| Web App | Hosts the application |
| Cloud Shell / CI Pipeline | Executes deployment |
| Parameters | Customize per environment |

Typical workflow:

```text
Developer / Admin Updates Template
            ↓
Template Stored in Source Control
            ↓
Deployment Triggered from Cloud Shell or Pipeline
            ↓
Standardized App Service Environment Created
            ↓
Web Application Published and Verified
```

This model helps teams deploy consistent environments for dev, test, and production while reducing manual setup errors.

---

## Key Takeaways

This lab demonstrated several important Azure engineering concepts:

- ARM templates enable Infrastructure as Code in Azure
- Parameterized deployments improve consistency and reusability
- Azure Cloud Shell provides a convenient environment for template-based deployments
- Azure App Service simplifies hosting for web applications
- Automated sample app deployment helps validate the platform configuration quickly

Understanding ARM template deployment for App Service is valuable for cloud engineers, Azure administrators, and DevOps teams responsible for building repeatable Azure application environments.

