# Azure Network Virtual Appliance Deployment with IP Forwarding

## Introduction

A Network Virtual Appliance (NVA) in Azure is a virtual machine that performs network functions such as routing, packet forwarding, traffic inspection, firewalling, or proxying. NVAs are commonly used when organizations need custom traffic control inside a virtual network beyond what default Azure routing provides.

In this lab, an Ubuntu virtual machine was deployed as an NVA into a dedicated subnet. After deployment, **IP forwarding** was enabled at two layers:

- On the **Azure network interface**
- Inside the **Ubuntu operating system**

This configuration allows the appliance to forward packets between network segments, which is a foundational requirement for custom routing and traffic inspection designs in Azure.

## Objectives

The objectives of this lab were to:

- Open Azure Cloud Shell in Bash mode
- Deploy an Ubuntu virtual machine as a network virtual appliance
- Retrieve the VM network interface details
- Enable IP forwarding on the Azure NIC
- Retrieve the NVA public IP address
- Enable IP forwarding inside the Ubuntu operating system
- Understand why both Azure-side and guest OS-side forwarding are required

## Architecture Diagram

```text
                +----------------------+
                |   Azure Subscription |
                |      Payg-Lab2       |
                +----------+-----------+
                           |
                +----------+-----------+
                |       Resource Group |
                |   resource-group     |
                +----------+-----------+
                           |
                    +------+------+
                    | Virtual     |
                    | Network     |
                    | vnet        |
                    +------+------+
                           |
                    +------+------+
                    | dmzsubnet   |
                    +------+------+
                           |
                    +------+------+
                    | NVA VM      |
                    | Ubuntu 22.04|
                    | Name: nva   |
                    +------+------+
                           |
         +-----------------+-----------------+
         |                                   |
+--------+--------+                 +--------+--------+
| Azure NIC       |                 | Ubuntu OS       |
| IP Forwarding   |                 | net.ipv4.       |
| Enabled         |                 | ip_forward=1    |
+-----------------+                 +-----------------+
                           |
                    +------+------+
                    | Public IP    |
                    | SSH Access   |
                    +-------------+
```

This architecture shows an Ubuntu-based Azure Network Virtual Appliance deployed in the DMZ subnet, with packet forwarding enabled both on the Azure NIC and inside the guest operating system.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser session is recommended to avoid Azure portal cache issues.

---

### Step 2 — Open Azure Cloud Shell

In the Azure portal, select:

```text
Cloud Shell
```

Choose:

```text
Bash
```

In the startup pane, configure:

| Setting | Value |
|---|---|
| Cloud Shell Option | No storage account required |
| Subscription | Payg-Lab2 |

Select:

```text
Create
```

This opens a Bash-based Cloud Shell session for Azure CLI commands.

---

### Step 3 — Deploy the Network Virtual Appliance

Run the following Azure CLI command in Cloud Shell:

```bash
az vm create \
  --resource-group "<resource-group-name>" \
  --name nva \
  --vnet-name vnet \
  --subnet dmzsubnet \
  --image Ubuntu2204 \
  --size Standard_B2s \
  --admin-username azureuser \
  --admin-password <password>
```

Replace:

- `<resource-group-name>` with the assigned lab resource group
- `<password>` with a strong password for the `azureuser` account

This command deploys:

- An Ubuntu 22.04 virtual machine
- A NIC connected to `dmzsubnet`
- Supporting compute and networking resources needed for the NVA

—
<img width="1523" height="291" alt="image" src="https://github.com/user-attachments/assets/17a2e6ac-4cc1-46fc-82b7-15385681070c" />


### Step 4 — Retrieve the Network Interface ID

Run the following command to get the NIC ID for the `nva` virtual machine:

```bash
NICID=$(az vm nic list \
  --resource-group "<resource-group-name>" \
  --vm-name nva \
  --query "[].{id:id}" \
  --output tsv)

echo $NICID
```

This stores the full Azure resource ID of the NVA network interface in the `NICID` variable.

---

### Step 5 — Retrieve the Network Interface Name

Run the following command to get the NIC name:

```bash
NICNAME=$(az vm nic show \
  --resource-group "<resource-group-name>" \
  --vm-name nva \
  --nic $NICID \
  --query "{name:name}" \
  --output tsv)

echo $NICNAME
```

