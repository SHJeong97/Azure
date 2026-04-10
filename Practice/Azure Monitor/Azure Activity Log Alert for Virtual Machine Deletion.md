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
- Validate that monitoring is configured for VM deletion events
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
                    | Delete VM    |
                    +------+------+
                           |
                    +------+------+
                    | Action Group |
                    | Email Alert  |
                    +------+------+
                           |
                      Administrator
```

This architecture shows how a VM deletion event is written to the Azure Activity Log, evaluated by an alert rule, and forwarded through an Action Group to notify an administrator by email.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser window is recommended to avoid portal cache issues. 

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
| Architecture | x64 |
| Size | B2s |
| Authentication Type | Password |
| Username | vm1 |
| Public Inbound Ports | None |
| OS Disk Type | Standard SSD |

Review the configuration and deploy the virtual machine.
### Step 3 — Open Azure Monitor and Create an Alert Rule

Navigate to:

```text
Monitor → Alerts → Create → Alert rule
```

For the **scope**, select:

- Resource type: **Virtual machines**
- Resource group: **rg_eastus_XXXXX**

This scopes the alert to all virtual machines in the resource group rather than only a single VM. 


### Step 4 — Configure the Alert Condition

In the **Condition** tab, search for the signal:

```text
Delete Virtual Machine (Microsoft.Compute/virtualMachines)
```

Select the signal and apply it.

Leave the alert logic at the default setting so that **all matching delete events** trigger the alert. 
<img width="1523" height="1148" alt="image" src="https://github.com/user-attachments/assets/c0816258-7234-4687-9b1a-de2e77f8b2cf" />

### Step 5 — Create an Email Action Group

From the **Actions** tab, select:

```text
Create action group
```

Create an Action Group that sends an email notification to the desired email address.

This ensures that when a virtual machine deletion event occurs, Azure Monitor forwards the event through the Action Group and generates an email alert. 
<img width="1523" height="1692" alt="image" src="https://github.com/user-attachments/assets/11a792d4-cc19-4a50-9ecc-906874331490" />
<img width="1523" height="1092" alt="image" src="https://github.com/user-attachments/assets/eb889758-20de-47d8-ac7a-143fb2fc4236" />



### Step 6 — Complete the Alert Rule

After the scope, condition, and action group are configured:

1. Review the alert rule settings
2. Provide a rule name
3. Create the alert rule

The rule now monitors the resource group for any virtual machine deletion events and sends notifications when triggered.
<img width="1523" height="658" alt="image" src="https://github.com/user-attachments/assets/70e65e33-2638-40ef-894d-a0e268170fc7" />



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
  --short-name vmDeleteAG
```

Add an email receiver to the Action Group:

```bash
az monitor action-group update \
  --resource-group rg_eastus_XXXXX \
  --name vmDeleteEmailAG \
  --add-action email adminEmail admin@example.com
```

Create the Activity Log alert for VM deletion:

```bash
az monitor activity-log alert create \
  --resource-group rg_eastus_XXXXX \
  --name vm-delete-alert \
  --scope /subscriptions/<subscription-id>/resourceGroups/rg_eastus_XXXXX \
  --condition category=Administrative and operationName=Microsoft.Compute/virtualMachines/delete \
  --action-group vmDeleteEmailAG
```

List configured Activity Log alerts:

```bash
az monitor activity-log alert list \
  --resource-group rg_eastus_XXXXX
```

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

Create an email receiver for the Action Group:

```powershell
$email = New-AzActionGroupReceiver `
  -Name "AdminEmail" `
  -EmailReceiver `
  -EmailAddress "admin@example.com"
```

Create the Action Group:

```powershell
Set-AzActionGroup `
  -Name "vmDeleteEmailAG" `
  -ShortName "vmDelAG" `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Receiver $email
```

Create the Activity Log alert:

```powershell
New-AzActivityLogAlert `
  -Name "vm-delete-alert" `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Location "Global" `
  -Scope "/subscriptions/<subscription-id>/resourceGroups/rg_eastus_XXXXX" `
  -Condition @{Field="operationName";Equals="Microsoft.Compute/virtualMachines/delete"} `
  -ActionGroupId "/subscriptions/<subscription-id>/resourceGroups/rg_eastus_XXXXX/providers/microsoft.insights/actionGroups/vmDeleteEmailAG"
```

View the configured alert:

```powershell
Get-AzActivityLogAlert `
  -ResourceGroupName "rg_eastus_XXXXX"
```

## Implementation Walkthrough

The lab began by deploying a Linux virtual machine that would serve as the monitored resource. Azure Monitor was then opened, and an alert rule was created with the scope set to all virtual machines in the selected resource group. This design means the alert is reusable and not limited to only one VM.

Next, the condition was configured to listen for the **Delete Virtual Machine** Activity Log signal. This is important because the Activity Log captures management operations performed against Azure resources, including deletion events. An Action Group was then created so Azure Monitor could send an email notification whenever the alert condition is met.

This implementation demonstrates practical operational monitoring because it focuses on a high-value management event: unexpected virtual machine deletion.

## Results & Validation

| Test | Result |
|---|---|
| Virtual machine deployment | Successful |
| Azure Monitor alert rule creation | Successful |
| Scope configured for all VMs in resource group | Successful |
| Delete Virtual Machine signal selected | Successful |
| Email Action Group creation | Successful |
| Alert rule completion | Successful |

Key observations:

- Azure Activity Log alerts can monitor management-plane operations without requiring guest agents
- Resource group scoping makes the alert reusable for multiple virtual machines
- Action Groups provide the delivery mechanism for notifications
- VM deletion is an important governance and security monitoring event

## Validation Walkthrough

1. Verified that `demoVM1` was successfully deployed in `rg_eastus_XXXXX`.
2. Opened Azure Monitor and navigated to **Alerts**.
3. Created a new alert rule scoped to **all virtual machines** in the target resource group.
4. Selected the signal **Delete Virtual Machine (Microsoft.Compute/virtualMachines)**.
5. Created an Action Group with an email notification receiver.
6. Attached the Action Group to the alert rule.
7. Reviewed the rule configuration and created the alert successfully.
8. Confirmed that the rule now monitors VM deletion events in the resource group.

## Real-World Use Case

Azure Activity Log alerts are commonly used in environments where infrastructure changes must be monitored closely.

Example: **Production Infrastructure Change Monitoring**

| Event Type | Why It Matters |
|---|---|
| Virtual machine deletion | Prevents unnoticed removal of critical servers |
| Network security group changes | Detects access control drift |
| Resource lock removal | Identifies governance bypass attempts |
| Policy assignment changes | Tracks compliance-impacting actions |

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
Ops Team Investigates Immediately
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

