# Azure Windows Virtual Machine Extension Deployment with Network Watcher Agent

## Introduction

Azure Virtual Machines support **VM Extensions**, which allow administrators to install software, agents, and configuration packages after a virtual machine has already been deployed. This makes Azure VM management more scalable because software can be added without manually signing in to every machine first.

In this lab, a Windows Server virtual machine was created in Azure, and the **Network Watcher Agent for Windows** was deployed through the **Extensions + applications** blade. After the extension installation completed, the VM was accessed through **Remote Desktop Protocol (RDP)**, and the deployment was verified inside **Server Manager** by confirming that the agent service was running.

This lab demonstrates how Azure VM Extensions simplify post-deployment software installation and operational validation.

## Objectives

The objectives of this lab were to:

- Create a Windows virtual machine in Azure
- Deploy the **Network Watcher Agent for Windows** using VM Extensions
- Verify that the extension was added successfully in Azure Portal
- Connect to the VM using RDP
- Open Server Manager and Services
- Confirm that the Azure Network Watcher Agent service was running
- Understand how VM Extensions automate software deployment in Azure

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
                    | Windows VM   |
                    | DemoVM1      |
                    | Server 2025  |
                    +------+------+
                           |
         +-----------------+-----------------+
         |                                   |
+--------+--------+                 +--------+--------+
| VM Extension     |                 | RDP Access      |
| Network Watcher  |                 | Administrator   |
| Agent for Win    |                 | Validation      |
+--------+--------+                 +--------+--------+
         |                                   |
         +-----------------+-----------------+
                           |
                    +------+------+
                    | Server       |
                    | Manager      |
                    | Services     |
                    +------+------+
                           |
              Azure Network Watcher Agent Running
```

This architecture shows a Windows virtual machine receiving a VM extension from Azure, then being accessed through RDP so the installed agent can be verified inside the guest operating system.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser session is recommended to avoid Azure portal cache issues.

---

### Step 2 — Create the Windows Virtual Machine

Navigate to:

```text
Virtual Machines → Create → Azure virtual machine
```


Configure the virtual machine with the following settings:

| Setting | Value |
|---|---|
| Resource Group | rg_eastus_XXXXX |
| Virtual Machine Name | DemoVM1 |
| Region | East US |
| Availability Options | No infrastructure redundancy required |
| Security Type | Standard |
| Image | Windows Server 2025 Datacenter - x64 Gen2 |
| Size | B2s |
| Username | Vm1 |
| Password | User@1234567 |
| OS Disk Type | Standard SSD |

Leave the remaining options at default values.

Select:

```text
Next: Disks
```

Verify that the OS disk type remains:

```text
Standard SSD
```

Then select:

```text
Review + create → Create
```

After deployment completes, select:

```text
Go to resource
```

—
<img width="1511" height="1902" alt="image" src="https://github.com/user-attachments/assets/dd5997cb-8ca0-4b0b-aabe-fc5aa1f52bd8" />

### Step 3 — Deploy the VM Extension

From the virtual machine resource, navigate to:

```text
Settings → Extensions + applications
```

Select:

```text
Add
```

Search for:

```text
Network Watcher Agent for Windows
```

Select the extension and choose:

```text
Next → Review + Create → Create
```

Wait for the extension deployment to complete.

Return to:

```text
Extensions + applications
```

Expected result:

- The extension appears in the list
- Status shows that it was added successfully

—
<img width="1523" height="738" alt="image" src="https://github.com/user-attachments/assets/69364ece-e626-49fa-b9f6-b825ebb34d83" />


### Step 4 — Connect to the Virtual Machine with RDP

Return to the VM overview page.

Select:

```text
Connect → Connect
```

Then choose:

```text
Download RDP File
```

Open the downloaded `.rdp` file.

When prompted:

1. Select **Connect**
2. Select **Use a different account**
3. Enter the credentials:

| Setting | Value |
|---|---|
| Username | Vm1 |
| Password | User@1234567 |

4. Select **OK**
5. Accept the certificate warning by selecting **Yes**

After authentication completes, the Windows Server desktop loads.

---

### Step 5 — Verify the Extension Deployment

Inside the VM:

1. Open the **Windows Start menu**
2. Launch:

```text
Server Manager
```

3. Select:

```text
Tools → Services
```

In the Services console, look for:

```text
Azure Network Watcher Agent
```

Expected result:

- The service is present
- Status shows **Running**

This confirms that the VM extension successfully installed the Network Watcher Agent inside the guest operating system.
<img width="1523" height="675" alt="image" src="https://github.com/user-attachments/assets/9060fb08-ef6e-4a75-a7b2-6cf765123adb" />


## Azure CLI (Bash)

Create the Windows VM:

```bash
az vm create \
  --resource-group rg_eastus_XXXXX \
  --name DemoVM1 \
  --image Win2025Datacenter \
  --size Standard_B2s \
  --admin-username Vm1 \
  --admin-password 'User@1234567' \
  --storage-sku StandardSSD_LRS
```

Install the Network Watcher Agent extension:

```bash
az vm extension set \
  --resource-group rg_eastus_XXXXX \
  --vm-name DemoVM1 \
  --name NetworkWatcherAgentWindows \
  --publisher Microsoft.Azure.NetworkWatcher \
  --version 1.4
```

List installed VM extensions:

```bash
az vm extension list \
  --resource-group rg_eastus_XXXXX \
  --vm-name DemoVM1 \
  --output table
