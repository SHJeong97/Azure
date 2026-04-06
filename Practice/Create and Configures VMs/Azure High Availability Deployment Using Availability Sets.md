# Azure High Availability Deployment Using Availability Sets

## Introduction

High availability is a critical requirement in cloud infrastructure. In this project, I implemented an Azure Availability Set architecture to distribute virtual machines across fault and update domains to minimize downtime and increase resiliency.

This project demonstrates foundational Azure Administrator skills aligned with AZ-900, AZ-104, AZ-800, and AZ-801 certification paths.

---

## Objectives

- Deploy an Azure Availability Set
- Provision multiple Virtual Machines within the same Availability Set
- Configure consistent networking
- Validate fault domain distribution
- Demonstrate high availability design principles

---

## Full Implementation

### Availability Set Configuration

- **Resource Group:** rg_eastus_XXXXX  
- **Name:** WhizAvail  
- **Region:** Central US  
- **Fault Domains:** Default  
- **Update Domains:** Default  

---

### Virtual Machine #1

- **Name:** WhizlabAvail1  
- **Region:** Central US  
- **Availability Option:** Availability Set  
- **Availability Set:** WhizAvail  
- **Image:** Ubuntu Server 24.04 LTS - x64 Gen2  
- **Size:** B2s  
- **Authentication:** Password  
- **OS Disk:** Standard SSD  

---

### Virtual Machine #2

- **Name:** WhizlabAvail2  
- **Region:** Central US  
- **Availability Set:** WhizAvail  
- **Image:** Ubuntu Server 24.04 LTS - x64 Gen2  
- **Size:** B2s  
- **Networking:** Same VNet associated with resource group  
- **OS Disk:** Standard SSD  

---

## Implementation Walkthrough

### Step 1 – Azure Portal Access

- Signed into Azure Portal
- Verified correct tenant
- Used clean session to avoid cache conflicts

---

### Step 2 – Create Availability Set

1. Navigate to **Create a Resource**
2. Search for **Availability Set**
3. Assign to correct resource group
4. Select Central US region
5. Deploy





**Security Principle:**  
Availability Sets protect against hardware failure (Fault Domains) and planned maintenance (Update Domains).

---
<img width="1327" height="381" alt="image" src="https://github.com/user-attachments/assets/26e2dd2b-19ac-416f-bc8e-e9f442a9f5b5" />
<img width="1523" height="1094" alt="image" src="https://github.com/user-attachments/assets/0ca8cb3f-346d-4a08-823b-3358b243909d" />
<img width="1523" height="964" alt="image" src="https://github.com/user-attachments/assets/e90eb4bc-5ae4-4253-9a8f-a75020812e25" />
<img width="1223" height="1059" alt="image" src="https://github.com/user-attachments/assets/7ec54044-11ce-4035-92f6-9d5cbbd9f8b3" />


### Step 3 – Deploy First VM

1. Select Availability Set during VM creation
2. Attach to `WhizAvail`
3. Configure authentication and disk type
4. Deploy successfully

---

<img width="1050" height="1431" alt="image" src="https://github.com/user-attachments/assets/cfb41a57-ea9e-4476-8447-6361ccaf01ff" />
<img width="1523" height="1292" alt="image" src="https://github.com/user-attachments/assets/91a85d23-ef2f-488e-8f70-8490dcf1764f" />
<img width="1013" height="1194" alt="image" src="https://github.com/user-attachments/assets/36cdc479-4dd9-428c-80d9-f94cb58646e7" />


### Step 4 – Deploy Second VM

1. Repeat VM creation process
2. Select same Availability Set
3. Confirm correct Virtual Network
4. Deploy
<img width="1350" height="1514" alt="image" src="https://github.com/user-attachments/assets/5eab1082-2f52-4954-b69d-76811bdc21ad" />


**Important:**  
At least two VMs are required to achieve high availability in an Availability Set.

---

## Results & Validation

- Two virtual machines successfully deployed
- Both associated with the same Availability Set
- Azure distributed VMs across separate Fault Domains
- Azure distributed VMs across separate Update Domains
- Networking configuration validated

High availability design successfully implemented.

---

## Validation Walkthrough

1. Navigate to the Availability Set resource
2. Verify:
   - Two associated Virtual Machines
   - Distinct Fault Domain assignments
   - Distinct Update Domain assignments
3. Confirm both VMs are running
4. Validate network connectivity

---

## Key Takeaways

- Availability Sets increase resiliency by separating VMs across physical infrastructure.
- At least two VMs are required for SLA eligibility.
- Proper resource group and networking configuration prevents deployment errors.
- High availability must be designed intentionally, not assumed.
- This project strengthens Azure infrastructure and administrator-level deployment skills.

