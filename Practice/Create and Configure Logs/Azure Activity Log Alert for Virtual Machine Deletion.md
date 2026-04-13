# Azure Activity Log Alert for Virtual Machine Deletion

## Introduction

Azure Monitor helps administrators observe resource activity, detect important operational events, and respond quickly when changes occur in the environment. One of its most useful governance features is the ability to create **Activity Log alerts** for management-plane operations such as creating, updating, or deleting Azure resources.

In this lab, an Azure Virtual Machine was deployed and an **Azure Activity Log alert rule** was configured to detect when any virtual machine in the target resource group is deleted. An **Action Group** was then created to send an email notification whenever that event occurs.

This lab demonstrates how Azure monitoring can be used to improve visibility, governance, and response readiness for critical infrastructure events.

## Objectives

The objectives of this lab were to:

- Deploy an Azure Virtual Machine
- Open Azure Monitor and configure an alert rule
- Scope the alert to all virtual machines in the target resource group
- Use the **Delete Virtual Machine** signal as the trigger condition
- Create an **Action Group** for email notifications
- Delete the virtual machine to trigger the alert
- Review the resulting alert inside Azure Monitor
- Understand how Azure Activity Log alerts support operational monitoring and governance

## Architecture Diagram

```text
                +----------------------+
                |   Azure Subscription |
                |    Pay-As-You-Go     |
                +----------+-----------+
                           |
                +----------+-----------+
                |       Resource Group |
                |     rg_eastus_xxxxx  |
                +----------+-----------+
                           |
                    +------+------+
                    | Virtual     |
                    | Machine     |
                    | demoVM1     |
                    +------+------+
                           |
                 Delete Operation Event
                           |
                    +------+------+
                    | Azure       |
                    | Activity Log|
                    +------+------+
                           |
                    +------+------+
                    | Alert Rule   |
                    | VM was       |
                    | deleted      |
                    +------+------+
                           |
                    +------+------+
                    | Action Group |
                    | DemoAlert    |
                    +------+------+
                           |
                      Email Notification
                           |
                      Operations Team
```

This architecture shows how a VM deletion event is written to the Azure Activity Log, evaluated by an alert rule, and forwarded through an Action Group to notify the operations team by email.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser window is recommended to avoid Azure portal cache issues.

---

### Step 2 — Create a Virtual Machine

Navigate to:

```text
Virtual Machines → Create
```

Configure the virtual machine with the following values:

| Setting | Value |
|---|---|
| Subscription | Pay-As-You-Go |
| Resource Group | rg_eastus_XXXXX |
| Virtual Machine Name | demoVM1 |
| Region | East US |
| Availability Options | No infrastructure redundancy required |
| Security Type | Standard |
| Image | Ubuntu Server 24.04 LTS - x64 Gen2 |
| VM Architecture | x64 |
| Size | B2s |
| Authentication Type | Password |
| Username | vm1 |
| Password | UserUser@1234567 |
| Public Inbound Ports | None |
| OS Disk Type | Standard SSD |

Review the configuration and create the virtual machine.

---

### Step 3 — Create the Azure Activity Log Monitor

Navigate to:

```text
Monitor → Alerts → Create → Alert rule
```

For the **scope**, select:

- Resource type: **Virtual machines**
- Resource group: **rg_eastus_XXXXX**

This scopes the alert to all virtual machines in the resource group rather than just one individual VM.

---

### Step 4 — Configure the Alert Condition

In the **Condition** tab, select:

```text
See all signals
```

Search for:

```text
Delete
```

Then select the signal:

```text
Delete Virtual Machine (Microsoft.Compute/virtualMachines)
```

Apply the signal.

Leave the **Alert logic** at its default setting so that all matching delete events trigger the alert.

---

### Step 5 — Add an Email Alert Action

From the **Actions** tab, select:

```text
Create action group
```

Configure the Action Group with the following values:

