# Azure Web App Deployment with .NET 8 (LTS) and Monitoring Analysis

## Introduction

In this project, I deployed an Azure Web App using Azure App Service with the .NET 8 (LTS) runtime. After deployment, I validated application accessibility and analyzed built-in monitoring metrics to understand traffic behavior and performance indicators.

This implementation demonstrates Azure App Service configuration, pricing plan selection, application hosting, and performance monitoring. The project aligns with AZ-104 objectives related to compute services and monitoring.

---

## Objectives

- Deploy an Azure Web App using .NET 8 (LTS)
- Configure Basic B1 App Service Plan
- Validate default application deployment
- Analyze monitoring metrics
- Understand HTTP error trends and response time indicators

---

## Full Implementation

### Web App Deployment

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
  --name demoapp1<yourname> \
  --runtime "DOTNET|8.0"
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
 -Name "demoapp1<yourname>" `
 -ResourceGroupName "<resource-group-name>" `
 -Location "East US" `
 -AppServicePlan "ManagedPlan"
``` 
### Configuration Details
R- esource Group: rg_eastus_XXXXX


- Runtime Stack: .NET 8 (LTS)


- Publish Mode: Code


- Operating System: Windows


- Region: East US


- Pricing Tier: Basic B1



##  Implementation Walkthrough
### Step 1 – App Service Plan Creation
- Created Basic B1 pricing tier plan.


- Selected East US region.


- Provisioned single instance (non-scaled).


#### Operational Insight:
 Basic B1 tier is cost-efficient and suitable for development and small production workloads.

### Step 2 – Web App Deployment
- Configured .NET 8 runtime.


- Deployed Web App.


- Verified provisioning completion.


- Retrieved default domain URL.



### Step 3 – Web App Testing
- Accessed default domain.


- Confirmed sample application page loads successfully.


- Validated HTTP 200 response behavior.


This confirms successful runtime and hosting configuration.

### Step 4 – Monitoring and Telemetry Analysis
Accessed Monitoring charts under the Web App Overview page.
Simulated traffic by refreshing the application URL multiple times.
Observed metrics including:
- HTTP 5xx


- Data In


- Data Out


- Requests


- Response Time
<img width="1523" height="1227" alt="image" src="https://github.com/user-attachments/assets/82208a88-6e9c-43a6-9aba-3d5a18489e7f" />


##  Results & Validation
- Azure Web App successfully deployed.


- Default sample application accessible.


- Basic B1 pricing tier configured.


- Traffic simulation reflected in monitoring charts.


- Telemetry updated with request activity.


- Performance metrics observable.


Deployment and monitoring objectives were successfully achieved.

##  Validation Walkthrough
-Confirmed Web App provisioning status = Running.


- Accessed default domain URL.


- Verified sample application page.


- Simulated multiple requests.


- Observed increase in Requests metric.


- Confirmed Data In and Data Out increments.


- Reviewed Response Time behavior.


- Verified no abnormal HTTP 5xx spikes.


All functional and monitoring validation steps completed successfully.

##  Key Takeaways
- Azure App Service simplifies deployment of web applications.


- .NET 8 (LTS) provides long-term support for enterprise workloads.


- Basic B1 tier balances cost and performance for small deployments.


- Monitoring charts provide real-time operational insight.


- HTTP 5xx spikes may indicate code defects, dependency failures, or traffic overload.


- Response Time and Request metrics are critical for performance evaluation.


- Data In/Out helps analyze traffic consumption patterns.


This project strengthens Azure Administrator skills in application hosting, monitoring, performance analysis, and operational diagnostics.

