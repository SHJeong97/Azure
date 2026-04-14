# Azure Kubernetes Service Deployment with NGINX and Public Load Balancer Service

## Introduction

Azure Kubernetes Service (AKS) is a managed Kubernetes platform that simplifies container orchestration in Azure. Instead of manually deploying and maintaining the Kubernetes control plane, administrators can focus on application deployment, scaling, and service exposure while Azure manages the underlying orchestration platform.

In this lab, an **Azure Kubernetes Service (AKS)** cluster was deployed using the **Dev/Test** preset configuration. A containerized **NGINX** workload was then deployed to the cluster using YAML, followed by the creation of a Kubernetes **Service** of type **LoadBalancer** so the application could be reached from the internet using a public external IP address.

This lab demonstrates how AKS can be used to host containerized applications and expose them externally through Kubernetes-native service definitions.

## Objectives

The objectives of this lab were to:

- Create an Azure Kubernetes Service cluster
- Configure the AKS cluster with a custom node size and node count
- Disable Prometheus metrics during deployment
- Deploy an NGINX container workload using YAML
- Create a Kubernetes Service of type `LoadBalancer`
- Expose the NGINX workload to the internet using an external IP
- Validate that the containerized application is running successfully

## Architecture Diagram

```text
                +----------------------+
                |   Azure Subscription |
                +----------+-----------+
                           |
                +----------+-----------+
                |       Resource Group |
                |   resource group_xxx |
                +----------+-----------+
                           |
                +----------+-----------+
                |   AKS Cluster         |
                |      demoKube         |
                |  2 Worker Nodes       |
                +----------+-----------+
                           |
                +----------+-----------+
                | Kubernetes Deployment |
                |       NGINX Pod       |
                +----------+-----------+
                           |
                +----------+-----------+
                | Kubernetes Service    |
                |   Type: LoadBalancer  |
                +----------+-----------+
                           |
                    External Public IP
                           |
                        Web Browser
```

This architecture shows an AKS cluster hosting an NGINX deployment and exposing it externally through a Kubernetes `LoadBalancer` service, which Azure maps to a public IP address.

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser window is recommended to avoid Azure portal cache issues. 

### Step 2 — Create an Azure Kubernetes Service Cluster

Navigate to:

```text
Create a resource → Azure Kubernetes Service
```

Configure the cluster with the following values:

| Setting | Value |
|---|---|
| Resource Group | resource group_XXXXX |
| Cluster Preset Configuration | Dev/Test |
| Kubernetes Cluster Name | demoKube |
| Region | Central US |

Under the **Node pools** tab, configure the default node pool:

| Setting | Value |
|---|---|
| Node Size | Standard D2as v4 |
| Scale Method | Manual |
| Node Count | 2 |
| Max Pods per Node | 30 |

Under the **Monitoring** tab:

| Setting | Value |
|---|---|
| Enable Prometheus metrics | Unchecked |

Review and create the cluster.

The AKS deployment takes several minutes to complete. 
<img width="1523" height="1631" alt="image" src="https://github.com/user-attachments/assets/1ece2519-edc1-459f-9bb3-a9355fcf60e6" />



### Step 3 — Open the AKS Resource

After deployment completes, select:

```text
Go to resource
```

Ignore any temporary portal error message if it appears.

In the AKS resource menu, navigate to:

```text
Kubernetes resources → Workloads
```

This is where the Kubernetes deployment objects can be created and managed from the portal. 
<img width="1523" height="817" alt="image" src="https://github.com/user-attachments/assets/15708039-a639-46eb-904e-cada6324a07e" />


### Step 4 — Deploy the NGINX Workload Using YAML

In the **Workloads** section, select:

```text
+ Create → Apply a YAML
```

Download the provided deployment YAML and paste its contents into the YAML editor.

Apply the YAML and refresh the Workloads page.

Expected result:

- The NGINX workload is created successfully
- A running NGINX deployment becomes visible in the AKS Workloads view

This step deploys the containerized application into the Kubernetes cluster. 


### Step 5 — Create a LoadBalancer Service

In the AKS resource, navigate to:

```text
Services and ingresses
```

Select:

```text
+ Create → Apply a YAML
```

Paste the following service definition:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: demo-service
spec:
  type: LoadBalancer
  ports:
    - port: 80
  selector:
    app: nginx
```

Apply the YAML.

This service places an Azure-managed load balancer in front of the NGINX workload and assigns an external public IP for internet access. 

<img width="1523" height="569" alt="image" src="https://github.com/user-attachments/assets/8d2459ca-eb44-4b48-970b-6951787eca68" />

### Step 6 — Validate External Access

After the service deploys, refresh the **Services and ingresses** view.

Expected result:

- The service `demo-service` appears
- An **External IP address** is assigned

Select the external IP address.

The browser should display the NGINX default page, confirming that the container is running and accessible from the internet through the Kubernetes service.
<img width="1523" height="564" alt="image" src="https://github.com/user-attachments/assets/75a40970-bc1d-4ef1-a06c-e60d12b080d4" />

## Azure CLI (Bash)

Create the AKS cluster:

```bash
az aks create \
  --resource-group "resource group_XXXXX" \
  --name demoKube \
  --location centralus \
  --node-count 2 \
  --node-vm-size Standard_D2as_v4 \
  --max-pods 30 \
  --generate-ssh-keys