| Setting | Value |
|---|---|
| Resource Group | rg_eastus_XXXXX |
| Subscription | Pay-As-You-Go |
| Action Group Name | Alert the operations team |
| Display Name | DemoAlert |

Under **Notifications**, configure:

| Setting | Value |
|---|---|
| Notification Type | Email/SMS message/Push/Voice |
| Name | VM was deleted |
| Email | Your email address |

Save the notification and create the Action Group.

---

### Step 6 — Complete the Alert Rule

In the **Details** tab, configure:

| Setting | Value |
|---|---|
| Resource Group | rg_eastus_XXXXX |
| Alert Rule Name | VM was deleted |
| Description | A VM in your resource group was deleted |
| Enable Alert Rule Upon Creation | Yes |

Review and create the alert rule.

The rule now monitors the resource group for virtual machine deletion events and sends email notifications when triggered.

---

### Step 7 — Delete the Virtual Machine

Navigate to:

```text
Virtual Machines → demoVM1
```

Select:

```text
Delete
```

Confirm the deletion by checking the confirmation box and then selecting **Delete**.

Wait until Azure notifications confirm that `demoVM1` has been deleted.

---

### Step 8 — View Your Activity Log Alerts

Navigate to:

```text
Monitor → Alerts
```

Review the generated alert entries.

Select the alert named:

```text
VM was deleted
```

Open **Alert details** to review the event information and confirm that the rule was triggered by the deletion of `demoVM1`.

---

### Azure CLI (Bash)

Create the virtual machine:

```bash
az vm create \
  --resource-group rg_eastus_XXXXX \
  --name demoVM1 \
  --image Ubuntu2404 \
  --size Standard_B2s \
  --admin-username vm1 \
  --admin-password 'UserUser@1234567' \
  --public-ip-address ""
```

Create an Action Group:

```bash
az monitor action-group create \
  --resource-group rg_eastus_XXXXX \
  --name vmDeleteEmailAG \
  --short-name DemoAlert
```

Add an email receiver to the Action Group:

```bash
az monitor action-group update \
  --resource-group rg_eastus_XXXXX \
  --name vmDeleteEmailAG \
  --add-action email vmDeletedAlert yourname@example.com
```

Create the Activity Log alert:

```bash
az monitor activity-log alert create \
  --resource-group rg_eastus_XXXXX \
  --name "VM was deleted" \
  --scope /subscriptions/<subscription-id>/resourceGroups/rg_eastus_XXXXX \
  --condition category=Administrative and operationName=Microsoft.Compute/virtualMachines/delete \
  --action-group vmDeleteEmailAG
```

Delete the virtual machine:

```bash
az vm delete \
  --resource-group rg_eastus_XXXXX \
  --name demoVM1 \
  --yes
```

List alerts:

```bash
az monitor activity-log alert list \
  --resource-group rg_eastus_XXXXX
```

---

### Azure PowerShell

Create the virtual machine:

```powershell
New-AzVM `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "demoVM1" `
  -Image "Ubuntu2404" `
  -Size "Standard_B2s" `
  -Credential (Get-Credential)
```

Create an email receiver:

```powershell
$email = New-AzActionGroupReceiver `
  -Name "VMDeletedEmail" `
  -EmailReceiver `
  -EmailAddress "yourname@example.com"
```

Create the Action Group:

```powershell
Set-AzActionGroup `
  -Name "vmDeleteEmailAG" `
  -ShortName "DemoAlert" `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Receiver $email
```

Create the Activity Log alert:

```powershell
New-AzActivityLogAlert `
  -Name "VM was deleted" `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Location "Global" `
  -Scope "/subscriptions/<subscription-id>/resourceGroups/rg_eastus_XXXXX" `
  -Condition @{Field="operationName";Equals="Microsoft.Compute/virtualMachines/delete"} `
  -ActionGroupId "/subscriptions/<subscription-id>/resourceGroups/rg_eastus_XXXXX/providers/microsoft.insights/actionGroups/vmDeleteEmailAG"
