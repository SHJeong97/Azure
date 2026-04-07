# Azure Web App Deployment with ASP.NET and CLI Publishing

## Introduction

In this project, I deployed an Azure Web App using App Service (Windows, ASP.NET 4.8) and published a locally developed ASP.NET Razor Pages application to Azure using Azure CLI.

This implementation demonstrates Azure App Service configuration, pricing tier selection, authentication configuration, local development workflow, and deployment using ZIP publishing.

The project aligns with AZ-104 objectives related to App Services, compute deployment, and application publishing.

---

## Objectives

- Create an Azure Web App using App Service
- Configure App Service plan and pricing tier
- Modify authentication settings
- Develop and test a local ASP.NET application
- Publish application to Azure using CLI
- Validate deployment functionality

---

## Full Implementation

### Azure Web App Creation

#### Option 1 – Azure CLI (Bash)

```bash
az appservice plan create \
  --name ManagedPlan \
  --resource-group <resource-group-name> \
  --location eastus \
  --sku B1 \
  --is-linux false

az webapp create \
  --resource-group <resource-group-name> \
  --plan ManagedPlan \
  --name labdemoapp1<yourname> \
  --runtime "ASPNET|4.8"
``` 
#### Option 2 – Azure PowerShell (Az Module)
```powershell
New-AzAppServicePlan `
 -Name "ManagedPlan" `
 -ResourceGroupName "<resource-group-name>" `
 -Location "East US" `
 -Tier "Basic" `
 -NumberofWorkers 1 `
 -WorkerSize "Small"

New-AzWebApp `
 -Name "labdemoapp1<yourname>" `
 -ResourceGroupName "<resource-group-name>" `
 -Location "East US" `
 -AppServicePlan "ManagedPlan"
``` 
Configuration Details:
Resource Group: rg_eastus_XXXXX


Runtime Stack: ASP.NET V4.8


Operating System: Windows


Region: East US


Pricing Tier: Basic B1


Application Insights: Disabled



### Authentication Configuration
SCM Basic Authentication and FTP Basic Authentication were enabled within App Service configuration settings to support deployment.

### Local Application Development
A new ASP.NET Razor Pages application was created locally using the .NET CLI.
```bash
dotnet new webapp -n labdemoapp1<yourname>
cd labdemoapp1<yourname>
code .
The homepage content was modified to:
Welcome back!
The application was tested locally:
dotnet run
``` 

### Build and Publish (Release Mode)
```bash
dotnet publish -c Release
The published output directory was compressed into:
App.zip
``` 

### Deploy Application to Azure
#### Option 1 – Azure CLI (Bash)
```bash
az login --use-device-code

az webapp deploy \
 --resource-group <resource-group-name> \
 --name labdemoapp1<yourname> \
 --src-path app.zip \
 --type zip
``` 
#### Option 2 – Azure PowerShell (Az Module)
```powershell
Connect-AzAccount -UseDeviceAuthentication

Publish-AzWebApp `
 -ResourceGroupName "<resource-group-name>" `
 -Name "labdemoapp1<yourname>" `
 -ArchivePath "app.zip"
``` 

##  Implementation Walkthrough
### Step 1 – App Service Deployment
- Created App Service Plan (Basic B1)


- Selected Windows runtime


- Configured ASP.NET 4.8


- Deployed Web App
<img width="611" height="608" alt="image" src="https://github.com/user-attachments/assets/789071e4-ee7f-42be-ba32-d8d5c2c831a6" />
<img width="1523" height="1473" alt="image" src="https://github.com/user-attachments/assets/c3ce6baf-33d0-4f5b-aa6e-e1491416f58e" />
<img width="1523" height="516" alt="image" src="https://github.com/user-attachments/assets/95419387-f26e-4b2f-86a7-a95d5e0cae63" />



#### Operational Insight:
 Basic B1 tier is cost-effective for development and small workloads.

### Step 2 – Local Development
- Created Razor Pages application


- Modified homepage content


- Verified local execution


- Ensured functionality before publishing


This reflects standard DevOps workflow: Develop → Test → Deploy.
<img width="1523" height="638" alt="image" src="https://github.com/user-attachments/assets/e0ea54d5-5fe8-4a92-8954-0266c2af90e6" />


### Step 3 – Deployment via CLI
- Authenticated using device login


- Uploaded ZIP package


- Confirmed deployment success


#### Architecture Insight:
 ZIP deployment pushes compiled build artifacts directly to App Service without requiring Git integration.

### Step 4 – Deployment Validation
- Accessed Web App URL


- Verified updated homepage


- Confirmed successful publishing
<img width="1523" height="289" alt="image" src="https://github.com/user-attachments/assets/4aeeaa5e-d09e-4a27-b513-47382cf42ea2" />
<img width="1264" height="834" alt="image" src="https://github.com/user-attachments/assets/f9c5b906-4b0b-43bb-8009-8ea9d6f9c43e" />





##  Results & Validation
- Azure Web App successfully deployed


- App Service Plan configured (Basic B1)


- Authentication settings enabled


- Local ASP.NET application modified


- Release build created successfully


- ZIP deployment completed successfully


- Web App displayed updated content


All objectives achieved.

##  Validation Walkthrough
- Verified App Service deployment status.


- Confirmed pricing tier configuration.


- Confirmed runtime stack selection.


- Executed local build and publish.


- Deployed ZIP package via CLI.


- Accessed Web App URL.


- Verified updated homepage content.


Deployment validated successfully.

##  Key Takeaways
- Azure App Service simplifies web hosting.


- CLI-based deployment supports automation workflows.


- Basic B1 tier is suitable for development workloads.


- ZIP deployment is efficient for CI/CD scenarios.


- Proper local validation reduces deployment errors.


- Azure Web Apps support deployment slots for zero-downtime updates.


This project strengthens Azure Administrator skills in App Service management, CLI-based publishing, and cloud-hosted web application deployment.

