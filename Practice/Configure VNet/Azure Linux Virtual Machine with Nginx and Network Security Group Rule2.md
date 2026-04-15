# Azure Linux Virtual Machine with Nginx and Network Security Group Rule

## Introduction

Azure Virtual Machines provide scalable, on-demand compute resources that allow administrators to deploy and manage operating systems and workloads without maintaining physical hardware. They are useful when you need flexibility, operating system control, and rapid provisioning in the cloud.

In this lab, a Linux virtual machine was created from Azure Cloud Shell using Azure CLI. Nginx was installed through a VM extension, and the web server was tested before and after modifying the associated Network Security Group (NSG). The lab demonstrated that the VM was initially unreachable over HTTP because port 80 was not allowed, and then became accessible after an inbound NSG rule was added.

## Objectives

The objectives of this lab were to:

- Create a Linux virtual machine in Azure
- Install and configure Nginx on the virtual machine
- Retrieve the public IP address of the VM
- Test web server access before NSG modification
- Review the current NSG rules
- Create an inbound NSG rule to allow HTTP on port 80
- Validate successful access to the web server after the rule change

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
                    | Linux VM    |
                    | my-vm       |
                    | Ubuntu 22.04|
                    +------+------+
                           |
                    +------+------+
                    | Nginx Web   |
                    | Server      |
                    +------+------+
                           |
                    +------+------+
                    | NSG         |
                    | my-vmNSG    |
                    +------+------+
                           |
         +-----------------+-----------------+
         |                                   |
+--------+--------+                 +--------+--------+
| Allow SSH       |                 | Allow HTTP      |
| Port 22         |                 | Port 80         |
| Priority 1000   |                 | Priority 100    |
+-----------------+                 +-----------------+
                           |
                      Public IP
                           |
                    Browser / curl
```

This architecture shows a Linux VM running Nginx behind a Network Security Group, where HTTP access is enabled only after an inbound NSG rule is created.

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

On the startup screen, select:

```text
No storage account required
```

Choose the assigned subscription and open the Bash session.

---

### Step 3 — Create the Linux Virtual Machine

Run the following command in Cloud Shell:

```bash
az vm create \
  --resource-group <your-resource-group-name> \
  --name my-vm \
  --public-ip-sku Standard \
  --image Ubuntu2204 \
  --admin-username azureuser \
  --generate-ssh-keys \
  --size Standard_B2s
```

This command creates:

- A Linux VM named `my-vm`
- A standard public IP
- A default NSG associated with the VM
- SSH key-based administrator access

—
<img width="1523" height="216" alt="image" src="https://github.com/user-attachments/assets/399fec8e-9bee-4e71-99c2-3c7bccc91067" />



### Step 4 — Install Nginx Using a VM Extension

Run the following command to install and configure Nginx:

```bash
az vm extension set \
  --resource-group <your-resource-group-name> \
  --vm-name my-vm \
  --name customScript \
  --publisher Microsoft.Azure.Extensions \
  --version 2.1 \
  --settings '{"fileUris":["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-nginx.sh"]}' \
  --protected-settings '{"commandToExecute": "./configure-nginx.sh"}'
```

The script performs the following actions:

- Runs `apt-get update`
- Installs Nginx
- Updates the default home page
- Writes a welcome message including the VM hostname

---

### Step 5 — Retrieve the Public IP Address

Store the VM public IP in a Bash variable:

```bash
IPADDRESS="$(az vm list-ip-addresses \
  --resource-group <your-resource-group-name> \
  --name my-vm \
  --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
  --output tsv)"
```

Display the IP address:

```bash
echo $IPADDRESS
```

---

### Step 6 — Test Web Server Access Before NSG Modification

Attempt to access the web server from Cloud Shell:

```bash
curl --connect-timeout 5 http://$IPADDRESS
```

Expected result:

```text
curl: (28) Connection timed out after 5001 milliseconds
```

This indicates the VM is running, but inbound HTTP access is blocked.

You can also paste the public IP into a browser and observe that the page does not load.

---

### Step 7 — Review Current NSG Rules

List the NSG associated with the virtual machine:

```bash
az network nsg list \
  --resource-group <your-resource-group-name> \
  --query '[].name' \
  --output tsv
