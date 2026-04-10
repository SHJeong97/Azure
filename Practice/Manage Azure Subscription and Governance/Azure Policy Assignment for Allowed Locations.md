# Azure Policy Assignment for Allowed Locations

## Introduction

Azure Policy is a governance service that helps enforce organizational standards and assess compliance across Azure resources. It allows administrators to define rules that control how resources can be deployed and configured.

One common governance requirement is restricting where resources can be created. This helps organizations meet compliance, data residency, cost management, and operational standards. In this lab, a built-in Azure Policy definition called **Allowed locations** was assigned to a resource group to restrict deployments so that resources could only be created in **UK South**.

The policy was then tested by attempting to deploy a virtual network in a disallowed region (**East US**), which failed, and then in the allowed region (**UK South**), which succeeded.

---

## Objectives

The objectives of this lab were to:

- Explore Azure Policy built-in definitions
- Assign the **Allowed locations** policy to a resource group
- Restrict resource deployment to **UK South**
- Test a non-compliant deployment in **East US**
- Validate a compliant deployment in **UK South**
- Understand how Azure Policy supports governance and compliance

---

## Architecture Diagram

```
                +----------------------+
                |   Azure Subscription |
                |      PAYG-Labs2      |
                +----------+-----------+
                           |
                +----------+-----------+
                |       Resource Group |
                |     rg_eastus_xxxxx  |
                +----------+-----------+
                           |
                +----------+-----------+
                |   Azure Policy       |
                | Allowed Locations    |
                |  UK South Only       |
                +----------+-----------+
                           |
          +----------------+----------------+
          |                                 |
+---------+---------+             +---------+---------+
| Virtual Network   |             | Virtual Network   |
| Region: East US   |             | Region: UK South  |
| Deployment Failed |             | Deployment Passed |
+-------------------+             +-------------------+
```

This architecture shows how a policy assignment at the resource group scope enforces location restrictions on newly created resources.

---

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser window is recommended to avoid cached account issues.

---

### Step 2 — Open Azure Policy

In the Azure Portal search bar, search for:

```text
Policy
```

Open the **Policy** service.

At the top of the Policy overview page, change the **Scope** to the target resource group:

```text
rg_eastus_XXXXX
```

This ensures the policy assignment applies only to that resource group.

—
<img width="1523" height="1100" alt="image" src="https://github.com/user-attachments/assets/6c0b8df0-6d8e-4526-a554-ab46d75e8c23" />


### Step 3 — Locate the Allowed Locations Definition

Under the **Authoring** section, select:

```text
Definitions
```

Search for:

```text
Allowed locations
```

Open the built-in policy definition to view its details.

This policy restricts deployments to one or more specified Azure regions.

—
<img width="1523" height="644" alt="image" src="https://github.com/user-attachments/assets/b8b87929-2d98-45e5-9d4a-1aabe198cfa9" />


### Step 4 — Assign the Policy

Select **Assign policy** and configure the following:

| Setting | Value |
|---|---|
| Assignment Name | Allow UK South for `<resource-group-name>` |
| Description | Allow resources to be created in UK South Only for `<resource-group-name>` |
| Policy Enforcement | Enabled |

On the **Parameters** tab, set the allowed location to:

```text
UK South
```

Review and create the assignment.

After a few moments, the policy assignment becomes active.

—
<img width="1523" height="1383" alt="image" src="https://github.com/user-attachments/assets/f02c5e2d-a8fd-4422-bb5c-3a0f8b44c9f8" />


### Step 5 — Test a Non-Compliant Deployment

Navigate to:

```text
Virtual Networks → Create
```

Configure a virtual network with:

| Setting | Value |
|---|---|
| Resource Group | rg_eastus_XXXXX |
| Name | demoVNet1 |
| Region | East US |

Proceed with validation and create the resource.

Expected result:

- Validation may pass
- Deployment fails because **East US** is not permitted by the policy assignment

This confirms the policy is being enforced.

—
<img width="1458" height="1545" alt="image" src="https://github.com/user-attachments/assets/59896fa2-9a6c-400b-a663-2ce9869acef9" />


### Step 6 — Test a Compliant Deployment

Repeat the virtual network creation, but change the region to:

```text
UK South
```

Proceed with validation and deployment.

Expected result:

- Deployment succeeds because the resource complies with the **Allowed locations** policy

This confirms that policy enforcement is working correctly for compliant resources.

—
<img width="1384" height="1548" alt="image" src="https://github.com/user-attachments/assets/155a88e1-808d-451e-9bdc-c75a7ac36656" />


### Azure CLI (Bash)

Create a policy assignment for allowed locations:

```bash
az policy assignment create \
  --name "Allow-UK-South" \
  --display-name "Allow UK South Only" \
  --scope "/subscriptions/<subscription-id>/resourceGroups/rg_eastus_XXXXX" \
  --policy "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c" \
  --params '{ "listOfAllowedLocations": { "value": ["uksouth"] } }'
```

