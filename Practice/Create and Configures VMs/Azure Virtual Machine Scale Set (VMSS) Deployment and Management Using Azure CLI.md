# Azure Virtual Machine Scale Set (VMSS) Deployment and Management Using Azure CLI

## Introduction

In this project, I deployed and managed an Azure Virtual Machine Scale Set (VMSS) using Azure Cloud Shell and Azure CLI commands. The implementation demonstrates horizontal scalability, instance lifecycle management, and cost optimization strategies within Azure Infrastructure-as-a-Service (IaaS).

This project aligns with AZ-104 objectives related to compute management, scaling, and operational administration in Azure.

---

## Objectives

- Deploy a Virtual Machine Scale Set (VMSS) using Azure CLI
- Validate scale set creation and instance provisioning
- Modify capacity to scale instances up and down
- Stop and deallocate VM instances
- Start and restart individual and multiple instances
- Understand operational and cost implications of scaling

---

## Full Implementation

### Environment Setup

- Azure Portal Accessed
- Azure Cloud Shell (Bash) selected
- Subscription configured for lab environment
- Resource Group: `<resource-group-name>`

---

### VM Scale Set Deployment (Azure CLI)

The VM Scale Set was created using Azure CLI from Cloud Shell.

Core configuration included:

- VMSS deployment in specified resource group
- Automatic instance provisioning
- Default scaling capacity
- Integration with Azure networking components

After deployment, the scale set and associated VM instances were validated from:

- Azure CLI
- Azure Portal → Virtual Machine Scale Sets → Instances

---

### Capacity Modification

Scale set capacity was modified using Azure CLI commands to:

- Increase the number of VM instances
- Validate scaling behavior
- Confirm updated instance count via Azure Portal

This demonstrated horizontal scaling capability.

---

### Stop and Deallocate Operations

Administrative lifecycle operations were performed:

- Stop all VM instances in the scale set
- Deallocate specific instances
- Validate instance power state changes

Stopping = VM powered off but still allocated  
Deallocating = Compute resources released (cost optimization)

---

### Start and Restart Operations

Instance management included:

- Starting individual VM instances
- Starting all instances in the scale set
- Restarting specific instances
- Restarting entire scale set

State transitions were validated in the Azure Portal.

---

## Implementation Walkthrough

### Step 1 – Cloud Shell Initialization

- Opened Azure Cloud Shell (Bash)
- Configured correct subscription
- Verified resource group access

This ensures command execution context is correct.

---

### Step 2 – Create Virtual Machine Scale Set

Using Azure CLI:

1. Executed VMSS creation command
2. Confirmed successful deployment
3. Listed scale sets to verify creation
4. Reviewed instances in Azure Portal

**Architecture Insight:**
VMSS automatically provisions multiple identical VMs, enabling scalable workloads.

<img width="1523" height="117" alt="image" src="https://github.com/user-attachments/assets/de9f237b-bbbf-49ea-8502-c6fe5e034cd5" />
<img width="1523" height="158" alt="image" src="https://github.com/user-attachments/assets/0fa519a6-9ab0-42cf-81df-6d4d20e170b6" />
<img width="1523" height="353" alt="image" src="https://github.com/user-attachments/assets/58053d74-d037-4b6e-a395-46bbec707697" />


---

### Step 3 – Modify Capacity

1. Executed CLI command to change capacity
2. Listed instances to confirm new count
3. Verified in Portal → Instances panel

**Operational Insight:**
Scaling out increases availability and performance.
Scaling in reduces cost.
<img width="1523" height="230" alt="image" src="https://github.com/user-attachments/assets/0f5a64f7-7e2c-49e7-9952-11cd105c6c74" />

---

### Step 4 – Stop and Deallocate Instances

1. Executed stop command
2. Verified VM power state = Stopped
3. Executed deallocate command
4. Verified VM state = Deallocated

**Cost Optimization Insight:**
Deallocation releases compute billing charges while preserving disk data.

<img width="1523" height="117" alt="image" src="https://github.com/user-attachments/assets/8c919842-549e-4505-bb0c-e4d197b81c82" />
<img width="1523" height="359" alt="image" src="https://github.com/user-attachments/assets/ea9d99dc-d50d-49f6-8353-860c5c49fcad" />
<img width="1523" height="42" alt="image" src="https://github.com/user-attachments/assets/fc5a7fd1-daad-42b2-be8e-175d59f1ecf6" />
<img width="1523" height="389" alt="image" src="https://github.com/user-attachments/assets/2834d371-21f6-4083-baee-db821c1be53e" />



---

### Step 5 – Start and Restart Operations

1. Started individual VM
2. Verified running state
3. Started all VMs
4. Restarted individual VM
5. Restarted entire scale set

This demonstrated full lifecycle management of VMSS instances.

<img width="1523" height="41" alt="image" src="https://github.com/user-attachments/assets/2d5d963c-64d1-4cc7-b17d-96557d5e5be9" />
<img width="1523" height="336" alt="image" src="https://github.com/user-attachments/assets/86009661-dac6-4553-aea0-54c30c0803f0" />


---

## Results & Validation

- VM Scale Set successfully deployed
- Instance provisioning verified
- Capacity scaling validated
- Stop and deallocate functionality confirmed
- Start and restart operations successful
- Azure Portal reflected accurate power states

The scale set responded correctly to CLI-based management operations.

---

## Validation Walkthrough

1. Listed VM Scale Sets using Azure CLI
2. Confirmed instance count after scaling
3. Verified VM power states in Azure Portal
4. Confirmed deallocation state
5. Validated running state after start commands
6. Confirmed restart behavior via status monitoring

All operational objectives validated successfully.

---

## Key Takeaways

- Azure VM Scale Sets enable horizontal scaling.
- CLI-based management increases operational efficiency.
- Deallocating VMs reduces compute cost while preserving storage.
- VMSS integrates with load balancing and networking automatically.
- Scaling decisions directly impact availability and cost.
- Understanding lifecycle states is critical for Azure administrators.

This project strengthened practical Azure Administrator skills in scaling, automation, and cost management.

