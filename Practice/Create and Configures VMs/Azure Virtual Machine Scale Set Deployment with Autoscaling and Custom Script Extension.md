# Azure Virtual Machine Scale Set Deployment with Autoscaling and Custom Script Extension

## Introduction

Azure Virtual Machine Scale Sets (VMSS) provide a way to deploy and manage a group of identical virtual machines as a single resource. They are designed for scalable, highly available workloads where compute capacity may need to grow or shrink based on demand.

In this lab, an Azure virtual network was created first, followed by a virtual machine scale set running Ubuntu Linux. The scale set was configured with manual instance capacity, custom autoscale settings, and SSH access. CPU load was then generated with the `stress` tool to observe scaling behavior. After that, a **Custom Script Extension for Linux** was applied to install **NGINX** on the VMSS instances using a script stored in an Azure Storage Account. Finally, the scale set instances were upgraded and tested through port 80 to confirm the NGINX web server was running.

## Objectives

The objectives of this lab were to:

- Create an Azure virtual network
- Deploy a virtual machine scale set using Ubuntu Linux
- Configure VMSS networking and SSH access
- Enable custom autoscale settings
- Generate CPU load to observe scaling behavior
- Create a storage account and blob container for script hosting
- Apply a Custom Script Extension for Linux
- Install NGINX on scale set instances
- Open port 80 for HTTP access
- Upgrade VMSS instances and validate the NGINX web server

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
                    | Virtual     |
                    | Network     |
                    | DemoVNet1   |
                    +------+------+
                           |
                    +------+------+
                    | VM Scale Set |
                    | DemoScaleset1|
                    | Ubuntu Linux |
                    +------+------+
                           |
         +-----------------+------------------+
         |                 |                  |
+--------+--------+ +------+--------+ +------+--------+
| Instance 1      | | Instance 2    | | Instance 3    |
| SSH / NGINX     | | SSH / NGINX   | | SSH / NGINX   |
+--------+--------+ +------+--------+ +------+--------+
                           |
                    +------+------+
                    | Autoscale    |
                    | CPU-based    |
                    +------+------+
                           |
                    +------+------+
                    | Storage      |
                    | Account      |
                    | democontainer|
                    +------+------+
                           |
                    +------+------+
                    | commands.sh  |
                    | Custom Script|
                    +------+------+
                           |
                    +------+------+
                    | Port 80      |
                    | HTTP Access  |
                    +-------------+
