# Azure Container Instances Multi-Container Group Deployment with ARM Template

## Introduction

Azure Container Instances (ACI) provides a fast way to run containers in Azure without managing virtual machines or Kubernetes clusters. One of its useful features is the ability to deploy a **container group**, where multiple containers run together as a single unit and share resources such as CPU, memory, networking, and storage.

In this lab, an **ARM template** was created in Azure Cloud Shell to deploy a **multi-container group** with two Linux containers. The first container hosted an internet-facing web application, while the second acted as a **sidecar container** that communicated with the main application over the group’s local network. The deployment exposed ports **80** and **8080**, assigned a public IP address, and used Azure CLI commands to review deployment status and view logs from both containers.

## Objectives

The objectives of this lab were to:

- Set up Azure Cloud Shell in Bash mode
- Create an ARM template for a multi-container group
- Define a public IP configuration and exposed ports
- Deploy the ARM template to Azure
- Verify the container group deployment state
- Access the running web application through its public IP
- Review logs for both the application container and the sidecar container
- Understand how multi-container groups support sidecar patterns in Azure Container Instances

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
                  +--------+--------+
                  | ARM Template    |
                  | azuredeploy.json|
                  +--------+--------+
                           |
                    Azure Cloud Shell
                           |
                  +--------+--------+
                  | Container Group |
                  | myContainerGroup|
                  | Public IP       |
                  +--------+--------+
                           |
          +----------------+----------------+
          |                                 |
+---------+---------+             +---------+---------+
| aci-tutorial-app  |             | aci-tutorial-     |
| Main web app      |             | sidecar           |
| Port 80 / 8080    |             | Local HTTP checks |
+---------+---------+             +---------+---------+
          |                                 |
          +--------------- localhost -------+
                           |
                     Web Browser / CLI
```

This architecture shows a multi-container group in Azure Container Instances where the main application container serves web traffic and the sidecar container communicates with it over the shared local network.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser session is recommended to avoid Azure portal cache issues.

---

### Step 2 — Set Up Azure Cloud Shell

In the Azure portal, select:

```text
Cloud Shell
```

Choose:

```text
Bash
```

When prompted, select:

```text
No storage account required
```

Choose the assigned **Pay-as-you-go** subscription and open the Bash session.

---

### Step 3 — Create the ARM Template File

In Azure Cloud Shell, create a new file:

```bash
code azuredeploy.json
```

This opens the Cloud Shell editor.

Paste the ARM template JSON into the file. The template defines:

- A container group named `myContainerGroup`
- Two Linux containers
- Public IP exposure
- TCP ports `80` and `8080`
- Image registry credentials for pulling images from a private registry
- An output that returns the container group IPv4 address

Save the file with:

```text
Ctrl + S
```

Then close the editor.

---

### Step 4 — Review the Multi-Container ARM Template

The ARM template includes these main elements:

| Component | Purpose |
|---|---|
| `parameters` | Defines the container group name |
| `variables` | Stores container names and image names |
| `resources` | Creates the Azure Container Instance container group |
| `imageRegistryCredentials` | Authenticates to the private registry |
| `ipAddress` | Exposes public ports 80 and 8080 |
| `outputs` | Returns the public IPv4 address |

Container definitions in the template:

| Container | Purpose |
|---|---|
| `aci-tutorial-app` | Internet-facing web application |
| `aci-tutorial-sidecar` | Sidecar container making HTTP requests to the main app |

Resource requests per container:

| Resource | Value |
|---|---|
| CPU | 1 |
| Memory | 1.5 GB |

Because both containers are in the same group, they share the same lifecycle and networking context.

---

### Step 5 — Deploy the ARM Template

Log in with Azure CLI if needed:

```bash
az login
```

Deploy the template:

```bash
az deployment group create \
  --resource-group <myResourceGroup> \
  --template-file azuredeploy.json
```

Replace `<myResourceGroup>` with the assigned resource group.

Azure returns deployment progress information and then provisions the multi-container group.

---

### Step 6 — View the Deployment State

After the deployment completes, check the container group state:

```bash
az container show \
  --resource-group <myResourceGroup> \
  --name myContainerGroup \
  --output table
```

Expected output includes:

- Container group name
- Current state
- Public IP address
- Exposed ports

This confirms whether the deployment succeeded and whether the application is ready.

—


### Step 7 — Access the Running Application

From the `az container show` output, copy the public IP address.

Open a web browser and navigate to:

```text
http://<public-ip>
```

Expected result:

- The web application loads successfully

This validates that the internet-facing container is running and reachable.

—


### Step 8 — View Logs for the Main Application Container

Run:

```bash
az container logs \
  --resource-group <myResourceGroup> \
  --name myContainerGroup \
  --container-name aci-tutorial-app
```

This displays log entries generated by the main application container.

—


### Step 9 — View Logs for the Sidecar Container

Run:

```bash
az container logs \
  --resource-group <myResourceGroup> \
  --name myContainerGroup \
  --container-name aci-tutorial-sidecar
```

Expected result:

- The logs show the sidecar periodically making HTTP requests to the main web application using the shared local network

This demonstrates the sidecar design pattern inside a shared container group.

### Azure CLI (Bash)

Create the ARM template file in Cloud Shell:

```bash
code azuredeploy.json
```

Deploy the ARM template:

```bash
az deployment group create \
  --resource-group <myResourceGroup> \
  --template-file azuredeploy.json
