# Azure Storage Queue Management with Message Insertion and Dequeue Operations

## Introduction

Azure Queue Storage is a messaging service within Azure Storage that allows applications and administrators to store and retrieve large numbers of messages. It is commonly used for asynchronous processing, workload decoupling, background jobs, and communication between distributed application components.

In this lab, an Azure Storage Account was created with support for **tables and queues**, a queue was provisioned, and messages were added with expiration and encoding settings. The queue was then tested by dequeuing the first message, demonstrating first-in-first-out style message handling behavior at the queue level.

This lab demonstrates how Azure Queue Storage can be used to manage lightweight messaging workloads in a simple and scalable way.

## Objectives

The objectives of this lab were to:

- Create an Azure Storage Account for queue services
- Create a new Azure Queue
- Add messages to the queue
- Configure message expiration settings
- Use Base64 message encoding
- Dequeue a message from the queue
- Observe how Azure Queue Storage removes the first inserted message

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
                    | Storage     |
                    | Account     |
                    | Standard LRS|
                    +------+------+
                           |
                    +------+------+
                    | Azure Queue |
                    | demoqueue1  |
                    +------+------+
                           |
         +-----------------+-----------------+
         |                                   |
+--------+--------+                 +--------+--------+
| Message 1       |                 | Message 2       |
| Test Message    |                 | My Second       |
| Base64 Encoded  |                 | Message         |
+-----------------+                 +-----------------+
                           |
                    +------+------+
                    | Dequeue      |
                    | Operation    |
                    +------+------+
                           |
                 First Inserted Message Removed
```

This architecture shows a storage account hosting an Azure Queue where multiple messages are inserted and the first message is removed through a dequeue operation.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser session is recommended to avoid Azure portal cache issues.

---

### Step 2 — Create the Storage Account

Navigate to:

```text
Storage Accounts → Create
```

Configure the storage account with the following values:

| Setting | Value |
|---|---|
| Subscription | Pay-As-You-Go |
| Resource Group | Assigned lab resource group |
| Storage Account Name | Unique lowercase name |
| Region | East US |
| Primary Service | Other (tables and queues) |
| Performance | Standard |
| Redundancy | LRS |

Review the configuration and create the storage account.

This storage account provides the queue service used in the rest of the lab.

---

### Step 3 — Create a Queue

Open the newly created storage account.

Navigate to:

```text
Data Storage → Queues
```

Select:

```text
+ Queue
```

Enter a queue name such as:

```text
demoqueue1
```

Select **OK** to create the queue.

After creation, open the queue from the list.

---

### Step 4 — Add the First Message to the Queue

Inside the queue overview page, select:

```text
Add message
```

Configure the message with the following values:

| Setting | Value |
|---|---|
| Message Text | Test Message |
| Expires In | 7 days |
| Message Never Expires | Checked |
| Encode Message Body in Base64 | Checked |

Save the message.

This creates the first queue message.

---

### Step 5 — Add the Second Message to the Queue

Repeat the **Add message** process and create a second message.

Use:

| Setting | Value |
|---|---|
| Message Text | My Second Message |
| Expires In | 7 days |
| Message Never Expires | Checked |
| Encode Message Body in Base64 | Checked |

Save the message.

The queue now contains two messages.

—
<img width="1523" height="763" alt="image" src="https://github.com/user-attachments/assets/4ac8afbd-ee4e-42d2-a7ae-ac943ceee2b9" />


### Step 6 — Dequeue the First Message

Inside the queue, select:

```text
Dequeue message
```

Confirm the action by selecting:

```text
Yes
```

Expected result:

- Azure removes the first inserted message from the queue
- The remaining message stays in the queue

This demonstrates queue processing behavior where the earliest message is removed first during dequeue.

<img width="1523" height="608" alt="image" src="https://github.com/user-attachments/assets/67ac7322-521d-4a7f-8fca-ce8ff17f667b" />

### Azure CLI (Bash)

Create the storage account:

```bash
az storage account create \
  --name mystoragequeue123 \
  --resource-group rg_eastus_XXXXX \
  --location eastus \
  --sku Standard_LRS \
  --kind StorageV2
```

Create the queue:

```bash
az storage queue create \
  --account-name mystoragequeue123 \
  --name demoqueue1
```

Add the first message:

```bash
az storage message put \
  --account-name mystoragequeue123 \
  --queue-name demoqueue1 \
  --content "Test Message"
