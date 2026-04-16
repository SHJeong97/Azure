# Azure Storage Static Website Hosting with Visual Studio Code Deployment

## Introduction

Azure Storage static website hosting provides a simple, scalable, and cost-effective way to publish static web content directly from a storage account. Instead of deploying a full web server or App Service, administrators can host HTML, CSS, JavaScript, and static assets from Azure Blob Storage using the static website feature.

In this lab, an Azure Storage Account was created and configured for static website hosting. The default document and error document were defined, a simple **Hello World** website was created locally in Visual Studio Code, and the site was deployed to Azure using the **Azure Storage extension** in VS Code.

This lab demonstrates a lightweight web hosting pattern that is useful for simple public websites, landing pages, documentation portals, and proof-of-concept web projects.

## Objectives

The objectives of this lab were to:

- Create an Azure Storage Account
- Configure static website hosting in the storage account
- Define default index and error pages
- Install the Azure Storage extension in Visual Studio Code
- Create a simple static website locally
- Deploy the website to Azure from VS Code
- Validate that the static website is accessible through the Azure endpoint

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
                    | Standard LRS|
                    +------+------+
                           |
                    +------+------+
                    | Static      |
                    | Website     |
                    | Hosting     |
                    +------+------+
                           |
            +--------------+--------------+
            |                             |
   +--------+--------+           +--------+--------+
   | index.html      |           | 404.html        |
   | Default page    |           | Error page      |
   +--------+--------+           +--------+--------+
            ^
            |
   +--------+--------+
   | Visual Studio   |
   | Code + Azure    |
   | Storage Ext.    |
   +--------+--------+
            |
      Deploy to Static Website
            |
        Web Browser
```

This architecture shows a local static website created in Visual Studio Code and deployed to Azure Storage static website hosting, where Azure serves both the default index page and the custom error page.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser window is recommended to avoid Azure portal cache issues.

---

### Step 2 — Create the Storage Account

Navigate to:

```text
Storage Accounts → Create
```

Configure the storage account with the following settings:

| Setting | Value |
|---|---|
| Resource Group | rg_eastus_XXXXX |
| Storage Account Name | Globally unique name |
| Region | East US |
| Preferred Storage Type | Azure Blob Storage or Azure Data Lake Storage Gen 2 |
| Performance | Standard |
| Redundancy | Locally-redundant storage (LRS) |

Leave the other settings at their default values, then review and create the storage account.

This storage account will host the static website content.

—
<img width="1502" height="942" alt="image" src="https://github.com/user-attachments/assets/52b76af0-e2fb-4251-a79b-c10b76f10ecd" />


### Step 3 — Install the Azure Storage Extension in Visual Studio Code

Open **Visual Studio Code** on your local system.

In the Extensions pane:

1. Search for `Azure Storage`
2. Select the **Azure Storage** extension
3. Click **Install**

Wait for the extension installation to complete.

This extension enables direct deployment of local website files into Azure Storage static website hosting.

---

### Step 4 — Configure Static Website Hosting

In the Azure Portal, open the newly created storage account.

Navigate to:

```text
Data Management → Static Website
```

Enable static website hosting and configure:

| Setting | Value |
|---|---|
| Index Document Name | index.html |
| Error Document Path | 404.html |

Select **Save**.

After saving, Azure generates the static website endpoint URL.

This endpoint will be used to access the deployed site.

—
<img width="1523" height="1150" alt="image" src="https://github.com/user-attachments/assets/b0777938-bd66-42f7-ba49-590db1e90ad5" />
<img width="1523" height="1039" alt="image" src="https://github.com/user-attachments/assets/4d91d68d-53fb-4231-af62-b5fadd905b0a" />


### Step 5 — Create the Website Files in Visual Studio Code

Create a local folder named:

```text
mywebsite
```

Open the folder in Visual Studio Code.

Create the following files:

```text
index.html
404.html
```

Paste the following content into `index.html`:

```html
<!DOCTYPE html>
<html>
  <body>
    <h1>Hello World!</h1>
  </body>
</html>
```

Paste the following content into `404.html`:

```html
<!DOCTYPE html>
<html>
  <body>
    <h1>404</h1>
  </body>
</html>
```

Save both files.

---

### Step 6 — Deploy the Website to Azure

In Visual Studio Code:

1. Right-click the `mywebsite` folder
2. Select:

```text
Deploy to Static Website...
```

3. Sign in to Azure if prompted
4. Select the assigned subscription
5. Select the storage account created earlier

The Azure Storage extension uploads the website files to the static website endpoint.

After deployment completes, select:

```text
Browse to Website
```

Expected result:

- The static website loads successfully
- The browser displays:

```text
Hello World!
```

This confirms the static website was deployed successfully.
<img width="1223" height="430" alt="image" src="https://github.com/user-attachments/assets/c27a4cdb-741d-47d5-9a6f-cd969e0328e2" />


### Azure CLI (Bash)

Create the storage account:

```bash
az storage account create \
  --name mystaticweb123 \
  --resource-group rg_eastus_XXXXX \
  --location eastus \
  --sku Standard_LRS \
  --kind StorageV2