```

This architecture shows a virtual machine scale set deployed into a virtual network, using autoscale settings and a custom script extension hosted in Azure Storage to install NGINX across multiple VM instances.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser session is recommended to avoid Azure portal cache issues.

---

### Step 2 — Create the Virtual Network

Navigate to:

```text
Virtual Networks → Create
```

Configure the virtual network with the following settings:

| Setting | Value |
|---|---|
| Resource Group | rg_eastus_XXXXX |
| Name | DemoVNet1 |
| Region | East US |

Leave the **IP Addresses** tab at the default values.

Review and create the virtual network.

—
<img width="1450" height="1817" alt="image" src="https://github.com/user-attachments/assets/536787d8-afeb-4407-9985-d7400e838bee" />


### Step 3 — Create the Virtual Machine Scale Set

Navigate to:

```text
Virtual machine scale sets → Create
```

Configure the scale set with the following values:

| Setting | Value |
|---|---|
| Resource Group | rg_eastus_XXXXX |
| Virtual Machine Scale Set Name | DemoScaleset1 |
| Region | East US |
| Availability Zone | None |
| Orchestration Mode | Uniform |
| Security Type | Standard |
| Scaling Mode | Manually update the capacity |
| Instance Count | 3 |
| Image | Ubuntu Server 24.04 LTS - Gen2 |
| Size | Standard_B2s |
| Authentication Type | Password |
| Username | Lab-defined username |
| Password | Lab-defined password |

On the **Disks** tab, configure:

| Setting | Value |
|---|---|
| OS Disk Type | Standard HDD |

On the **Networking** tab, configure:

| Setting | Value |
|---|---|
| Virtual Network | DemoVNet1 |
| Public Inbound Ports | Allowed selected ports |
| Inbound Ports | SSH (22) |
| Public IP Address | Enabled |
| Load Balancing Options | None |

On the **Management** tab, verify:

| Setting | Value |
|---|---|
| Upgrade Mode | Manual - Existing instances must be manually upgraded |

Review and create the scale set.

—
<img width="1523" height="1686" alt="image" src="https://github.com/user-attachments/assets/295f3049-e639-42cb-bf11-759b4476e089" />


### Step 4 — Configure Custom Autoscale

After deployment, open the scale set resource.

Navigate to:

```text
Scaling
```

Select:

```text
Custom Autoscale
```

Configure autoscale using:

```text
Scale based on a metric
```

Set the **Minimum**, **Maximum**, and **Default** instance counts according to the lab configuration.

Save the autoscale settings.

This allows the scale set to respond dynamically to CPU-based demand while still using controlled scaling boundaries.

—
<img width="1523" height="1013" alt="image" src="https://github.com/user-attachments/assets/c83c1613-79c3-4b1d-9d9d-e588bbef791d" />


### Step 5 — Connect to a VMSS Instance and Generate CPU Stress

Open the VM scale set and navigate to:

```text
Settings → Instances
```

Select one of the instances and copy its **Public IP address**.

Use **PuTTY** on the local computer to connect to the instance over SSH.

After logging in with the configured credentials, run:

```bash
sudo apt-get update
```

Install the stress tool:

```bash
sudo apt-get install -y stress
```

Generate artificial CPU load:

```bash
sudo stress --cpu 100
```

Return to the scale set overview page and observe the **Average CPU utilization** metric.

Expected behavior:

- CPU usage increases significantly
- Instance count increases based on the autoscale rules

This validates that autoscale responds to performance pressure.

—
<img width="1523" height="142" alt="image" src="https://github.com/user-attachments/assets/765d5c22-34fb-4f50-8778-a200171711e7" />
<img width="1523" height="886" alt="image" src="https://github.com/user-attachments/assets/7230052c-8085-4fa1-959b-61740c936e81" />
<img width="1523" height="1047" alt="image" src="https://github.com/user-attachments/assets/d59bb1e9-96de-4363-be06-164c2d040b10" />
<img width="1523" height="631" alt="image" src="https://github.com/user-attachments/assets/7bb06650-7361-4a1d-9f84-9928a42c0401" />
<img width="1523" height="627" alt="image" src="https://github.com/user-attachments/assets/1a43dad5-43bb-412d-a810-ef93d212b959" />
<img width="1523" height="627" alt="image" src="https://github.com/user-attachments/assets/7636ef09-2306-4483-b178-3a5ebb39ed2c" />






### Step 6 — Add a Custom Script Extension

Open the virtual machine scale set and navigate to:

```text
Settings → Extensions + applications
```

Select:

```text
+ Add
```

Choose:

```text
Custom Script for Linux
```

Then select:

```text
Browse
```

Create a new storage account for hosting the script:

| Setting | Value |
|---|---|
| Name | Unique storage account name |

After the storage account is created:

1. Open it
2. Create a container named:

```text
democontainer
```

Create a local script file named:

```text
commands.sh
```

Use this content:

```bash
apt-get update -y && apt-get upgrade -y && apt-get install -y nginx
```

Upload `commands.sh` into the `democontainer` container.

Back in the extension configuration, select the uploaded file and enter the command:

```bash
sh commands.sh
```

Create the extension.

This installs NGINX across the VMSS instances using the custom script.

—
<img width="1523" height="573" alt="image" src="https://github.com/user-attachments/assets/72ce024d-137b-4940-a5a8-e61e1423c9ef" />


### Step 7 — Open Port 80 for HTTP Access

From the virtual machine scale set, navigate to:

```text
Networking → Networking settings
```

Add an inbound port rule with:

| Setting | Value |
|---|---|
| Destination Port Ranges | 80 |
| Name | Port80 |

Add the rule.

This allows HTTP traffic to reach the NGINX web server.

---

### Step 8 — Upgrade the VMSS Instances

Navigate to:

```text
Settings → Instances
```

Select all instances and choose:

```text
Upgrade
```

Confirm the upgrade.

Because the scale set uses **manual upgrade mode**, this step is required for the instances to receive the custom script extension changes.

---

### Step 9 — Test the NGINX Web Server

Select any VMSS instance and copy its **Public IP address**.

Paste the IP address into a web browser.

Expected result:

- The default NGINX page loads successfully

This confirms that the Custom Script Extension installed NGINX correctly and that HTTP access is functioning.
<img width="1523" height="542" alt="image" src="https://github.com/user-attachments/assets/2d68d408-a633-4c9c-a348-33979e975372" />



## Azure CLI (Bash)

Create the virtual network:

```bash
az network vnet create \
  --resource-group rg_eastus_XXXXX \
  --name DemoVNet1 \
  --location eastus
```

Create the virtual machine scale set:

```bash
az vmss create \
  --resource-group rg_eastus_XXXXX \
  --name DemoScaleset1 \
  --image Ubuntu2404 \
  --vm-sku Standard_B2s \
  --instance-count 3 \
  --authentication-type password \
  --admin-username azureuser \
  --admin-password 'StrongPassword123!' \
  --vnet-name DemoVNet1 \
  --public-ip-per-vm \
  --upgrade-policy-mode Manual
```

List VMSS instances:

```bash
az vmss list-instances \
  --resource-group rg_eastus_XXXXX \
  --