```

Delete the virtual machine:

```powershell
Remove-AzVM `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "demoVM1" `
  -Force
```

View configured alerts:

```powershell
Get-AzActivityLogAlert `
  -ResourceGroupName "rg_eastus_XXXXX"
```

## Implementation Walkthrough

The lab began by deploying a Linux virtual machine that would act as the monitored resource. Azure Monitor was then opened, and an alert rule was created with the scope set to **all virtual machines in the resource group**. This design is useful because it makes the alert reusable and not limited to only one specific VM.

Next, the condition was configured to look for the **Delete Virtual Machine** signal inside the Azure Activity Log. This is important because the Activity Log records management-plane events such as resource creation, updates, and deletion. After that, an Action Group was created so Azure Monitor could deliver an email notification whenever the alert condition is met.

Finally, the VM was deleted to generate the matching event, and Azure Monitor displayed the resulting alert. This demonstrates practical operational monitoring focused on a high-value event: unexpected virtual machine deletion.

## Results & Validation

| Test | Result |
|---|---|
| Virtual machine deployment | Successful |
| Azure Monitor alert rule creation | Successful |
| Scope configured for all VMs in resource group | Successful |
| Delete Virtual Machine signal selected | Successful |
| Email Action Group creation | Successful |
| Alert rule completion | Successful |
| Virtual machine deletion | Successful |
| Alert generated in Azure Monitor | Successful |

Key observations:

- Azure Activity Log alerts can monitor management-plane operations without requiring guest agents
- Resource group scoping makes the alert reusable for multiple virtual machines
- Action Groups provide the notification delivery mechanism
- VM deletion is an important governance and operational monitoring event
- Azure Monitor provides both email notification and in-portal alert visibility

## Validation Walkthrough

1. Verified that `demoVM1` was successfully deployed in `rg_eastus_XXXXX`.
2. Opened Azure Monitor and navigated to **Alerts**.
3. Created a new alert rule scoped to **all virtual machines** in the resource group.
4. Selected the signal **Delete Virtual Machine (Microsoft.Compute/virtualMachines)**.
5. Created an Action Group with an email notification receiver.
6. Attached the Action Group to the alert rule.
7. Reviewed the rule configuration and created the alert successfully.
8. Deleted `demoVM1`.
9. Verified that Azure notifications confirmed the VM deletion.
10. Opened **Monitor → Alerts** and confirmed that the alert named **VM was deleted** appeared.
11. Opened the alert details pane and confirmed the event matched the VM deletion activity.

## Real-World Use Case

Azure Activity Log alerts are commonly used in environments where infrastructure changes must be monitored closely.

Example: **Production Infrastructure Change Monitoring**

| Event Type | Why It Matters |
|---|---|
| Virtual machine deletion | Prevents unnoticed removal of critical servers |
| Network security group changes | Detects access control drift |
| Resource lock removal | Identifies governance bypass attempts |
| Policy assignment changes | Tracks compliance-impacting changes |

Typical workflow:

```text
Admin or Process Deletes VM
          ↓
Azure Activity Log Records Event
          ↓
Alert Rule Evaluates Matching Signal
          ↓
Action Group Sends Email Notification
          ↓
Operations Team Investigates Immediately
```

This approach improves operational awareness, supports incident response, and helps organizations detect destructive changes more quickly.

## Key Takeaways

This lab demonstrated several important Azure monitoring and governance concepts:

- Azure Activity Log alerts monitor management-plane events such as resource deletion
- Alert rules can be scoped to a resource group to cover multiple virtual machines
- The **Delete Virtual Machine** signal is valuable for security and operational monitoring
- Action Groups allow Azure Monitor alerts to notify administrators through email
- Monitoring resource deletion events strengthens governance and change visibility

Understanding Azure Monitor Activity Log alerts is essential for cloud administrators, Azure engineers, and operations teams responsible for tracking critical infrastructure changes.