```

Add the second message:

```bash
az storage message put \
  --account-name mystoragequeue123 \
  --queue-name demoqueue1 \
  --content "My Second Message"
```

Peek at queue messages:

```bash
az storage message peek \
  --account-name mystoragequeue123 \
  --queue-name demoqueue1
```

Retrieve and delete the first message:

```bash
az storage message get \
  --account-name mystoragequeue123 \
  --queue-name demoqueue1
```

### Azure PowerShell

Create the storage account:

```powershell
New-AzStorageAccount `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "mystoragequeue123" `
  -Location "East US" `
  -SkuName "Standard_LRS" `
  -Kind "StorageV2"
```

Get the storage context:

```powershell
$ctx = (Get-AzStorageAccount `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "mystoragequeue123").Context
```

Create the queue:

```powershell
New-AzStorageQueue `
  -Name "demoqueue1" `
  -Context $ctx
```

Add the first message:

```powershell
$queue = Get-AzStorageQueue `
  -Name "demoqueue1" `
  -Context $ctx

$queue.QueueClient.SendMessage("Test Message")
```

Add the second message:

```powershell
$queue.QueueClient.SendMessage("My Second Message")
```

Peek at messages:

```powershell
$queue.QueueClient.PeekMessages()
```

Receive and remove a message:

```powershell
$message = $queue.QueueClient.ReceiveMessage()
$queue.QueueClient.DeleteMessage($message.Value.MessageId, $message.Value.PopReceipt)
```

## Implementation Walkthrough

The lab began by creating a storage account configured for **tables and queues** in the East US region using Standard performance and LRS redundancy. This provided the storage platform required to host the Azure Queue service.

After the storage account was available, a queue was created from the **Queues** section in the portal. Once the queue existed, two separate messages were added. Each message was configured with message content, expiration settings, and Base64 encoding enabled. This demonstrated how Azure Queue messages can be customized with delivery and storage options.

Finally, a dequeue operation was performed from the portal. Azure removed the first inserted message from the queue, leaving the later message behind. This validated basic queue consumption behavior and showed how Azure Queue Storage can support message-based workflows.

## Results & Validation

| Test | Result |
|---|---|
| Storage account creation | Successful |
| Queue creation | Successful |
| First message insertion | Successful |
| Second message insertion | Successful |
| Base64 message encoding | Successful |
| Dequeue operation | Successful |
| First message removal | Successful |

Key observations:

- Azure Queue Storage supports lightweight asynchronous messaging
- Multiple messages can be inserted into the same queue
- Message options include expiration and Base64 encoding
- Dequeue removed the earliest inserted message from the queue
- Queue operations were easy to manage through the Azure Portal

## Validation Walkthrough

1. Verified that the storage account was created successfully in the assigned resource group.
2. Confirmed that the storage account used **Other (tables and queues)** as the primary service configuration.
3. Opened the **Queues** section of the storage account.
4. Created a queue successfully.
5. Added the first message with the text `Test Message`.
6. Confirmed that the message settings included Base64 encoding and the selected expiration behavior.
7. Added the second message with the text `My Second Message`.
8. Confirmed that both messages appeared in the queue.
9. Selected **Dequeue message** and confirmed the action.
10. Verified that the first inserted message was removed from the queue after the dequeue operation.

## Real-World Use Case

Azure Queue Storage is commonly used when applications need asynchronous task handling or workload decoupling.

Example: **Background Processing Workflow**

| Component | Role |
|---|---|
| Web Application | Submits work request |
| Azure Queue | Holds pending task messages |
| Worker Process | Reads and processes messages |
| Storage Account | Hosts the queue service |

Typical workflow:

```text
Application Sends Message to Queue
            ↓
Message Waits in Azure Queue
            ↓
Worker Retrieves First Available Message
            ↓
Task Is Processed
            ↓
Message Is Removed from Queue
```

This design is useful for job processing, email sending, order handling, background automation, and any system where immediate synchronous execution is not required.

## Key Takeaways

This lab demonstrated several important Azure storage messaging concepts:

- Azure Queue Storage provides simple message-based communication inside Azure Storage
- Storage accounts can be configured to support queue services
- Messages can include expiration settings and Base64 encoding
- Dequeue operations remove messages from the queue after retrieval
- Queue-based workflows help decouple applications and support asynchronous processing

Understanding Azure Queue Storage is valuable for cloud administrators, developers, and operations teams working with distributed applications and background task processing.