```

Show the container group state:

```bash
az container show \
  --resource-group <myResourceGroup> \
  --name myContainerGroup \
  --output table
```

Show logs for the application container:

```bash
az container logs \
  --resource-group <myResourceGroup> \
  --name myContainerGroup \
  --container-name aci-tutorial-app
```

Show logs for the sidecar container:

```bash
az container logs \
  --resource-group <myResourceGroup> \
  --name myContainerGroup \
  --container-name aci-tutorial-sidecar
```

Export the container group configuration:

```bash
az container export \
  --resource-group <myResourceGroup> \
  --name myContainerGroup
```

### Azure PowerShell

Deploy the ARM template:

```powershell
New-AzResourceGroupDeployment `
  -ResourceGroupName "<myResourceGroup>" `
  -TemplateFile "azuredeploy.json"
```

Get the container group:

```powershell
Get-AzContainerGroup `
  -ResourceGroupName "<myResourceGroup>" `
  -Name "myContainerGroup"
```

Show the application container logs:

```powershell
Get-AzContainerInstanceLog `
  -ResourceGroupName "<myResourceGroup>" `
  -ContainerGroupName "myContainerGroup" `
  -ContainerName "aci-tutorial-app"
```

Show the sidecar container logs:

```powershell
Get-AzContainerInstanceLog `
  -ResourceGroupName "<myResourceGroup>" `
  -ContainerGroupName "myContainerGroup" `
  -ContainerName "aci-tutorial-sidecar"
```

## Implementation Walkthrough

The lab began by opening Azure Cloud Shell in Bash mode and creating a new ARM template file named `azuredeploy.json`. This template defined a multi-container deployment using Azure Container Instances. Two containers were included: the primary application container `aci-tutorial-app` and the sidecar container `aci-tutorial-sidecar`. Both were configured to run as part of the same container group, which meant they shared CPU, memory, lifecycle, and networking.

The template also exposed ports `80` and `8080` through a public IP configuration and included image registry credentials for secure image retrieval. After the template was saved, it was deployed using `az deployment group create`, which created the container group in the assigned resource group.

Once deployed, Azure CLI was used to confirm the container group state and retrieve the public IP address. The main application was then tested through a web browser. Finally, logs were collected separately for both containers. The application container logs showed web server activity, while the sidecar logs demonstrated periodic internal HTTP checks against the main app over the shared local network.

## Results & Validation

| Test | Result |
|---|---|
| Azure Cloud Shell setup | Successful |
| ARM template creation | Successful |
| Multi-container group deployment | Successful |
| Public IP and port exposure | Successful |
| Application access in browser | Successful |
| Main container log retrieval | Successful |
| Sidecar log retrieval | Successful |

Key observations:

- Both containers were deployed successfully inside one container group
- The container group shared one public IP address
- The sidecar container communicated with the main application over the shared local network
- Azure CLI provided direct visibility into deployment state and logs
- The ARM template enabled repeatable Infrastructure as Code deployment

## Validation Walkthrough

1. Verified that Azure Cloud Shell opened successfully in Bash mode.
2. Created the `azuredeploy.json` file and pasted the ARM template content.
3. Saved the ARM template and exited the editor.
4. Ran the ARM template deployment command against the assigned resource group.
5. Confirmed that the deployment completed successfully.
6. Ran `az container show` and verified the container group status, public IP, and ports.
7. Opened the public IP in a browser and confirmed the application loaded.
8. Retrieved logs from `aci-tutorial-app` and confirmed application activity.
9. Retrieved logs from `aci-tutorial-sidecar` and confirmed internal HTTP request activity.
10. Verified that the sidecar was interacting with the main web application through the container group’s local network.

## Real-World Use Case

Multi-container groups are useful when closely related containers must run together and share resources.

Example: **Web App with a Sidecar Monitor**

| Component | Role |
|---|---|
| Main application container | Serves the web application |
| Sidecar container | Performs health checks or supporting tasks |
| Shared container group | Provides common network and lifecycle |
| Public IP | Exposes the primary service externally |
| ARM template | Automates repeatable deployment |

Typical workflow:

```text
ARM Template Defines Multi-Container Group
               ↓
Azure Deploys Main App + Sidecar Together
               ↓
Main App Serves External Requests
               ↓
Sidecar Uses Localhost to Check App Health
               ↓
Logs Show Both Service Activity and Validation
```

This pattern is useful for lightweight monitoring, logging, proxying, or auxiliary tasks that should remain tightly coupled to the main application container.

## Key Takeaways

This lab demonstrated several important Azure container concepts:

- Azure Container Instances supports multi-container groups as a single deployment unit
- Containers in a group share network, lifecycle, and resource allocation
- ARM templates provide Infrastructure as Code for repeatable deployments
- Public ports can be exposed from a container group using one public IP address
- Sidecar containers are a practical design pattern for health checks and support services
- Azure CLI can be used to validate deployment status and inspect logs for each container

Understanding Azure multi-container groups and ARM-based deployment is useful for cloud administrators, DevOps engineers, and platform teams building lightweight containerized solutions in Azure.

