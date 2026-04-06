# Azure Container Instance (ACI) Deployment and Monitoring Using CLI

## Introduction

In this project, I deployed an Azure Container Instance (ACI) using Azure Cloud Shell and verified its availability via public endpoint access. I also analyzed built-in Azure monitoring metrics to understand CPU, memory, and network utilization.

This implementation demonstrates container deployment, public networking configuration, and performance monitoring within Azure Infrastructure-as-a-Service (IaaS).

The project aligns with AZ-104 objectives related to compute services, networking, and monitoring.

---

## Objectives

- Deploy an Azure Container Instance (ACI) using CLI
- Configure public DNS name for container access
- Verify container functionality through web endpoint
- Analyze Azure monitoring metrics
- Understand container lifecycle and resource utilization

---

## Full Implementation

### Environment Setup

- Azure Portal accessed
- Azure Cloud Shell initialized
- Bash selected
- Subscription configured
- Resource Group: `<resource-group-name>`

---

### Option 1 – Azure CLI (Bash)

```bash
az container create \
  --resource-group <resource-group-name> \
  --name <container-instance-name> \
  --image mcr.microsoft.com/azuredocs/aci-helloworld:latest \
  --dns-name-label <unique-dns-name> \
  --ports 80 \
  --os-type Linux \
  --cpu 1 \
  --memory 1.5
``` 

### Option 2 – Azure PowerShell (Az Module)
```powershell
New-AzContainerGroup `
 -ResourceGroupName "<resource-group-name>" `
 -Name "<container-instance-name>" `
 -Image "mcr.microsoft.com/azuredocs/aci-helloworld:latest" `
 -DnsNameLabel "<unique-dns-name>" `
 -OsType Linux `
 -IpAddressType Public `
 -Port 80 `
 -Cpu 1 `
 -MemoryInGB 1.5
``` 

### Verification Commands
Azure CLI
```bash
az container show \
 --resource-group <resource-group-name> \
 --name <container-instance-name> \
 --query "{FQDN:ipAddress.fqdn,State:instanceView.state}" \
 --output table
``` 
Azure PowerShell
```powershell
Get-AzContainerGroup `
 -ResourceGroupName "<resource-group-name>" `
 -Name "<container-instance-name>" |
 Select-Object Name, ProvisioningState, @{Name="FQDN";Expression={$_.IpAddress.Fqdn}}
``` 

##  Implementation Walkthrough
### Step 1 – Cloud Shell Initialization
- Opened Azure Cloud Shell


- Selected Bash


- Confirmed correct subscription


- Verified resource group context


This ensures CLI commands execute in the intended environment.

### Step 2 – Container Instance Deployment
The container instance was deployed using a public DNS name and port 80 exposure.
Key configuration elements:
- Linux-based container


- Public IP assignment


-Fully Qualified Domain Name (FQDN)


- CPU and memory allocation


- HTTP port exposure
<img width="1523" height="248" alt="image" src="https://github.com/user-attachments/assets/5af31dfb-8a82-4dc5-a19f-646d18a22d2d" />


#### Security Consideration:
 Public exposure of container endpoints should include:
- Network security restrictions


- Azure Web Application Firewall (WAF)


- Private endpoints (for production)


- Defender for Cloud container scanning


### Step 3 – Deployment Verification
- Navigated to Azure Portal → Container Instances


- Confirmed Status = Running


- Retrieved FQDN


- Accessed FQDN via browser


- Confirmed welcome page response


- Tested IP address direct access


This v- alidated:
- Container networking


- DNS configuration


- Public accessibility


- Proper container runtime state

<img width="1523" height="555" alt="image" src="https://github.com/user-attachments/assets/2c197a88-5b0f-49c8-bf6c-349a780ff343" />
<img width="1523" height="578" alt="image" src="https://github.com/user-attachments/assets/b28f39c5-aa1d-4f95-9f04-a7f2e3139717" />



### Step 4 – Metrics Analysis
Simulated traffic by refreshing the endpoint multiple times.
Observed metrics in Azure Portal:
- CPU Usage


- Memory Usage


- Network Bytes Received


- Network Bytes Transmitted


#### Operational Insight:
These metrics help determine:
- Performance bottlenecks


- Resource consumption trends


- Incoming vs outgoing traffic behavior


- Scaling considerations
<img width="1523" height="578" alt="image" src="https://github.com/user-attachments/assets/4b3b0490-9cd3-4a83-bad8-94ee4847e46f" />


##  Results & Validation
- Azure Container Instance successfully deployed


- Public DNS endpoint operational


- Container state verified as Running


- Web response validated


- Monitoring metrics displayed traffic data


- Resource utilization observable in Azure Portal


The container deployment and monitoring objectives were successfully achieved.

##  Validation Walkthrough
- Executed container creation command.


- Confirmed provisioning state.


- Retrieved FQDN.


- Verified browser-based access.


- Simulated request traffic.


-Observed metric chart updates.


- Confirmed CPU, memory, and network metrics reflect activity.


All deployment and monitoring functions validated successfully.

##  Key Takeaways
- Azure Container Instances provide lightweight, serverless container hosting.


- CLI-based deployment enables automation and DevOps workflows.


- Public DNS configuration allows rapid web service exposure.


- Monitoring metrics provide visibility into performance behavior.


- Proper security configuration is critical when exposing public endpoints.


- ACI is ideal for development, testing, and short-lived workloads.


This project strengthens practical Azure Administrator skills in container deployment, networking configuration, and monitoring analysis.