Test deployment of a non-compliant virtual network:

```bash
az network vnet create \
  --resource-group rg_eastus_XXXXX \
  --name demoVNet1 \
  --location eastus \
  --address-prefix 10.1.0.0/16
```

Test deployment of a compliant virtual network:

```bash
az network vnet create \
  --resource-group rg_eastus_XXXXX \
  --name demoVNet1 \
  --location uksouth \
  --address-prefix 10.1.0.0/16
```

List policy assignments at the resource group scope:

```bash
az policy assignment list \
  --scope "/subscriptions/<subscription-id>/resourceGroups/rg_eastus_XXXXX"
```

---

### Azure PowerShell

Get the built-in policy definition and assign it:

```powershell
$policy = Get-AzPolicyDefinition | Where-Object { $_.Properties.DisplayName -eq "Allowed locations" }

New-AzPolicyAssignment `
  -Name "Allow-UK-South" `
  -DisplayName "Allow UK South Only" `
  -Scope "/subscriptions/<subscription-id>/resourceGroups/rg_eastus_XXXXX" `
  -PolicyDefinition $policy `
  -PolicyParameterObject @{ listOfAllowedLocations = @("uksouth") }
```

Test a non-compliant virtual network deployment:

```powershell
New-AzVirtualNetwork `
  -Name "demoVNet1" `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Location "East US" `
  -AddressPrefix "10.1.0.0/16"
```

Test a compliant virtual network deployment:

```powershell
New-AzVirtualNetwork `
  -Name "demoVNet1" `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Location "UK South" `
  -AddressPrefix "10.1.0.0/16"
```

View policy assignments:

```powershell
Get-AzPolicyAssignment -Scope "/subscriptions/<subscription-id>/resourceGroups/rg_eastus_XXXXX"
```

---

## Implementation Walkthrough

The lab demonstrated how Azure Policy enforces governance controls at the resource group scope.

First, the built-in **Allowed locations** definition was selected from Azure Policy. It was then assigned to the target resource group with a single allowed region: **UK South**. Policy enforcement was left enabled so that Azure would actively block non-compliant deployments.

To test the assignment, a virtual network deployment was attempted in **East US**. Because the policy only allowed **UK South**, Azure denied the deployment. The same virtual network deployment was then attempted again in **UK South**, where it succeeded.

This demonstrated that Azure Policy can enforce location-based governance without requiring manual review of each deployment.

---

## Results & Validation

| Test | Result |
|---|---|
| Located built-in Allowed locations policy | Successful |
| Assigned policy to resource group | Successful |
| Set allowed region to UK South | Successful |
| Deployment attempt in East US | Blocked |
| Deployment attempt in UK South | Successful |

Key observations:

- Azure Policy can block resource deployments that violate defined rules
- The enforcement happened at the **resource group scope**
- Non-compliant resources were denied even though the create workflow was initiated
- Compliant resources deployed successfully without additional changes

---

## Validation Walkthrough

1. Verified that the **Allowed locations** built-in policy definition was available in Azure Policy.
2. Assigned the policy to the target resource group.
3. Configured the allowed location parameter to **UK South**.
4. Confirmed policy enforcement was enabled.
5. Attempted to create a virtual network in **East US**.
6. Verified the deployment failed due to policy restriction.
7. Repeated the deployment using **UK South**.
8. Confirmed the virtual network was created successfully.

---

## Real-World Use Case

Azure Policy is widely used in organizations that must enforce **data residency**, **regulatory compliance**, or **internal governance standards**.

Example: **Regional Compliance Enforcement**

| Requirement | Policy Action |
|---|---|
| Only approved regions may be used | Restrict deployments by location |
| Sensitive workloads must remain in one geography | Enforce allowed location list |
| Teams must not deploy outside approved regions | Deny non-compliant resources |

Typical workflow:

```text
Governance Team Defines Approved Regions
            ↓
Azure Policy Assignment Applied
            ↓
Non-Compliant Deployments Blocked
            ↓
Compliant Resources Deploy Successfully
```

This approach helps organizations maintain consistent governance without depending only on manual review processes.

---

## Key Takeaways

This lab demonstrated several important Azure governance concepts:

- Azure Policy can enforce compliance through built-in or custom policy definitions
- The **Allowed locations** policy restricts where resources can be deployed
- Policy assignments can be scoped to a resource group for targeted governance
- Non-compliant deployments are automatically denied when enforcement is enabled
- Azure Policy helps organizations support compliance, governance, and operational consistency

Understanding Azure Policy is essential for cloud administrators, Azure engineers, and governance-focused teams responsible for controlling how resources are deployed across an Azure environment.