```

Get AKS credentials:

```bash
az aks get-credentials \
  --resource-group "resource group_XXXXX" \
  --name demoKube
```

Apply the NGINX deployment YAML:

```bash
kubectl apply -f nginx-deployment.yaml
```

Create the LoadBalancer service:

```bash
kubectl apply -f demo-service.yaml
```

View pods:

```bash
kubectl get pods
```

View services:

```bash
kubectl get svc
```

## Azure PowerShell

Create the AKS cluster:

```powershell
New-AzAksCluster `
  -ResourceGroupName "resource group_XXXXX" `
  -Name "demoKube" `
  -Location "Central US" `
  -NodeCount 2 `
  -NodeVmSetType VirtualMachineScaleSets `
  -NodeVmSize "Standard_D2as_v4" `
  -GenerateSshKey
```

Retrieve cluster credentials:

```powershell
Import-AzAksCredential `
  -ResourceGroupName "resource group_XXXXX" `
  -Name "demoKube"
```

Apply the NGINX deployment YAML:

```powershell
kubectl apply -f .\nginx-deployment.yaml
```

Apply the LoadBalancer service YAML:

```powershell
kubectl apply -f .\demo-service.yaml
```

Verify workloads:

```powershell
kubectl get deployments
kubectl get pods
kubectl get svc
```

## Implementation Walkthrough

The lab began with the creation of an AKS cluster using the **Dev/Test** preset, which is suitable for lightweight Kubernetes training and validation scenarios. The cluster was configured with two worker nodes using the `Standard D2as v4` size and manual scaling. Prometheus metrics were disabled during setup to simplify the lab configuration and reduce unnecessary monitoring components for this basic deployment.

After the AKS cluster was deployed, the Kubernetes portal experience was used to create a workload from YAML. This YAML defined the NGINX deployment and launched the containerized web server inside the cluster. Once the workload was running, a second YAML file was applied to create a Kubernetes Service of type `LoadBalancer`. In AKS, this service type integrates with Azure networking to automatically provision external access for the application. 

Finally, the service view showed an assigned external IP address. Opening that IP address in a browser confirmed the NGINX default page was reachable, which validated that both the Kubernetes deployment and service exposure were functioning correctly.

## Results & Validation

| Test | Result |
|---|---|
| AKS cluster deployment | Successful |
| Node pool customization | Successful |
| NGINX workload deployment | Successful |
| Kubernetes Service creation | Successful |
| External IP assignment | Successful |
| Browser access to NGINX | Successful |

Key observations:

- AKS successfully hosted the NGINX containerized application
- YAML-based deployment simplified Kubernetes resource creation
- The `LoadBalancer` service type exposed the application externally
- Azure automatically assigned a public IP to the service
- The workload could be validated directly through the browser

## Validation Walkthrough

1. Verified that the AKS cluster `demoKube` was deployed successfully in the assigned resource group.
2. Confirmed that the default node pool used `Standard D2as v4` with a node count of `2`.
3. Opened the **Workloads** section under **Kubernetes resources**.
4. Applied the deployment YAML and confirmed the NGINX workload appeared after refresh.
5. Opened **Services and ingresses** and applied the service YAML.
6. Confirmed that the service `demo-service` was created successfully.
7. Verified that an external public IP address was assigned to the service.
8. Opened the external IP address in a browser.
9. Confirmed that the NGINX default page loaded successfully.

## Real-World Use Case

AKS is commonly used for hosting modern containerized applications that need orchestration, resilience, and scalable service exposure.

Example: **Public Web Application on Kubernetes**

| Component | Role |
|---|---|
| AKS Cluster | Container orchestration platform |
| NGINX Deployment | Hosted application workload |
| Kubernetes Service | Traffic exposure and routing |
| Azure Load Balancer | Public entry point |
| External IP | Internet-facing access |

Typical workflow:

```text
Container Image Deployed to AKS
              ↓
Kubernetes Deployment Creates Pods
              ↓
Service Type LoadBalancer Exposes Application
              ↓
Azure Assigns External IP
              ↓
Users Access the App from the Internet
```

This model is widely used for web applications, APIs, and microservices that need cloud-native deployment and scalable traffic management.

## Key Takeaways

This lab demonstrated several important Azure and Kubernetes concepts:

- AKS provides a managed Kubernetes platform in Azure
- Kubernetes workloads can be deployed directly from YAML definitions
- A Kubernetes `LoadBalancer` service exposes applications externally
- Azure automatically integrates public IP allocation for AKS services
- Containerized applications can be validated quickly through browser-based testing

Understanding AKS deployments and Kubernetes service exposure is valuable for cloud engineers, DevOps professionals, and platform administrators working with containerized applications in Azure.

