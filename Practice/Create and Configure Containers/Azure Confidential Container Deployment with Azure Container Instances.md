# Azure Confidential Container Deployment with Azure Container Instances

## Introduction

Azure Container Instances (ACI) is a serverless container service that allows administrators and developers to run containers in Azure without managing virtual machines or cluster infrastructure. It is designed for fast deployment, isolated workloads, and simplified container hosting.

In this lab, a **Log Analytics workspace** was created first to support centralized monitoring. Then a **confidential container** was deployed in **Azure Container Instances** using the **development confidential computing enforcement policy**. This deployment used the `mcr.microsoft.com/aci/aci-confidential-helloworld:v1` quickstart image and demonstrated how Azure can run containerized workloads inside a **Trusted Execution Environment (TEE)** for stronger protection of data in use.

The lab also highlighted an important design distinction: the **development policy** is intended for testing and non-production use, while **production confidential container deployments** require a **custom confidential computing enforcement policy** delivered through an ARM template.

## Objectives

The objectives of this lab were to:

- Create an Azure Log Analytics workspace
- Deploy a confidential Azure Container Instance
- Use the **Confidential (development policy)** SKU
- Configure monitoring integration with Log Analytics
- Verify that the container instance entered the **Running** state
- Access the containerized application through its public IP address
- Understand the difference between development and production confidential computing policies

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
          +----------------+----------------+
          |                                 |
+---------+---------+             +---------+---------+
| Log Analytics     |             | Azure Container   |
| Workspace         |             | Instances         |
| analyticsWorkspace|             | Confidential SKU  |
+---------+---------+             +---------+---------+
          ^                                 |
          |                                 |
          |                        +--------+--------+
          |                        | Confidential    |
          |                        | Container Group |
          |                        | Hello World App |
          |                        +--------+--------+
          |                                 |
          +-------------------------- Monitoring
                                            |
                                      Public IP Address
                                            |
                                        Web Browser
```

This architecture shows a confidential container group deployed in Azure Container Instances with monitoring integrated into a Log Analytics workspace and application access exposed through a public IP.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser session is recommended to avoid Azure portal cache issues.

---

### Step 2 — Create a Log Analytics Workspace

Navigate to:

```text
Log Analytics Workspaces → Create
```

Configure the workspace:

| Setting | Value |
|---|---|
| Resource Group | rg_eastus_XXXXX |
| Workspace Name | analyticsWorkspace |
| Region | East US |

Review and create the workspace.

This workspace will be used to collect telemetry and monitoring data from the confidential container deployment.

—
<img width="1336" height="923" alt="image" src="https://github.com/user-attachments/assets/52177ade-0d36-499f-83ff-dcef7ef8cccf" />


### Step 3 — Create the Confidential Container Instance

Navigate to:

```text
Container Instances → Create
```

On the **Basics** tab, configure the container instance with the following settings:

| Setting | Value |
|---|---|
| Resource Group | rg_eastus_XXXXX |
| Container Name | Unique name |
| Region | East US |
| SKU | Confidential (development policy) |
| Image Source | Quickstart images |
| Container Image | mcr.microsoft.com/aci/aci-confidential-helloworld:v1 (Linux) |

Leave the remaining settings at their defaults.

—
<img width="1523" height="1553" alt="image" src="https://github.com/user-attachments/assets/854aebe1-1310-4543-9655-271506c866fc" />


### Step 4 — Review Monitoring Integration

Open the **Monitoring** tab.

Expected behavior:

- The previously created **Log Analytics workspace** is automatically selected

This provides centralized monitoring, diagnostics, and operational visibility for the container instance.

Leave monitoring settings at their defaults and continue.

---

### Step 5 — Review and Create the Container

Select:

```text
Review + Create
```

After validation completes, select:

```text
Create
```

Azure begins deploying the confidential container group.

Important note:

- When deploying confidential containers through the Azure Portal, only the **development confidential computing enforcement policy** is available.
- This policy is intended for **development and testing only**.
- For production workloads, Azure recommends a **custom confidential computing enforcement policy** deployed through an **ARM template**.

---

### Step 6 — Open the Container Resource

After the deployment finishes, select:

```text
Go to Resource
```

On the **Overview** page, note the following:

- **IP Address**
- **Status**

Wait until the container status shows:

```text
Running
```

---

### Step 7 — Access the Containerized Application

Copy the container group IP address and paste it into a web browser.

Expected result:

- The confidential container application loads successfully

This validates that the container group is running and reachable over the assigned public IP.
<img width="1523" height="1553" alt="image" src="https://github.com/user-attachments/assets/3b7c6d6d-2c0c-4b5a-880f-e1870e077d35" />


### Azure CLI (Bash)

Create the Log Analytics workspace:

```bash
az monitor log-analytics workspace create \
  --resource-group rg_eastus_XXXXX \
  --workspace-name analyticsWorkspace \
  --location eastus