This stores the NIC resource name in the `NICNAME` variable so it can be updated directly.

---

### Step 6 — Enable IP Forwarding on the Azure NIC

Run the following command:

```bash
az network nic update \
  --name $NICNAME \
  --resource-group "<resource-group-name>" \
  --ip-forwarding true
```

This enables **Azure-side NIC IP forwarding**.

Without this setting, Azure will not allow the virtual machine NIC to forward packets that are not addressed directly to the appliance.

—
<img width="1523" height="456" alt="image" src="https://github.com/user-attachments/assets/27aebfbd-a2d4-49d9-a086-7bf7d1518185" />


### Step 7 — Retrieve the NVA Public IP Address

Run the following command to capture the public IP of the NVA:

```bash
NVAIP="$(az vm list-ip-addresses \
  --resource-group "<resource-group-name>" \
  --name nva \
  --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
  --output tsv)"
```

This stores the VM public IP in the `NVAIP` variable for SSH access.

---

### Step 8 — Enable IP Forwarding Inside Ubuntu

Run the following SSH command:

```bash
ssh -t -o StrictHostKeyChecking=no azureuser@$NVAIP 'sudo sysctl -w net.ipv4.ip_forward=1; exit;'
```

When prompted, enter the password you configured during VM creation.

This enables **guest OS-side packet forwarding** by setting:

```text
net.ipv4.ip_forward=1
```

Expected result:

- The SSH session connects successfully
- The `sysctl` command updates the kernel networking setting
- IP forwarding becomes enabled inside Ubuntu
<img width="1523" height="194" alt="image" src="https://github.com/user-attachments/assets/67fa764e-ec8e-413f-8534-bb38b8faa524" />

## Azure CLI (Bash)

Create the NVA virtual machine:

```bash
az vm create \
  --resource-group "<resource-group-name>" \
  --name nva \
  --vnet-name vnet \
  --subnet dmzsubnet \
  --image Ubuntu2204 \
  --size Standard_B2s \
  --admin-username azureuser \
  --admin-password "<password>"
```

Get the NIC ID:

```bash
az vm nic list \
  --resource-group "<resource-group-name>" \
  --vm-name nva \
  --query "[].{id:id}" \
  --output tsv
```

Get the NIC name:

```bash
az vm nic show \
  --resource-group "<resource-group-name>" \
  --vm-name nva \
  --nic "<nic-id>" \
  --query "{name:name}" \
  --output tsv
```

Enable Azure NIC IP forwarding:

```bash
az network nic update \
  --name "<nic-name>" \
  --resource-group "<resource-group-name>" \
  --ip-forwarding true
```

Get the NVA public IP:

```bash
az vm list-ip-addresses \
  --resource-group "<resource-group-name>" \
  --name nva \
  --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
  --output tsv
```

Enable guest OS IP forwarding:

```bash
ssh -t -o StrictHostKeyChecking=no azureuser@<public-ip> 'sudo sysctl -w net.ipv4.ip_forward=1; exit;'
```

## Azure PowerShell

Create the NVA virtual machine:

```powershell
New-AzVM `
  -ResourceGroupName "<resource-group-name>" `
  -Name "nva" `
  -Location "East US" `
  -Image "Ubuntu2204" `
  -Size "Standard_B2s" `
  -Credential (Get-Credential)
```

Get the NIC:

```powershell
$nic = Get-AzNetworkInterface `
  -ResourceGroupName "<resource-group-name>" | Where-Object { $_.VirtualMachine -and $_.VirtualMachine.Id -match "/virtualMachines/nva$" }

