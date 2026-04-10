# Azure Resource Locks for Virtual Machine Protection

## Introduction

Azure Resource Locks provide an additional layer of protection against accidental deletion or modification of critical cloud resources. These locks are especially useful in production, testing, and shared administrative environments where multiple users may have access to the same infrastructure.

Azure supports two primary lock types:

| Lock Type | Effect |
|---|---|
| Delete | Prevents the resource from being deleted |
| Read-only | Prevents changes and deletion |

In this lab, an Azure Virtual Machine was deployed, a **Delete lock** was applied directly to the VM, and a **Read-only lock** was applied to the resource group. This demonstrated how Azure management locks can protect resources at different scopes and how those locks affect administrative operations.

---

## Objectives

The objectives of this lab were to:

- Deploy an Azure Virtual Machine
- Apply a **Delete lock** to the VM
- Apply a **Read-only lock** to the resource group
- Observe how management locks prevent deletion and modification
- Remove the locks to restore administrative control
- Understand how Azure locks support governance and resource protection

---

## Architecture Diagram

```
                +----------------------+
                |   Azure Subscription |
                +----------+-----------+
                           |
                +----------+-----------+
                |       Resource Group |
                |     rg_eastus_xxxxx  |
                |  Read-only Lock      |
                +----------+-----------+
                           |
                    +------+------+
                    | Virtual VM  |
                    |   demoVM1   |
                    | Delete Lock |
                    +------+------+
                           |
                    +------+------+
                    |   OS Disk    |
                    | Standard SSD |
                    +-------------+
```

This architecture shows how Azure management locks can be applied at different scopes, with the resource group protected by a **Read-only lock** and the virtual machine protected by a **Delete lock**.

---

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito window is recommended to avoid cached sign-in issues.

---

### Step 2 — Deploy a Virtual Machine

Navigate to:

```text
Create a Resource → Virtual Machine
```

Configure the VM with the following settings:

| Setting | Value |
|---|---|
| Resource Group | rg_eastus_XXXXX |
| Virtual Machine Name | demoVM1 |
| Availability Options | No infrastructure redundancy required |
| Security Type | Trusted launch virtual machines |
| Image | Ubuntu Server 22.04 LTS - x64 Gen2 |
| Size | B2s |
| Authentication Type | Password |
| Username | vm1 |
| Password | User@1234567 |
| Disk Type | Standard SSD (Locally-redundant Storage) |

Review the configuration and deploy the VM.

—
<img width="1477" height="1914" alt="image" src="https://github.com/user-attachments/assets/5244221d-9857-44cc-8373-ce9b245d4ab0" />


### Step 3 — Create a Delete Lock on the Virtual Machine

After the VM deployment completes, open the virtual machine resource.

Navigate to:

```text
Virtual Machine → Settings → Locks → Add
```

Configure the lock:

| Setting | Value |
|---|---|
| Lock Name | demoDel |
| Lock Type | Delete |

Apply the lock.

This prevents the virtual machine from being deleted.

—
<img width="1523" height="1628" alt="image" src="https://github.com/user-attachments/assets/aa4642f8-0a39-4a4f-b260-01ae7c15db85" />



### Step 4 — Create a Read-only Lock on the Resource Group

Open the resource group.

Navigate to:

```text
Resource Group → Settings → Locks → Add
```

Configure the lock:

| Setting | Value |
|---|---|
| Lock Name | demoRead |
| Lock Type | Read-only |

Apply the lock.

This prevents changes or deletions to resources within that scope unless the lock is removed.

—
<img width="1523" height="708" alt="image" src="https://github.com/user-attachments/assets/9d53df41-5242-4478-8b72-6afd555f33e0" />


### Step 5 — Verify Lock Behavior

Attempt to delete the virtual machine.

Expected result:

- The deletion attempt fails because of the **Delete lock**
- Resource modifications may also fail because of the **Read-only lock** at the resource group level

This validates that Azure management locks are functioning as intended.

—
<img width="1523" height="528" alt="image" src="https://github.com/user-attachments/assets/2cd0aec5-6671-4c8c-914f-233a6cc2090d" />


### Step 6 — Remove the Locks

To restore administrative access, navigate back to the resource group lock settings.

Delete both locks:

- `demoDel`
- `demoRead`

After removing the locks, resources can again be modified or deleted.

---

### Azure CLI (Bash)

Create the virtual machine:

```bash
az vm create \
  --resource-group rg_eastus_XXXXX \
  --name demoVM1 \
  --image Ubuntu2204 \
  --size Standard_B2s \
  --admin-username vm1 \
  --admin-password 'User@1234567'
```