```

Create the confidential container group:

```bash
az container create \
  --resource-group rg_eastus_XXXXX \
  --name myconfidentialcontainer \
  --image mcr.microsoft.com/aci/aci-confidential-helloworld:v1 \
  --location eastus \
  --ports 80 \
  --ip-address Public \
  --sku Confidential
```

Show container state:

```bash
az container show \
  --resource-group rg_eastus_XXXXX \
  --name myconfidentialcontainer \
  --query "{State:instanceView.state, IP:ipAddress.ip}" \
  --output table
```

Retrieve the container IP:

```bash
az container show \
  --resource-group rg_eastus_XXXXX \
  --name myconfidentialcontainer \
  --query ipAddress.ip \
  --output tsv
```

### Azure PowerShell

Create the Log Analytics workspace:

```powershell
New-AzOperationalInsightsWorkspace `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "analyticsWorkspace" `
  -Location "East US" `
  -Sku "PerGB2018"
```

Create the confidential container group:

```powershell
New-AzContainerGroup `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "myconfidentialcontainer" `
  -Image "mcr.microsoft.com/aci/aci-confidential-helloworld:v1" `
  -Location "East US" `
  -OsType Linux `
  -IpAddressType Public `
  -Port 80
```

View container state and IP address:

```powershell
Get-AzContainerGroup `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "myconfidentialcontainer"
```

## Implementation Walkthrough

The lab began by creating a **Log Analytics workspace** so that monitoring data from the container deployment could be collected centrally. This is an important operational step because confidential container deployments still require observability for diagnostics and troubleshooting.

After the workspace was deployed, a new **Azure Container Instance** was created using the **Confidential (development policy)** SKU. The Microsoft quickstart image `aci-confidential-helloworld:v1` was selected, which provided a simple confidential workload for validation. During the deployment process, the Azure Portal automatically associated the container instance with the Log Analytics workspace in the monitoring tab.

Once the deployment completed, the container group overview page showed the assigned public IP and running status. Accessing the IP in a browser confirmed that the confidential containerized application was reachable. This validated both the deployment workflow and the operational readiness of the container group.

## Results & Validation

| Test | Result |
|---|---|
| Log Analytics workspace creation | Successful |
| Confidential container deployment | Successful |
| Development policy selection | Successful |
| Automatic monitoring integration | Successful |
| Container state verification | Successful |
| Public IP access | Successful |

Key observations:

- Azure Container Instances can deploy confidential containers without VM management
- The Azure Portal supports the **development confidential computing enforcement policy**
- Log Analytics integration provides centralized monitoring visibility
- The container group exposed a public IP that allowed browser-based validation
- The development policy is appropriate for testing but not for production use

## Validation Walkthrough

1. Verified that the Log Analytics workspace `analyticsWorkspace` was created successfully.
2. Opened Azure Container Instances and started a new deployment.
3. Selected the **Confidential (development policy)** SKU.
4. Chose the `mcr.microsoft.com/aci/aci-confidential-helloworld:v1` quickstart image.
5. Confirmed that the Log Analytics workspace was automatically selected in the **Monitoring** tab.
6. Completed the deployment and opened the container group resource.
7. Verified that the container status changed to **Running**.
8. Copied the assigned public IP address from the overview page.
9. Opened the IP address in a web browser.
10. Confirmed that the containerized application was accessible.

## Real-World Use Case

Confidential containers are useful when organizations need stronger protection for workloads that process sensitive data.

Example: **Sensitive Data Processing in a Trusted Execution Environment**

| Component | Role |
|---|---|
| Azure Container Instances | Serverless container runtime |
| Confidential Container SKU | Protects data in use |
| Trusted Execution Environment | Isolates workload execution |
| Log Analytics Workspace | Operational monitoring |
| Public IP | Application access for validation |

Typical workflow:

```text
Sensitive Containerized Workload Deployed
                ↓
Runs Inside Confidential Execution Environment
                ↓
Monitoring Sent to Log Analytics
                ↓
App Exposed for Controlled Testing
```

This pattern is useful for secure development environments, proof-of-concept sensitive workloads, and early testing of confidential computing architectures before moving to production-grade template-driven deployments.

## Key Takeaways

This lab demonstrated several important Azure container and security concepts:

- Azure Container Instances provides serverless container hosting without managing VMs
- Confidential containers help protect **data in use** by running inside trusted execution environments
- The Azure Portal supports the **development confidential computing enforcement policy**
- Log Analytics integration improves observability and operational monitoring
- Production confidential container deployments require a **custom enforcement policy** delivered through ARM templates

Understanding Azure confidential containers is valuable for cloud engineers, security-focused administrators, and teams working with sensitive workloads in Azure.