```

Enable static website hosting:

```bash
az storage blob service-properties update \
  --account-name mystaticweb123 \
  --static-website \
  --index-document index.html \
  --404-document 404.html
```

Upload `index.html`:

```bash
az storage blob upload \
  --account-name mystaticweb123 \
  --container-name '$web' \
  --name index.html \
  --file index.html
```

Upload `404.html`:

```bash
az storage blob upload \
  --account-name mystaticweb123 \
  --container-name '$web' \
  --name 404.html \
  --file 404.html
```

Show the static website endpoint:

```bash
az storage account show \
  --name mystaticweb123 \
  --resource-group rg_eastus_XXXXX \
  --query "primaryEndpoints.web" \
  --output tsv
```

### Azure PowerShell

Create the storage account:

```powershell
New-AzStorageAccount `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "mystaticweb123" `
  -Location "East US" `
  -SkuName "Standard_LRS" `
  -Kind "StorageV2"
```

Get the storage context:

```powershell
$ctx = (Get-AzStorageAccount `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "mystaticweb123").Context
```

Enable static website hosting:

```powershell
Enable-AzStorageStaticWebsite `
  -Context $ctx `
  -IndexDocument "index.html" `
  -ErrorDocument404Path "404.html"
```

Upload `index.html`:

```powershell
Set-AzStorageBlobContent `
  -Context $ctx `
  -Container '$web' `
  -File ".\index.html" `
  -Blob "index.html"
```

Upload `404.html`:

```powershell
Set-AzStorageBlobContent `
  -Context $ctx `
  -Container '$web' `
  -File ".\404.html" `
  -Blob "404.html"
```

Display the website endpoint:

```powershell
(Get-AzStorageAccount `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "mystaticweb123").PrimaryEndpoints.Web
```

## Implementation Walkthrough

The lab started by creating an Azure Storage Account configured with **Standard** performance and **Locally-redundant storage (LRS)** in the East US region. This provided the storage platform required for hosting the static website.

Next, static website hosting was enabled from the storage account settings. The default landing page was configured as `index.html`, and the custom error page was set to `404.html`. Azure then exposed a web endpoint that would serve content from the special static website container.

On the local workstation, Visual Studio Code was used to create a small sample website inside a folder named `mywebsite`. Two files were created: `index.html` containing a simple **Hello World** page, and `404.html` containing a minimal error page. The Azure Storage extension in VS Code was then used to sign in to Azure, choose the target storage account, and deploy the local website directly to the storage account’s static website feature.

Finally, the site was opened through the generated endpoint URL, confirming that the website deployment was successful.

## Results & Validation

| Test | Result |
|---|---|
| Storage account creation | Successful |
| Static website hosting enabled | Successful |
| Index and error document configuration | Successful |
| Azure Storage extension installation | Successful |
| Website file creation in VS Code | Successful |
| Website deployment from VS Code | Successful |
| Browser access to the static website | Successful |

Key observations:

- Azure Storage Account can host static websites without requiring a separate web server
- The Azure Storage extension in VS Code simplifies deployment from a local folder
- Azure automatically provides a static website endpoint
- Custom index and error documents improve user experience for basic static sites

## Validation Walkthrough

1. Verified that the storage account was created successfully in `rg_eastus_XXXXX`.
2. Opened the **Static Website** configuration page in the storage account.
3. Confirmed that `index.html` was set as the index document.
4. Confirmed that `404.html` was set as the error document path.
5. Installed the Azure Storage extension in Visual Studio Code.
6. Created the `mywebsite` folder locally.
7. Added the `index.html` and `404.html` files with the required HTML content.
8. Deployed the folder to Azure using **Deploy to Static Website...**
9. Selected the correct subscription and storage account.
10. Opened the generated website endpoint and confirmed the **Hello World!** page loaded successfully.

## Real-World Use Case

Azure Storage static website hosting is useful when organizations need a lightweight hosting solution for simple public web content.

Example: **Public Landing Page or Documentation Site**

| Component | Role |
|---|---|
| Azure Storage Account | Hosts static content |
| Static Website Feature | Serves HTML pages |
| Visual Studio Code | Local editing and deployment |
| Azure Storage Extension | Deployment integration |
| Browser | End-user access |

Typical workflow:

```text
Create Static Website Files Locally
            ↓
Enable Static Website in Storage Account
            ↓
Deploy Files from VS Code
            ↓
Azure Publishes Web Endpoint
            ↓
Users Access the Site in a Browser
```

This pattern is useful for portfolio sites, company landing pages, simple documentation portals, maintenance pages, and proof-of-concept websites.

## Key Takeaways

This lab demonstrated several important Azure web hosting concepts:

- Azure Storage Accounts can host static websites directly
- Static website hosting is simple, scalable, and cost-effective for static content
- Visual Studio Code with the Azure Storage extension streamlines local deployment
- Index and error documents define the default user experience
- Azure automatically provides a website endpoint after static hosting is enabled

Understanding Azure Storage static website hosting is valuable for cloud administrators, web developers, and anyone building simple static web solutions in Azure.