Create a Delete lock on the VM:

```bash
az lock create \
  --name demoDel \
  --lock-type CanNotDelete \
  --resource-group rg_eastus_XXXXX \
  --resource-name demoVM1 \
  --resource-type Microsoft.Compute/virtualMachines
```

Create a Read-only lock on the resource group:

```bash
az lock create \
  --name demoRead \
  --lock-type ReadOnly \
  --resource-group rg_eastus_XXXXX
```

List locks:

```bash
az lock list --resource-group rg_eastus_XXXXX
```

Delete locks:

```bash
az lock delete --name demoDel --resource-group rg_eastus_XXXXX
az lock delete --name demoRead --resource-group rg_eastus_XXXXX
```

---

### Azure PowerShell

Create the virtual machine:

```powershell
New-AzVM `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "demoVM1" `
  -Image "Ubuntu2204" `
  -Size "Standard_B2s" `
  -Credential (Get-Credential)
```

Create a Delete lock on the VM:

```powershell
New-AzResourceLock `
  -LockName "demoDel" `
  -LockLevel CanNotDelete `
  -ResourceName "demoVM1" `
  -ResourceType "Microsoft.Compute/virtualMachines" `
  -ResourceGroupName "rg_eastus_XXXXX"
```

Create a Read-only lock on the resource group:

```powershell
New-AzResourceLock `
  -LockName "demoRead" `
  -LockLevel ReadOnly `
  -ResourceGroupName "rg_eastus_XXXXX"
```

View locks:

```powershell
Get-AzResourceLock -ResourceGroupName "rg_eastus_XXXXX"
```

Delete locks:

```powershell
Remove-AzResourceLock -LockName "demoDel" -ResourceGroupName "rg_eastus_XXXXX"
Remove-AzResourceLock -LockName "demoRead" -ResourceGroupName "rg_eastus_XXXXX"
```

---

## Implementation Walkthrough

The lab demonstrated Azure governance controls through management locks.

First, a virtual machine was deployed as the target resource. A **Delete lock** was then placed directly on the VM to prevent accidental removal. After that, a **Read-only lock** was applied at the resource group level, which extended protection to the broader scope and prevented administrative changes.

This setup demonstrates how Azure applies governance controls at multiple levels:

- **Resource level** for targeted protection
- **Resource group level** for broader operational control

The lab also showed that locks must be intentionally removed before destructive or modifying actions can proceed.

---

## Results & Validation

| Test | Result |
|---|---|
| Virtual machine deployment | Successful |
| Delete lock on VM | Successful |
| Read-only lock on resource group | Successful |
| VM deletion attempt while locked | Blocked |
| Resource modification attempt while locked | Blocked |
| Lock removal | Successful |

Key observations:

- A **Delete lock** prevents resource deletion but still allows read operations
- A **Read-only lock** prevents changes and deletion
- Locks help enforce operational discipline and reduce accidental administrative mistakes

---

## Validation Walkthrough

1. Verified that the virtual machine `demoVM1` was successfully created.
2. Opened the VM lock settings and applied the `demoDel` Delete lock.
3. Opened the resource group lock settings and applied the `demoRead` Read-only lock.
4. Attempted to delete the virtual machine and confirmed the operation failed.
5. Confirmed that modification actions were restricted due to the resource group lock.
6. Navigated back to the lock settings and deleted both locks.
7. Confirmed the locks were removed successfully.

---

## Real-World Use Case

Azure Resource Locks are commonly used in environments where infrastructure stability is critical.

Example: **Production Workload Protection**

| Resource | Lock Type | Purpose |
|---|---|---|
| Production VM | Delete | Prevent accidental deletion |
| Resource Group | Read-only | Prevent unauthorized changes |
| Shared Infrastructure | Delete / Read-only | Governance and change control |

Typical use case:

```text
Production VM → Delete Lock
Production Resource Group → Read-only Lock
Admin Change Request → Remove Lock Temporarily → Approve Change
```

This approach is useful in organizations that follow change management, governance, and operational control standards.

---

## Key Takeaways

This lab demonstrated several important Azure governance concepts:

- Azure Resource Locks help protect cloud resources from accidental deletion or modification
- **Delete locks** prevent removal of important resources
- **Read-only locks** enforce stronger protection by blocking changes
- Locks can be applied at different scopes, including the resource and resource group levels
- Proper use of locks improves governance, operational safety, and change control

Understanding Azure management locks is essential for cloud administrators, Azure engineers, and security-focused infrastructure teams responsible for protecting production resources.

