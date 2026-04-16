# Azure Linux Virtual Machine with PuTTY SSH Access and OpenSSH Server Configuration

## Introduction

Azure Virtual Machines provide Infrastructure as a Service (IaaS) compute resources that allow administrators to deploy and manage operating systems in the cloud without maintaining physical hardware. Azure supports both Windows and Linux virtual machines, making it suitable for development, testing, administration, web hosting, and lift-and-shift migration scenarios.

In this lab, a Linux virtual machine was deployed in Azure, connected remotely using **PuTTY**, and then configured with the **OpenSSH server**. The system packages were updated, the SSH service was installed and enabled, firewall access for SSH was reviewed, and the SSH service status was validated.

This lab demonstrates both the infrastructure deployment side of Azure Virtual Machines and the operating system administration side required to support secure remote management.

## Objectives

The objectives of this lab were to:

- Create a Linux virtual machine in Azure
- Allow inbound SSH and HTTP access during deployment
- Connect to the VM remotely using PuTTY
- Update and upgrade Linux packages
- Install the OpenSSH server
- Start and enable the SSH service
- Allow SSH traffic through the firewall
- Verify that the SSH service is running correctly

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
                    | demoLinuxVM1|
                    | Ubuntu 20.04|
                    +------+------+
                           |
                    +------+------+
                    | NSG Rules    |
                    | SSH (22)     |
                    | HTTP (80)    |
                    +------+------+
                           |
                    +------+------+
                    | Public IP    |
                    +------+------+
                           |
          +----------------+----------------+
          |                                 |
+---------+---------+             +---------+---------+
| PuTTY SSH Client  |             | Web / HTTP Access |
| Remote Admin      |             | Optional Testing   |
+-------------------+             +-------------------+
                           |
                    +------+------+
                    | OpenSSH     |
                    | Server      |
                    | systemctl    |
                    +-------------+