```

Show VM public IP:

```bash
az vm show \
  --resource-group rg_eastus_XXXXX \
  --name DemoVM1 \
  --show-details \
  --query publicIps \
  --output tsv
```

## Azure PowerShell

Create the Windows VM:

```powershell
New-AzVM `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "DemoVM1" `
  -Location "East US" `
  -Image "Win2025Datacenter" `
  -Size "Standard_B2s" `
  -Credential (Get-Credential)
```

Install the Network Watcher Agent extension:

```powershell
Set-AzVMExtension `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -VMName "DemoVM1" `
  -Name "NetworkWatcherAgentWindows" `
  -Publisher "Microsoft.Azure.NetworkWatcher" `
  -ExtensionType "NetworkWatcherAgentWindows" `
  -TypeHandlerVersion "1.4" `
  -Location "East US"
```

View installed extensions:

```powershell
Get-AzVMExtension `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -VMName "DemoVM1"
```

Get the VM public IP:

```powershell
(Get-AzPublicIpAddress -ResourceGroupName "rg_eastus_XXXXX").IpAddress
```

## Full Implementation

The lab began by creating a Windows Server 2025 virtual machine named `DemoVM1` in the assigned resource group in East US. The machine used the **Standard** security type, a **B2s** VM size, and a **Standard SSD** operating system disk. This provided the base compute resource that would later receive the extension package.

After the virtual machine was deployed, the **Extensions + applications** blade was used to install the **Network Watcher Agent for Windows**. This showed how Azure can deploy post-build software directly from the control plane without needing to sign in to the operating system first. Once the extension deployment finished, the Azure Portal confirmed that it had been added successfully.

The final stage was guest operating system validation. The VM was accessed through RDP using the configured administrator account. Inside the machine, **Server Manager** and the **Services** console were used to verify that the **Azure Network Watcher Agent** service existed and was actively running. This proved that the extension deployment did not just succeed in Azure metadata, but also completed correctly within the Windows operating system.

## Implementation Walkthrough

The lab followed a simple but operationally important sequence: first deploy the compute resource, then attach an Azure-managed extension, then validate the software at the guest OS layer. This pattern reflects real cloud administration workflows where infrastructure is provisioned centrally and agents are installed after deployment for monitoring, diagnostics, or configuration management.

The extension selected for this lab was the **Network Watcher Agent for Windows**, which is relevant because Azure Network Watcher features often depend on supporting software running within the VM. By using the VM extension model, Azure handled software delivery and installation from the platform side.

The final verification step inside Server Manager was critical. It demonstrated that successful extension deployment in the portal should always be matched by checking that the expected service or application is actually present and running in the virtual machine.

## Results & Validation

| Test | Result |
|---|---|
| Windows VM deployment | Successful |
| Network Watcher Agent extension deployment | Successful |
| Extension visible in Azure Portal | Successful |
| RDP connection to VM | Successful |
| Server Manager access | Successful |
| Azure Network Watcher Agent service verification | Successful |
| Agent service running state | Successful |

Key observations:

- Azure VM Extensions allow software installation after VM deployment
- The Network Watcher Agent could be added without manually logging in first
- Azure Portal showed successful extension deployment status
- Guest OS validation confirmed the service was actually installed and running
- VM Extensions improve repeatability and reduce manual configuration steps

## Validation Walkthrough

1. Verified that `DemoVM1` was created successfully in `rg_eastus_XXXXX`.
2. Confirmed the VM used **Windows Server 2025 Datacenter - x64 Gen2** and **Standard SSD**.
3. Opened **Extensions + applications** from the VM resource.
4. Added the **Network Watcher Agent for Windows** extension.
5. Waited for deployment to complete and verified that the extension appeared successfully in the portal.
6. Downloaded the RDP file from the VM overview page.
7. Connected to the VM using the username `Vm1` and password `User@1234567`.
8. Opened **Server Manager** inside the VM.
9. Navigated to **Tools → Services**.
10. Located **Azure Network Watcher Agent** in the services list.
11. Confirmed that the service status showed **Running**.

## Real-World Use Case

VM Extensions are commonly used when organizations need to deploy management agents, monitoring tools, security software, or custom scripts across many virtual machines.

Example: **Post-Deployment Monitoring Agent Installation**

| Component | Role |
|---|---|
| Azure VM | Hosts the workload |
| VM Extension | Installs required software |
| Network Watcher Agent | Supports monitoring and diagnostics |
| RDP | Used for validation |
| Services Console | Confirms the installed agent is running |

Typical workflow:

```text
Virtual Machine Deployed
        ↓
Azure Extension Added
        ↓
Agent Installed Automatically
        ↓
Administrator Connects by RDP
        ↓
Service Verified Inside Windows
```

This pattern is useful for monitoring rollout, diagnostics enablement, security agent deployment, and standardized post-build configuration across cloud environments.

## Key Takeaways

This lab demonstrated several important Azure administration concepts:

- Azure VM Extensions automate software deployment after VM creation
- Windows virtual machines can be extended without manual installation from the start
- The Network Watcher Agent can be deployed through the Azure control plane
- RDP and Server Manager are useful for validating extension installation inside the guest OS
- Successful cloud operations require both platform-side and guest OS-side verification

Understanding Azure VM Extensions is valuable for cloud administrators, infrastructure engineers, and operations teams responsible for scalable software deployment and VM lifecycle management.

