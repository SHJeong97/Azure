# Azure Private Endpoint Deployment Using ARM Template

## Introduction

Azure Private Endpoints allow secure connectivity to Azure services using a private IP address within a Virtual Network (VNet). Instead of accessing services such as Azure SQL Database through public endpoints, a private endpoint enables communication entirely within Azure’s private network infrastructure.

In this lab, an Azure Resource Manager (ARM) template was used to deploy a secure architecture consisting of a SQL Server, SQL database, Virtual Network, subnet, private endpoint, private DNS zone, and a Windows virtual machine. The deployment demonstrates how infrastructure can be automated using ARM templates and how private endpoints can be used to securely connect to Azure services without exposing them to the public internet.

---

## Objectives

The objectives of this lab were to:

- Analyze an ARM template used for Azure resource deployment
- Deploy infrastructure using Azure Cloud Shell
- Create a Virtual Network and subnet
- Deploy an Azure SQL Server and database
- Configure a Private Endpoint for secure database access
- Configure Private DNS integration
- Deploy a Virtual Machine inside the Virtual Network
- Test connectivity to the SQL database through the private endpoint
- json file from https://learn.microsoft.com/en-us/azure/private-link/create-private-endpoint-template
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
                +----------+-----------+
                           |
                   +-------+--------+
                   | Virtual Network|
                   | 10.0.0.0/16    |
                   +-------+--------+
                           |
                        Subnet
                       10.0.0.0/24
                           |
              +------------+-------------+
              |                          |
      +-------+--------+         +-------+--------+
      |   Private DNS  |         |  Virtual Machine|
      |    Zone        |         |   Windows VM    |
      | privatelink... |         |    myVmxxxx     |
      +-------+--------+         +-------+--------+
              |                          |
        +-----+--------------------------+
        |
   +----+----+
   | Private |
   | Endpoint|
   +----+----+
        |
   +----+----+
   | Azure SQL|
   |  Server   |
   +----+----+
        |
   +----+----+
   | Database |
   | sample-db|
   +----------+
```

This architecture enables a virtual machine inside a virtual network to securely connect to an Azure SQL Database using a private endpoint and private DNS resolution.

---

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to:

```
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser window is recommended to avoid cached authentication sessions.

---

### Step 2 — Explore the ARM Template

The provided ARM template defines multiple Azure resources including:

| Resource | Purpose |
|--------|--------|
| SQL Server | Hosts the database instance |
| SQL Database | Sample database deployment |
| Virtual Network | Network environment |
| Subnet | Network segmentation |
| Private Endpoint | Secure connection to SQL |
| Private DNS Zone | Name resolution for private endpoint |
| Virtual Machine | Test client inside the network |

Key parameter examples:

```
sqlAdministratorLogin
sqlAdministratorLoginPassword
vmAdminUsername
vmAdminPassword
VmSize
location
```

These parameters allow dynamic configuration during deployment.

---

### Step 3 — Deploy ARM Template

Open **Azure Cloud Shell** and select **Bash**.

Upload the template file:

```
template.json
```

Deploy the template using Azure CLI:

```bash
az deployment group create \
  --name demodeployment1 \
  --resource-group rg_eastus_XXXXX \
  --template-file template.json \
  --parameters \
  sqlAdministratorLogin=demosql \
  sqlAdministratorLoginPassword=P@sswo0rd \
  vmAdminUsername=demovm \
  vmAdminPassword=P@ssw0rd! \
  location=eastus
```

Deployment may take approximately **20 minutes**.

—

<img width="1523" height="138" alt="image" src="https://github.com/user-attachments/assets/9f50a8fc-fe5a-4c6a-ad9f-2548e810fab2" />
<img width="1523" height="548" alt="image" src="https://github.com/user-attachments/assets/7fa4b2d7-59d3-46cc-bbcf-dc55ca8f6cb7" />
<img width="1523" height="770" alt="image" src="https://github.com/user-attachments/assets/fd041aca-b222-4c7a-aefa-c4bf71c8749b" />
<img width="1523" height="414" alt="image" src="https://github.com/user-attachments/assets/292218a5-d7e9-48de-ac2d-fe4a9acc68f5" />
<img width="1302" height="472" alt="image" src="https://github.com/user-attachments/assets/0776518c-734f-4ccd-9bd9-93284a42b429" />
<img width="1406" height="1409" alt="image" src="https://github.com/user-attachments/assets/23f6ca77-1e00-4675-adf7-0de1f9b64b45" />
<img width="1523" height="708" alt="image" src="https://github.com/user-attachments/assets/a8d07628-9b97-492c-b2d6-0b0a09e84b23" />
<img width="969" height="661" alt="image" src="https://github.com/user-attachments/assets/a9f86fe5-81c5-433c-8275-c94f9e8f030b" />









## Implementation Walkthrough

The ARM template automatically deploys a full architecture required for secure SQL connectivity.

The deployment process includes:

1. Creating a SQL Server instance.
2. Deploying a SQL database.
3. Creating a Virtual Network and subnet.
4. Deploying a private endpoint connected to the SQL Server.
5. Creating a private DNS zone for name resolution.
6. Linking the DNS zone to the virtual network.
7. Deploying a virtual machine within the network.

The virtual machine acts as a test client to validate private connectivity.

---

## Results & Validation

| Test | Result |
|----|----|
| ARM template deployment | Successful |
| SQL server deployment | Successful |
| Virtual network creation | Successful |
| Private endpoint creation | Successful |
| Private DNS configuration | Successful |
| Virtual machine deployment | Successful |
| SQL connectivity via private endpoint | Successful |

Key observation:

Public network access for the SQL server was disabled, ensuring connectivity only through the private endpoint.

---

## Validation Walkthrough

1. Verified that all resources were created in the resource group.
2. Confirmed the private endpoint was deployed.
3. Connected to the virtual machine using RDP.
4. Disabled IE Enhanced Security Configuration.
5. Ran `nslookup` to confirm private DNS resolution.
6. Installed SQL Server Management Studio (SSMS).
7. Connected to the SQL server using SQL authentication.
8. Confirmed the **sample database** appeared in the database list.

---

## Real-World Use Case

Private Endpoints are widely used in enterprise environments where services must not be publicly accessible.

Example: **Secure Database Architecture**

| Component | Role |
|--------|------|
| Azure SQL Database | Data storage |
| Virtual Network | Private network |
| Private Endpoint | Secure connection |
| Private DNS | Name resolution |
| Virtual Machine | Application host |

Typical architecture:

```
Application Server → Private Endpoint → Azure SQL Database
```

This design ensures database traffic never traverses the public internet, improving security and compliance.

---

## Key Takeaways

This lab demonstrated several important Azure architecture concepts:

- ARM templates enable **Infrastructure as Code (IaC)** deployment.
- Private endpoints allow Azure services to be accessed securely through private networks.
- Private DNS zones ensure proper name resolution for private services.
- Virtual machines inside a VNet can securely access Azure PaaS services.
- Disabling public network access significantly improves security posture.

Understanding private endpoints and ARM template deployments is essential for cloud engineers designing secure Azure architectures.


