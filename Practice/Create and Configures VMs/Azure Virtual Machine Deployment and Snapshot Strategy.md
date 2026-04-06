# Azure Virtual Machine Deployment and Snapshot Strategy

## Introduction

In this project, I deployed a Windows Server 2025 Virtual Machine in Microsoft Azure, configured networking and remote access, reviewed infrastructure dependencies, and created an incremental snapshot for recovery purposes.

This implementation demonstrates practical Azure Administrator skills including compute provisioning, network security configuration, remote connectivity validation, and backup strategy design.

---

## Objectives

- Deploy a Windows Server Virtual Machine in Azure
- Configure inbound security rules
- Understand Azure infrastructure dependencies
- Validate remote access via RDP
- Implement snapshot-based recovery strategy
- Verify deployment functionality

---

## Full Implementation

### Virtual Machine Configuration

- **Resource Group:** rg_eastus_XXXXX  
- **Virtual Machine Name:** WhizlabsVM  
- **Region:** East US  
- **Availability Option:** No infrastructure redundancy required  
- **Security Type:** Standard  
- **Image:** Windows Server 2025 Datacenter: Azure Edition - x64 Gen2  
- **VM Size:** B2s (B-Series)  
- **OS Disk Type:** Standard SSD  
- **Boot Diagnostics:** Disabled  

### Administrator Configuration

- **Username:** vm1  
- **Authentication:** Password  

### Inbound Port Rules

- HTTP (80)  
- HTTPS (443)  
- RDP (3389)  

### Snapshot Configuration

- **Snapshot Type:** Incremental  
- **Associated Disk:** OS Disk of WhizlabsVM  
- **Resource Group:** rg_eastus_XXXXX  

---

## Implementation Walkthrough

### Step 1 – Azure Portal Authentication

