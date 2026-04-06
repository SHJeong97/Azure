# Azure Function App Deployment with Log Analytics Integration

## Introduction

In this project, I deployed an Azure Log Analytics Workspace and a serverless Azure Function App using the .NET 8 (LTS) runtime. I then created and tested an HTTP-triggered function to validate execution and response behavior.

This implementation demonstrates Azure serverless compute, monitoring integration, and application deployment within the Azure ecosystem. The project aligns with AZ-104 objectives related to monitoring, compute services, and application hosting.

---

## Objectives

- Create a Log Analytics Workspace
- Deploy an Azure Function App
- Configure runtime and hosting model
- Create an HTTP-triggered function
- Test function execution
- Understand serverless architecture benefits

---

## Full Implementation

### Log Analytics Workspace Deployment

#### Option 1 – Azure CLI (Bash)

```bash
az monitor log-analytics workspace create \
  --resource-group <resource-group-name> \
  --workspace-name <workspace-name> \
  --location eastus
``` 
#### Option 2 – Azure PowerShell (Az Module)
```powershell
New-AzOperationalInsightsWorkspace `
 -ResourceGroupName "<resource-group-name>" `
 -Name "<workspace-name>" `
 -Location "East US" `
 -Sku PerGB2018
``` 

### Azure Function App Deployment
#### Option 1 – Azure CLI (Bash)
```bash
az functionapp create \
 --resource-group <resource-group-name> \
 --consumption-plan-location eastus \
 --runtime dotnet \
 --runtime-version 8 \
 --functions-version 4 \
 --name <function-app-name> \
 --storage-account <storage-account-name>
``` 
#### Option 2 – Azure PowerShell (Az Module)
```powershell
New-AzFunctionApp `
 -ResourceGroupName "<resource-group-name>" `
 -Name "<function-app-name>" `
 -Location "East US" `
 -Runtime dotnet `
 -FunctionsVersion 4 `
 -StorageAccountName "<storage-account-name>"
``` 
Configuration Details:
- Resource Group: rg_eastus_XXXXX


- Runtime Stack: .NET 8 (LTS)


- Hosting Model: App Service


- Operating System: Windows


- Region: East US



### HTTP-Triggered Function Creation
After deployment, an HTTP-triggered function was created within the Function App.
Key Configuration:
- Trigger Type: HTTP


- Authorization Level: Default


- Function Name: WhizlabFunction


The HTTP trigger allows execution whenever an HTTP request is received.

##  Implementation Walkthrough
### Step 1 – Log Analytics Workspace Creation
- Created workspace in East US region


- Associated workspace with resource group


- Prepared monitoring environment for telemetry collection


Operational Insight:
 Log Analytics centralizes logs, metrics, and diagnostic data for monitoring and troubleshooting.

### Step 2 – Function App Deployment
- Selected Code deployment option


- Chose .NET 8 (LTS)


- Configured Windows runtime


- Deployed under App Service hosting


Architecture Insight:
 Azure Functions operate under a serverless model:
- No server management required


- Automatic scaling


- Event-driven execution
<img width="989" height="703" alt="image" src="https://github.com/user-attachments/assets/f64f7ae6-af06-4fdb-a47e-4a0d13bc13ef" />


### Step 3 – HTTP Trigger Function Creation
- Selected HTTP trigger template


- Assigned function name


- Deployed function within portal


The function responds to HTTP requests with a confirmation message.
<img width="989" height="703" alt="image" src="https://github.com/user-attachments/assets/feec9ab8-36fc-47b8-8e68-076ce2c8e039" />


### Step 4 – Function Testing
- Navigated to Code + Test


- Added query parameter (Name/Value pair)


- Executed Test/Run


- Verified:


	- HTTP Status: 200 OK


	- Successful response message


This validated proper function deployment and execution.

<img width="1523" height="780" alt="image" src="https://github.com/user-attachments/assets/aefc77fc-1b67-4bbd-9294-6c378f2ab45b" />
<img width="1438" height="616" alt="image" src="https://github.com/user-attachments/assets/b619c7fe-d733-4095-b6aa-04261615592f" />


##  Results & Validation
- Log Analytics Workspace successfully created


- Azure Function App deployed successfully


- HTTP-triggered function created


- Test execution returned Status 200 OK


- Response output confirmed correct behavior


- Serverless compute environment operational


All project objectives were achieved.

##  Validation Walkthrough
- Confirmed Log Analytics Workspace provisioning state.


- Verified Function App deployment status.


- Confirmed runtime stack configuration (.NET 8).


- Executed HTTP-triggered function.


- Verified successful 200 OK response.


- Confirmed expected output message returned.


The function executed successfully within Azure’s serverless environment.

##  Key Takeaways
- Azure Functions provide event-driven, serverless compute.


- Log Analytics enables centralized monitoring and diagnostics.


- HTTP triggers allow lightweight API-style deployments.


- Serverless architecture improves cost efficiency.


- Automatic scaling reduces operational overhead.


- .NET 8 (LTS) ensures long-term runtime support.


This project strengthens Azure Administrator skills in monitoring, serverless deployment, and cloud-native application architecture.