$nic.Name
$nic.Id
```

Enable Azure NIC IP forwarding:

```powershell
$nic.EnableIPForwarding = $true
$nic | Set-AzNetworkInterface
```

Get the VM public IP:

```powershell
(Get-AzPublicIpAddress -ResourceGroupName "<resource-group-name>").IpAddress
```

Guest OS forwarding can then be enabled over SSH with:

```powershell
ssh azureuser@<public-ip>
sudo sysctl -w net.ipv4.ip_forward=1
exit
```

## Implementation Walkthrough

The lab began by opening Azure Cloud Shell in **Bash** mode and deploying an Ubuntu 22.04 virtual machine named `nva` into the `dmzsubnet` subnet of the existing virtual network. This machine served as the network virtual appliance. Because an NVA is intended to forward traffic rather than only receive traffic for itself, additional packet forwarding configuration was required after deployment.

The first forwarding change was performed at the **Azure NIC layer**. The network interface attached to the VM was identified by first retrieving its resource ID and then resolving its name. Azure CLI was then used to enable NIC-level IP forwarding. This step is essential because Azure otherwise blocks a VM NIC from forwarding packets on behalf of other hosts.

The second forwarding change was performed inside the **Ubuntu guest operating system**. After retrieving the public IP address of the NVA, an SSH session was opened and the Linux kernel setting `net.ipv4.ip_forward=1` was enabled using `sysctl`. This step allowed the guest OS itself to forward packets between interfaces and routes.

Together, these two settings completed the NVA forwarding configuration. This demonstrated an important Azure networking principle: for a network virtual appliance to work correctly, forwarding must be enabled both in Azure networking and inside the operating system.

## Results & Validation

| Test | Result |
|---|---|
| Cloud Shell Bash setup | Successful |
| Ubuntu NVA VM deployment | Successful |
| NIC ID retrieval | Successful |
| NIC name retrieval | Successful |
| Azure NIC IP forwarding enabled | Successful |
| NVA public IP retrieval | Successful |
| SSH connection to NVA | Successful |
| Ubuntu IP forwarding enabled | Successful |

Key observations:

- A virtual machine alone is not automatically ready to act as an NVA
- Azure NIC IP forwarding must be enabled explicitly
- Linux kernel IP forwarding must also be enabled explicitly
- Both Azure-side and guest OS-side forwarding are required for packet transit
- Cloud Shell and Azure CLI provide a fast deployment and configuration workflow

## Validation Walkthrough

1. Verified that Azure Cloud Shell opened successfully in Bash mode.
2. Ran the `az vm create` command and confirmed the Ubuntu VM `nva` was created in `dmzsubnet`.
3. Retrieved the NIC resource ID using `az vm nic list`.
4. Retrieved the NIC name using `az vm nic show`.
5. Ran `az network nic update --ip-forwarding true` and confirmed the NIC update completed successfully.
6. Retrieved the NVA public IP address and stored it in `NVAIP`.
7. Connected successfully to the virtual machine over SSH using the `azureuser` account.
8. Ran `sudo sysctl -w net.ipv4.ip_forward=1`.
9. Confirmed that the IP forwarding setting was applied successfully inside Ubuntu.

## Real-World Use Case

Azure NVAs are commonly used when organizations need custom routing, inspection, or traffic mediation inside a virtual network.

Example: **Custom Routed Traffic Through a DMZ Appliance**

| Component | Role |
|---|---|
| Azure Virtual Network | Hosts segmented workloads |
| DMZ Subnet | Dedicated location for the NVA |
| Ubuntu NVA VM | Performs routing or packet forwarding |
| Azure NIC IP Forwarding | Allows packet transit at Azure network layer |
| Linux IP Forwarding | Allows packet transit inside the guest OS |

Typical workflow:

```text
Workload Sends Packet
        ↓
User-Defined Route Sends Traffic to NVA
        ↓
Azure NIC Allows Forwarding
        ↓
Ubuntu Kernel Forwards Packet
        ↓
Traffic Continues to Next Hop
```

This pattern is useful for firewall appliances, custom routers, packet inspection VMs, proxy servers, and segmented network architectures that require controlled traffic flow.

## Key Takeaways

This lab demonstrated several important Azure networking concepts:

- An Azure virtual machine can be used as a Network Virtual Appliance
- Azure NIC IP forwarding must be enabled for transit traffic
- Linux guest OS IP forwarding must also be enabled
- Both control-plane and guest OS configuration are required for NVA behavior
- Azure CLI and Cloud Shell provide an efficient way to deploy and configure network appliances

Understanding Azure NVA deployment and IP forwarding is valuable for cloud administrators, network engineers, and infrastructure teams responsible for custom routing and traffic control in Azure.