- Accessed Azure Portal (https://portal.azure.com)
- Verified correct Azure tenant
- Used clean session to prevent authentication conflicts

---

### Step 2 – Virtual Machine Deployment

1. Navigated to **Virtual Machines**
2. Selected **Create → Virtual Machine**
3. Configured:
   - Windows Server 2025 Azure Edition
   - B2s VM size
   - East US region
4. Configured administrator credentials
5. Allowed selected inbound ports (HTTP, HTTPS, RDP)
6. Selected Standard SSD for OS disk
7. Disabled Boot Diagnostics
8. Reviewed and deployed

**Security Analysis:**  
Allowing public RDP access increases attack surface. In production environments, best practice would include:

- Restricting RDP to specific IP ranges
- Using Azure Bastion
- Implementing Just-in-Time (JIT) VM access
- Enabling Defender for Cloud recommendations

---


### Step 3 – Deployment Resource Review

Azure automatically provisioned:

- Network Interface (NIC)
- Virtual Network (VNet)
- Public IP Address
- Network Security Group (NSG)

This demonstrates Azure’s infrastructure dependency model where compute and networking resources are tightly integrated.

# Azure Virtual Machine Deployment and Snapshot Strategy

## Introduction

In this project, I deployed a Windows Server 2025 Virtual Machine in Microsoft Azure, configured networking and remote access, reviewed infrastructure dependencies, and created an incremental snapshot for recovery purposes.

This implementation demonstrates practical Azure Administrator skills including compute provisioning, network security configuration, remote connectivity validation, and backup strategy design.

---

## Objectives

- Deploy a Windows Server Virtual Machine in Azure
- Configure inbound security rules
- Understand Azure infrastructure dependencies
- Validate remote access via RDP
- Implement snapshot-based recovery strategy
- Verify deployment functionality

---

## Full Implementation

### Virtual Machine Configuration

- **Resource Group:** rg_eastus_XXXXX  
- **Virtual Machine Name:** WhizlabsVM  
- **Region:** East US  
- **Availability Option:** No infrastructure redundancy required  
- **Security Type:** Standard  
- **Image:** Windows Server 2025 Datacenter: Azure Edition - x64 Gen2  
- **VM Size:** B2s (B-Series)  
- **OS Disk Type:** Standard SSD  
- **Boot Diagnostics:** Disabled  

### Administrator Configuration

- **Username:** vm1  
- **Authentication:** Password  

### Inbound Port Rules

- HTTP (80)  
- HTTPS (443)  
- RDP (3389)  

### Snapshot Configuration

- **Snapshot Type:** Incremental  
- **Associated Disk:** OS Disk of WhizlabsVM  
- **Resource Group:** rg_eastus_XXXXX  

---

## Implementation Walkthrough

### Step 1 – Azure Portal Authentication

- Accessed Azure Portal (https://portal.azure.com)
- Verified correct Azure tenant
- Used clean session to prevent authentication conflicts

---

### Step 2 – Virtual Machine Deployment

1. Navigated to **Virtual Machines**
2. Selected **Create → Virtual Machine**
3. Configured:
   - Windows Server 2025 Azure Edition
   - B2s VM size
   - East US region
4. Configured administrator credentials
5. Allowed selected inbound ports (HTTP, HTTPS, RDP)
6. Selected Standard SSD for OS disk
7. Disabled Boot Diagnostics
8. Reviewed and deployed

**Security Analysis:**  
Allowing public RDP access increases attack surface. In production environments, best practice would include:

- Restricting RDP to specific IP ranges
- Using Azure Bastion
- Implementing Just-in-Time (JIT) VM access
- Enabling Defender for Cloud recommendations
 
---

### Step 3 – Deployment Resource Review

Azure automatically provisioned:

- Network Interface (NIC)
- Virtual Network (VNet)
- Public IP Address
- Network Security Group (NSG)

This demonstrates Azure’s infrastructure dependency model where compute and networking resources are tightly integrated.

---

### Step 4 – Remote Desktop (RDP) Validation

1. Selected VM → Connect → RDP
2. Downloaded RDP file
3. Authenticated using configured credentials
4. Accepted certificate prompt
5. Successfully logged into Windows Server

Successful RDP access validated:

- NSG rule configuration
- Public IP accessibility
- Proper credential setup
 
 
---

### Step 5 – Snapshot Creation

1. Navigated to VM → Disks
2. Selected OS Disk
3. Chose **Create Snapshot**
4. Selected **Incremental**
5. Deployed snapshot

**Operational Purpose:**

- Capture disk state at a specific time
- Provide rollback capability
- Protect against configuration errors
- Support disaster recovery scenarios
 
---

## Results & Validation

- Virtual Machine successfully deployed
- Network components automatically provisioned
- NSG rules correctly applied
- RDP connectivity confirmed
- Incremental snapshot successfully created
- Snapshot visible under associated disk resources

The deployment is fully functional and recoverable.

---

## Validation Walkthrough

1. Verified VM status = Running
2. Confirmed assigned Public IP
3. Checked NSG inbound rule configuration
4. Confirmed successful RDP login
5. Navigated to Snapshots and verified snapshot resource
6. Confirmed snapshot type = Incremental

All objectives were validated successfully.

---

## Key Takeaways

- Azure VM deployment automatically provisions dependent networking resources.
- Public RDP access should be restricted in production environments.
- Incremental snapshots optimize storage usage while enabling rollback.
- Reviewing deployment details improves understanding of Azure architecture.
- Validation ensures operational readiness and security posture.

This project strengthens foundational Azure Administrator skills in compute deployment, networking configuration, secure remote access, and backup strategy implementation.


---

### Step 4 – Remote Desktop (RDP) Validation

1. Selected VM → Connect → RDP
2. Downloaded RDP file
3. Authenticated using configured credentials
4. Accepted certificate prompt
5. Successfully logged into Windows Server

Successful RDP access validated:

- NSG rule configuration
- Public IP accessibility
- Proper credential setup

# Azure Virtual Machine Deployment and Snapshot Strategy

## Introduction

In this project, I deployed a Windows Server 2025 Virtual Machine in Microsoft Azure, configured networking and remote access, reviewed infrastructure dependencies, and created an incremental snapshot for recovery purposes.

This implementation demonstrates practical Azure Administrator skills including compute provisioning, network security configuration, remote connectivity validation, and backup strategy design.

---

## Objectives

- Deploy a Windows Server Virtual Machine in Azure
- Configure inbound security rules
- Understand Azure infrastructure dependencies
- Validate remote access via RDP
- Implement snapshot-based recovery strategy
- Verify deployment functionality

---

## Full Implementation

### Virtual Machine Configuration

- **Resource Group:** rg_eastus_XXXXX  
- **Virtual Machine Name:** WhizlabsVM  
- **Region:** East US  
- **Availability Option:** No infrastructure redundancy required  
- **Security Type:** Standard  
- **Image:** Windows Server 2025 Datacenter: Azure Edition - x64 Gen2  
- **VM Size:** B2s (B-Series)  
- **OS Disk Type:** Standard SSD  
- **Boot Diagnostics:** Disabled  

### Administrator Configuration

- **Username:** vm1  
- **Authentication:** Password  

### Inbound Port Rules

- HTTP (80)  
- HTTPS (443)  
- RDP (3389)  

### Snapshot Configuration

- **Snapshot Type:** Incremental  
- **Associated Disk:** OS Disk of WhizlabsVM  
- **Resource Group:** rg_eastus_XXXXX  

---

## Implementation Walkthrough

### Step 1 – Azure Portal Authentication

- Accessed Azure Portal (https://portal.azure.com)
- Verified correct Azure tenant
- Used clean session to prevent authentication conflicts

---

### Step 2 – Virtual Machine Deployment

1. Navigated to **Virtual Machines**
2. Selected **Create → Virtual Machine**
3. Configured:
   - Windows Server 2025 Azure Edition
   - B2s VM size
   - East US region
4. Configured administrator credentials
5. Allowed selected inbound ports (HTTP, HTTPS, RDP)
6. Selected Standard SSD for OS disk
7. Disabled Boot Diagnostics
8. Reviewed and deployed

**Security Analysis:**  
Allowing public RDP access increases attack surface. In production environments, best practice would include:

- Restricting RDP to specific IP ranges
- Using Azure Bastion
- Implementing Just-in-Time (JIT) VM access
- Enabling Defender for Cloud recommendations
 <img width="1427" height="1544" alt="image" src="https://github.com/user-attachments/assets/ecf7caae-c305-479d-9fed-37749035e887" />

---

### Step 3 – Deployment Resource Review

Azure automatically provisioned:

- Network Interface (NIC)
- Virtual Network (VNet)
- Public IP Address
- Network Security Group (NSG)

This demonstrates Azure’s infrastructure dependency model where compute and networking resources are tightly integrated.

---

### Step 4 – Remote Desktop (RDP) Validation

1. Selected VM → Connect → RDP
2. Downloaded RDP file
3. Authenticated using configured credentials
4. Accepted certificate prompt
5. Successfully logged into Windows Server

Successful RDP access validated:

- NSG rule configuration
- Public IP accessibility
- Proper credential setup
 
 <img width="1523" height="647" alt="image" src="https://github.com/user-attachments/assets/9ffffb06-d309-45ac-9a0d-5925d0d585ec" />
<img width="1523" height="822" alt="image" src="https://github.com/user-attachments/assets/2e5841e6-324f-4f34-a51e-961c984b6160" />

---

### Step 5 – Snapshot Creation

1. Navigated to VM → Disks
2. Selected OS Disk
3. Chose **Create Snapshot**
4. Selected **Incremental**
5. Deployed snapshot

**Operational Purpose:**

- Capture disk state at a specific time
- Provide rollback capability
- Protect against configuration errors
- Support disaster recovery scenarios

 <img width="1523" height="570" alt="image" src="https://github.com/user-attachments/assets/a5e7d7ad-08ba-4762-a350-dd974c1fb236" />

---

## Results & Validation

- Virtual Machine successfully deployed
- Network components automatically provisioned
- NSG rules correctly applied
- RDP connectivity confirmed
- Incremental snapshot successfully created
- Snapshot visible under associated disk resources

The deployment is fully functional and recoverable.

---

## Validation Walkthrough

1. Verified VM status = Running
2. Confirmed assigned Public IP
3. Checked NSG inbound rule configuration
4. Confirmed successful RDP login
5. Navigated to Snapshots and verified snapshot resource
6. Confirmed snapshot type = Incremental

All objectives were validated successfully.

---

## Key Takeaways

- Azure VM deployment automatically provisions dependent networking resources.
- Public RDP access should be restricted in production environments.
- Incremental snapshots optimize storage usage while enabling rollback.
- Reviewing deployment details improves understanding of Azure architecture.
- Validation ensures operational readiness and security posture.

This project strengthens foundational Azure Administrator skills in compute deployment, networking configuration, secure remote access, and backup strategy implementation.


---

### Step 5 – Snapshot Creation

1. Navigated to VM → Disks
2. Selected OS Disk
3. Chose **Create Snapshot**
4. Selected **Incremental**
5. Deployed snapshot

**Operational Purpose:**

- Capture disk state at a specific time
- Provide rollback capability
- Protect against configuration errors
- Support disaster recovery scenarios

---

## Results & Validation

- Virtual Machine successfully deployed
- Network components automatically provisioned
- NSG rules correctly applied
- RDP connectivity confirmed
- Incremental snapshot successfully created
- Snapshot visible under associated disk resources

The deployment is fully functional and recoverable.

---

## Validation Walkthrough

1. Verified VM status = Running
2. Confirmed assigned Public IP
3. Checked NSG inbound rule configuration
4. Confirmed successful RDP login
5. Navigated to Snapshots and verified snapshot resource
6. Confirmed snapshot type = Incremental

All objectives were validated successfully.

---

## Key Takeaways

- Azure VM deployment automatically provisions dependent networking resources.
- Public RDP access should be restricted in production environments.
- Incremental snapshots optimize storage usage while enabling rollback.
- Reviewing deployment details improves understanding of Azure architecture.
- Validation ensures operational readiness and security posture.

This project strengthens foundational Azure Administrator skills in compute deployment, networking configuration, secure remote access, and backup strategy implementation.