```

List the current NSG rules:

```bash
az network nsg rule list \
  --resource-group <your-resource-group-name> \
  --nsg-name my-vmNSG \
  --query '[].{Name:name, Priority:priority, Port:destinationPortRange, Access:access}' \
  --output table
```

Expected observation:

- SSH port 22 is allowed
- HTTP port 80 is not yet allowed

---

### Step 8 — Create the HTTP NSG Rule

Run the following command:

```bash
az network nsg rule create \
  --resource-group <your-resource-group-name> \
  --nsg-name my-vmNSG \
  --name allow-http \
  --protocol tcp \
  --priority 100 \
  --destination-port-range 80 \
  --access Allow
```

This creates an inbound rule that allows HTTP traffic on port 80.

---

### Step 9 — Verify the Updated NSG Rules

List the NSG rules again:

```bash
az network nsg rule list \
  --resource-group <your-resource-group-name> \
  --nsg-name my-vmNSG \
  --query '[].{Name:name, Priority:priority, Port:destinationPortRange, Access:access}' \
  --output table
```

Expected result:

- `allow-http` appears
- `default-allow-ssh` remains present

---

### Step 10 — Access the Web Server Again

Retry the same curl command:

```bash
curl --connect-timeout 5 http://$IPADDRESS
```

Expected result:

- The Nginx welcome page content is returned successfully

Also refresh the browser tab using the VM public IP.

The Nginx page should now load successfully.
<img width="1523" height="895" alt="image" src="https://github.com/user-attachments/assets/7a5e6d1a-8a19-4b62-8a1c-e8130ebe7de3" />


### Azure CLI (Bash)

Create the VM:

```bash
az vm create \
  --resource-group <your-resource-group-name> \
  --name my-vm \
  --public-ip-sku Standard \
  --image Ubuntu2204 \
  --admin-username azureuser \
  --generate-ssh-keys \
  --size Standard_B2s
```

Install Nginx:

```bash
az vm extension set \
  --resource-group <your-resource-group-name> \
  --vm-name my-vm \
  --name customScript \
  --publisher Microsoft.Azure.Extensions \
  --version 2.1 \
  --settings '{"fileUris":["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-nginx.sh"]}' \
  --protected-settings '{"commandToExecute": "./configure-nginx.sh"}'
```

Show the public IP:

```bash
az vm list-ip-addresses \
  --resource-group <your-resource-group-name> \
  --name my-vm \
  --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
  --output tsv
```

List NSG rules:

```bash
az network nsg rule list \
  --resource-group <your-resource-group-name> \
  --nsg-name my-vmNSG \
  --query '[].{Name:name, Priority:priority, Port:destinationPortRange, Access:access}' \
  --output table
```

Create the HTTP rule:

```bash
az network nsg rule create \
  --resource-group <your-resource-group-name> \
  --nsg-name my-vmNSG \
  --name allow-http \
  --protocol tcp \
  --priority 100 \
  --destination-port-range 80 \
  --access Allow
```

### Azure PowerShell

Create the VM:

```powershell
New-AzVM `
  -ResourceGroupName "<your-resource-group-name>" `
  -Name "my-vm" `
  -Image "Ubuntu2204" `
  -Size "Standard_B2s" `
  -Credential (Get-Credential)
```

Get the VM public IP:

```powershell
(Get-AzPublicIpAddress -ResourceGroupName "<your-resource-group-name>").IpAddress
```

View NSG rules:

```powershell
Get-AzNetworkSecurityGroup `
  -ResourceGroupName "<your-resource-group-name>" `
  -Name "my-vmNSG" | Select-Object -ExpandProperty SecurityRules
```

Create an inbound HTTP rule:

```powershell
$nsg = Get-AzNetworkSecurityGroup `
  -ResourceGroupName "<your-resource-group-name>" `
  -Name "my-vmNSG"

Add-AzNetworkSecurityRuleConfig `
  -Name "allow-http" `
  -NetworkSecurityGroup $nsg `
  -Description "Allow HTTP" `
  -Access Allow `
  -Protocol Tcp `
  -Direction Inbound `
  -Priority 100 `
  -SourceAddressPrefix * `
  -SourcePortRange * `
  -DestinationAddressPrefix * `
  -DestinationPortRange 80

$nsg | Set-AzNetworkSecurityGroup
```

## Implementation Walkthrough

The lab started by using Azure Cloud Shell in Bash mode to create a Linux virtual machine named `my-vm`. This method demonstrated that Azure infrastructure can be deployed quickly from the command line without manually stepping through every portal form. The VM was provisioned with Ubuntu 22.04, a standard public IP, and an automatically associated Network Security Group.

Next, the VM extension mechanism was used to install Nginx and configure the default home page. This demonstrated how Azure extensions can automate post-deployment configuration tasks on a virtual machine. At this point, the web server software was installed and running, but the application was still not reachable from the internet.

To understand why the web page was inaccessible, the NSG rules were listed. The existing rules allowed SSH over port 22, but there was no rule allowing HTTP on port 80. A new rule named `allow-http` was then created with a higher priority, which allowed inbound TCP traffic on port 80. After the NSG update propagated, the Nginx page became accessible through both `curl` and a web browser.

## Results & Validation

| Test | Result |
|---|---|
| Linux VM deployment | Successful |
| Nginx installation | Successful |
| Public IP retrieval | Successful |
| Initial HTTP test before NSG rule | Failed as expected |
| NSG rule review | Successful |
| HTTP allow rule creation | Successful |
| Final HTTP access after NSG rule | Successful |

Key observations:

- Installing Nginx alone does not make a web server reachable from the internet
- NSG rules control inbound access to Azure resources
- Port 22 was allowed by default for administration
- Port 80 had to be explicitly allowed for HTTP access
- After the rule change, the web server became reachable immediately after propagation

## Validation Walkthrough

1. Verified that the Linux VM `my-vm` was created successfully.
2. Ran the VM extension command and confirmed Nginx was installed.
3. Retrieved the VM public IP and stored it in the `IPADDRESS` variable.
4. Ran `curl --connect-timeout 5 http://$IPADDRESS` and confirmed the connection timed out.
5. Listed the NSG name associated with the VM and confirmed it was `my-vmNSG`.
6. Reviewed the existing NSG rules and confirmed only SSH was explicitly allowed.
7. Created the `allow-http` inbound rule for TCP port 80.
8. Listed the NSG rules again and confirmed the new rule appeared.
9. Retried the `curl` command and confirmed the Nginx page responded successfully.
10. Refreshed the browser tab and confirmed the web page loaded.

## Real-World Use Case

This deployment pattern is common when administrators need to publish a simple Linux-based web server securely in Azure.

Example: **Public Test Web Server**

| Component | Role |
|---|---|
| Linux VM | Hosts the application |
| Nginx | Web server software |
| NSG | Controls allowed inbound traffic |
| Public IP | Internet-facing endpoint |
| Browser / curl | Validation client |

Typical workflow:

```text
Deploy Linux VM
      ↓
Install Web Server
      ↓
Test Access Fails
      ↓
Review NSG Rules
      ↓
Allow Port 80
      ↓
Application Becomes Reachable
```

This pattern helps reinforce the operational idea that network security controls and workload configuration must both be correct before an application becomes accessible.

## Key Takeaways

This lab demonstrated several important Azure infrastructure concepts:

- Azure Virtual Machines can be deployed quickly through Azure CLI
- VM extensions can automate software installation and configuration
- Network Security Groups control inbound and outbound traffic for Azure resources
- A running service may still be unreachable if the required port is blocked
- Allowing HTTP on port 80 enabled successful access to the Nginx web server

Understanding how Azure VMs, Nginx, and NSG rules work together is important for cloud administrators, infrastructure engineers, and anyone deploying internet-accessible workloads in Azure.