```

This architecture shows an Azure Linux virtual machine exposed through a public IP with inbound SSH access, allowing remote administration through PuTTY while the OpenSSH server handles secure shell connections.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser window is recommended to avoid Azure portal cache issues.

---

### Step 2 — Create the Linux Virtual Machine

Navigate to:

```text
Virtual Machines → Create
```

Configure the virtual machine with the following settings:

| Setting | Value |
|---|---|
| Virtual Machine Name | demoLinuxVM1 |
| Region | East US |
| Availability Options | No infrastructure redundancy required |
| Security Type | Standard |
| Image | Ubuntu Server 20.04 LTS |
| Size | B2s |
| Authentication Type | Password |
| Username | vm1 |
| Password | Lab-provided password |
| Public Inbound Ports | Allow selected ports |
| Inbound Ports | SSH (22), HTTP (80) |
| OS Disk Size | Image default (30 GiB) |
| OS Disk Type | Standard SSD |

Leave the other settings at default, then review and create the virtual machine.

After deployment completes, open the resource overview page.

—
<img width="1488" height="1744" alt="image" src="https://github.com/user-attachments/assets/c7be088a-473e-424a-b99a-0c374e7e0de8" />


### Step 3 — Retrieve the Public IP Address

From the virtual machine overview page, copy the **Public IP Address**.

This IP address is used to connect to the VM remotely through PuTTY.

---

### Step 4 — Connect to the Azure Linux VM Using PuTTY

Open **PuTTY** on your local machine.

In the **Host Name (or IP address)** field, paste the VM public IP address.

Select:

```text
Open
```

When prompted:

1. Accept the security alert if it appears
2. Enter the username
3. Enter the password

After successful authentication, you are logged into the Azure Linux virtual machine.

—
<img width="1523" height="698" alt="image" src="https://github.com/user-attachments/assets/e2c7c601-4129-49fb-b09b-09a538db490d" />


### Step 5 — Update and Upgrade the Linux Packages

Run the following command:

```bash
sudo apt update && sudo apt upgrade -y
```

This refreshes the package repository and upgrades installed packages so the system is current.

---

### Step 6 — Install the OpenSSH Server

Run:

```bash
sudo apt install openssh-server
```

This installs the OpenSSH server package, which enables the Linux VM to accept SSH connections.

—
<img width="1523" height="286" alt="image" src="https://github.com/user-attachments/assets/03355084-f1f6-4bcf-9c33-bd5bdba82ed2" />


### Step 7 — Start and Enable the SSH Service

Start the service:

```bash
sudo systemctl start ssh
```

Enable the service to start automatically on boot:

```bash
sudo systemctl enable ssh
```

These commands ensure the SSH service is active now and remains available after future restarts.

---

### Step 8 — Allow SSH Through the Firewall

If UFW is being used, allow SSH traffic:

```bash
sudo ufw allow ssh
```

This allows inbound connections on port 22 at the Linux firewall layer.

—
<img width="1523" height="178" alt="image" src="https://github.com/user-attachments/assets/85c12ca2-4590-4785-a24b-301d5f8b794b" />


### Step 9 — Verify the SSH Service

Check the service status:

```bash
sudo systemctl status ssh
```

Expected result:

- The SSH service is **active (running)**
- The service is listening for connections on port 22

—
<img width="1523" height="619" alt="image" src="https://github.com/user-attachments/assets/fc097916-7e1a-4ed6-81df-1b34d098ee74" />


### Step 10 — Confirm Remote Access Usage

Example SSH syntax:

```bash
ssh user@ip_address
```

Or:

```bash
ssh user@hostname
```

Replace:

- `user` with the VM username
- `ip_address` or `hostname` with the actual VM connection value

To exit the remote session:

```bash
exit
```
<img width="1523" height="214" alt="image" src="https://github.com/user-attachments/assets/492baa09-8a34-4ab8-b83d-34ea102da54d" />


### Azure CLI (Bash)

Create the Linux VM:

```bash
az vm create \
  --resource-group rg_eastus_XXXXX \
  --name demoLinuxVM1 \
  --image Ubuntu2004 \
  --size Standard_B2s \
  --admin-username vm1 \
  --admin-password 'StrongPassword123!' \
  --authentication-type password
```

Open SSH and HTTP ports:

```bash
az vm open-port \
  --resource-group rg_eastus_XXXXX \
  --name demoLinuxVM1 \
  --port 22
```

```bash
az vm open-port \
  --resource-group rg_eastus_XXXXX \
  --name demoLinuxVM1 \
  --port 80
```

Show the VM public IP:

```bash
az vm show \
  --resource-group rg_eastus_XXXXX \
  --name demoLinuxVM1 \
  --show-details \
  --query publicIps \
  --output tsv
```

### Azure PowerShell

Create the Linux VM:

```powershell
New-AzVM `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Name "demoLinuxVM1" `
  -Location "East US" `
  -Image "UbuntuLTS" `
  -Size "Standard_B2s" `
  -Credential (Get-Credential)
```

Open SSH port 22:

```powershell
Get-AzNetworkSecurityGroup `
  -ResourceGroupName "rg_eastus_XXXXX" | Select-Object -ExpandProperty SecurityRules
```

Create or confirm an SSH allow rule if needed:

```powershell
$nsg = Get-AzNetworkSecurityGroup -ResourceGroupName "rg_eastus_XXXXX" -Name "demoLinuxVM1NSG"

Add-AzNetworkSecurityRuleConfig `
  -Name "Allow-SSH" `
  -NetworkSecurityGroup $nsg `
  -Description "Allow SSH" `
  -Access Allow `
  -Protocol Tcp `
  -Direction Inbound `
  -Priority 100 `
  -SourceAddressPrefix * `
  -SourcePortRange * `
  -DestinationAddressPrefix * `
  -DestinationPortRange 22

$nsg | Set-AzNetworkSecurityGroup
```

Get the public IP:

```powershell
(Get-AzPublicIpAddress -ResourceGroupName "rg_eastus_XXXXX").IpAddress
```

## Implementation Walkthrough

The lab began by deploying an Ubuntu 20.04 Linux virtual machine named `demoLinuxVM1` in Azure. During deployment, inbound ports **22** and **80** were allowed so the machine could support remote administration and optional web traffic. A password-based administrator account was configured, and the VM was deployed with a Standard SSD operating system disk.

After deployment, the VM’s public IP address was copied from the Azure portal and used inside **PuTTY** to establish a remote SSH session. This demonstrated practical administration of an Azure Linux machine from a Windows-friendly SSH client.

Once connected, Linux package repositories were updated and the system was upgraded. The **OpenSSH server** package was then installed, started, and enabled to launch automatically on boot. Finally, the firewall rule for SSH was allowed through UFW and `systemctl status ssh` was used to verify that the SSH daemon was running correctly.

This lab combined Azure infrastructure deployment with Linux administration tasks, which is an important operational skillset for cloud engineers.

## Results & Validation

| Test | Result |
|---|---|
| Linux VM deployment | Successful |
| Public IP retrieval | Successful |
| PuTTY connection | Successful |
| Package update and upgrade | Successful |
| OpenSSH server installation | Successful |
| SSH service start | Successful |
| SSH service auto-start enablement | Successful |
| Firewall SSH allow rule | Successful |
| SSH service verification | Successful |

Key observations:

- Azure provided a working Linux IaaS environment with remote access
- PuTTY successfully connected to the VM using the public IP
- OpenSSH server was installed and configured correctly
- The SSH service could be managed through `systemctl`
- Allowing port 22 at both the Azure NSG layer and OS firewall layer supports reliable remote access

## Validation Walkthrough

1. Verified that `demoLinuxVM1` was created successfully in Azure.
2. Confirmed that inbound ports **22** and **80** were allowed during deployment.
3. Copied the VM public IP from the overview page.
4. Opened PuTTY and connected to the VM using the public IP.
5. Logged in successfully using the configured username and password.
6. Ran `sudo apt update && sudo apt upgrade -y` and confirmed the package update completed.
7. Installed OpenSSH server using `sudo apt install openssh-server`.
8. Started the SSH service with `sudo systemctl start ssh`.
9. Enabled the SSH service at boot with `sudo systemctl enable ssh`.
10. Allowed SSH through UFW using `sudo ufw allow ssh`.
11. Ran `sudo systemctl status ssh` and confirmed the service showed as active and running.
12. Verified that the session could be exited properly using `exit`.

## Real-World Use Case

This pattern is common for administrators who need secure remote access to Linux servers in Azure.

Example: **Remote Administration of a Linux Server**

| Component | Role |
|---|---|
| Azure VM | Hosts the Linux operating system |
| Public IP | Internet-reachable endpoint |
| NSG Rule | Allows SSH traffic |
| OpenSSH Server | Accepts secure remote connections |
| PuTTY | SSH client used for remote access |

Typical workflow:

```text
Deploy Linux VM in Azure
          ↓
Allow SSH Port 22
          ↓
Connect with PuTTY
          ↓
Install / Verify OpenSSH Server
          ↓
Administer the VM Remotely
```

This pattern is useful for system administration, development servers, testing environments, and general-purpose Linux workload management in Azure.

## Key Takeaways

This lab demonstrated several important Azure and Linux administration concepts:

- Azure Virtual Machines provide flexible Linux infrastructure in the cloud
- PuTTY can be used to remotely administer Azure Linux VMs over SSH
- OpenSSH server enables secure shell access to Linux systems
- `systemctl` is used to start, enable, and verify services
- Firewall and network access must both be configured correctly for successful remote connectivity

Understanding Azure Linux VM deployment and SSH server configuration is valuable for cloud administrators, infrastructure engineers, and anyone managing Linux workloads in Azure.

