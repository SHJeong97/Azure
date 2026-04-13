# Azure Key Vault Key and Secret Management with PowerShell

## Introduction

Azure Key Vault is a managed Azure service designed to securely store and control access to sensitive data such as cryptographic keys, secrets, and certificates. It helps organizations centralize sensitive asset management instead of storing secrets directly in scripts, applications, or configuration files.

In this lab, an Azure Key Vault was created using the **vault access policy** permission model. A cryptographic key and a secret were then created inside the vault. Finally, Azure Cloud Shell PowerShell was used to retrieve the key identifier URL, demonstrating how administrators and automation workflows can access Key Vault objects programmatically.

## Objectives

The objectives of this lab were to:

- Create a new Azure Key Vault
- Configure the vault to use the **vault access policy** permission model
- Create a cryptographic key inside the vault
- Create a secret inside the vault
- Open Azure Cloud Shell in PowerShell mode
- Retrieve the key properties using PowerShell
- Display the key identifier URL from Azure Key Vault

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
                    | Azure Key   |
                    | Vault       |
                    | <vaultname> |
                    +------+------+
                           |
             +-------------+-------------+
             |                           |
      +------+-------+           +-------+------+
      | Key Object   |           | Secret Object|
      | DemoKey      |           | DemoSecret   |
      +------+-------+           +-------+------+
             |                           |
             +-------------+-------------+
                           |
                  Azure Cloud Shell
                     PowerShell
                           |
             Get-AzureKeyVaultKey / echo
```

This architecture shows Azure Key Vault storing both a key and a secret, while Azure Cloud Shell PowerShell is used to retrieve the key metadata and display the key identifier URL. 

## Full Implementation

### Step 1 — Sign in to Azure Portal

Navigate to the Azure Portal:

```text
https://portal.azure.com
```

Sign in using the provided lab credentials.

Using an incognito browser session is recommended to avoid Azure portal cache issues. 

### Step 2 — Create a New Azure Key Vault

Navigate to:

```text
Create a resource → Key Vault
```

Configure the vault with:

| Setting | Value |
|---|---|
| Resource Group | rg_eastus_XXXXX |
| Key Vault Name | Unique name |
| Permission Model | Vault access policy |
| Access Policies | Current username selected |

Leave the remaining options at their default values, then review and create the Key Vault. 
<img width="1331" height="1711" alt="image" src="https://github.com/user-attachments/assets/6109f706-57a3-4087-b482-d2d63ae9fede" />


### Step 3 — Create a New Key

After deployment completes, open the Key Vault and navigate to:

```text
Objects → Keys → Generate/Import
```

Create the key with:

| Setting | Value |
|---|---|
| Name | DemoKey |

Leave the other settings at default and create the key.
<img width="1220" height="1280" alt="image" src="https://github.com/user-attachments/assets/bcc075e4-e6b6-4106-8462-84088543cf5b" />


### Step 4 — Create a New Secret

In the same Key Vault, navigate to:

```text
Objects → Secrets → Generate/Import
```

Create the secret with:

| Setting | Value |
|---|---|
| Name | DemoSecret |
| Value | Demo@123 |

Create the secret.
<img width="1036" height="655" alt="image" src="https://github.com/user-attachments/assets/40b53805-6967-44b9-888e-f45100ebd2a2" />


### Step 5 — Access Key Properties via PowerShell

Open **Cloud Shell** and select **PowerShell**.

Select subscription:

```text
PAYG-Labs2
```

Change to the Azure drive:

```powershell
cd Azure:/
```

Define the key name:

```powershell
$keyEncryptionKeyName="DemoKey"
```

Retrieve the Key Vault key identifier:

```powershell
$keyEncryptionKeyUrl = (Get-AzureKeyVaultKey -VaultName "<your vault name>" -Name $keyEncryptionKeyName).Key.kid
```

Display the key URL:

```powershell
echo $keyEncryptionKeyUrl
```

This returns the key identifier URL for the stored key object. 

<img width="1523" height="225" alt="image" src="https://github.com/user-attachments/assets/ed982411-939c-4c79-a38d-2dbb0a3f15ad" />
<img width="1523" height="130" alt="image" src="https://github.com/user-attachments/assets/f657bfcf-d897-4374-9feb-9285e92c403b" />
<img width="1523" height="172" alt="image" src="https://github.com/user-attachments/assets/a1fc3e49-37c5-4b47-9cc7-82eb7d4dfdf4" />



### Azure CLI (Bash)

Create the Key Vault:

```bash
az keyvault create \
  --name mykeyvaultdemo123 \
  --resource-group rg_eastus_XXXXX \
  --location eastus
```

Create the key:

```bash
az keyvault key create \
  --vault-name mykeyvaultdemo123 \
  --name DemoKey \
  --protection software
```

Create the secret:

```bash
az keyvault secret set \
  --vault-name mykeyvaultdemo123 \
  --name DemoSecret \
  --value "Demo@123"
```

Show the key identifier:

```bash
az keyvault key show \
  --vault-name mykeyvaultdemo123 \
  --name DemoKey \
  --query key.kid \
  --output tsv
```

Show the secret metadata:

```bash
az keyvault secret show \
  --vault-name mykeyvaultdemo123 \
  --name DemoSecret
```

### Azure PowerShell

Create the Key Vault:

```powershell
New-AzKeyVault `
  -Name "mykeyvaultdemo123" `
  -ResourceGroupName "rg_eastus_XXXXX" `
  -Location "East US"
```

Create the key:

```powershell
Add-AzKeyVaultKey `
  -VaultName "mykeyvaultdemo123" `
  -Name "DemoKey" `
  -Destination "Software"
```

Create the secret:

```powershell
$secretValue = ConvertTo-SecureString "Demo@123" -AsPlainText -Force

Set-AzKeyVaultSecret `
  -VaultName "mykeyvaultdemo123" `
  -Name "DemoSecret" `
  -SecretValue $secretValue
```

Retrieve the key URL:

```powershell
$key = Get-AzKeyVaultKey `
  -VaultName "mykeyvaultdemo123" `
  -Name "DemoKey"

$key.Key.Kid
```

Retrieve the secret:

```powershell
Get-AzKeyVaultSecret `
  -VaultName "mykeyvaultdemo123" `
  -Name "DemoSecret"
```

## Implementation Walkthrough

The lab began by deploying an Azure Key Vault inside the assigned resource group. During creation, the vault was configured to use the **vault access policy** permission model and the current user was granted access through access policies. This ensured that the administrator could create and retrieve Key Vault objects after deployment. 

After the vault was provisioned, two types of objects were created inside it: a cryptographic key named `DemoKey` and a secret named `DemoSecret`. This demonstrated that Key Vault can store both encryption-related objects and application-sensitive values within the same managed service. 

Finally, Azure Cloud Shell PowerShell was used to access the vault programmatically. The key name was assigned to a variable, `Get-AzureKeyVaultKey` was executed, and the key identifier URL was returned using `.Key.kid`. This showed how Azure administrators and automation scripts can interact with Key Vault without manually copying values from the portal. 

## Results & Validation

| Test | Result |
|---|---|
| Key Vault deployment | Successful |
| Vault access policy configuration | Successful |
| Key creation (`DemoKey`) | Successful |
| Secret creation (`DemoSecret`) | Successful |
| Cloud Shell PowerShell launch | Successful |
| Key identifier retrieval | Successful |

Key observations:

- Azure Key Vault centralized the storage of both a key and a secret
- The vault access policy model allowed the configured user to manage vault objects
- PowerShell successfully retrieved the key identifier URL
- Programmatic access is useful for automation and secure integration workflows

## Validation Walkthrough

1. Verified that the Azure Key Vault was created successfully in `rg_eastus_XXXXX`.
2. Confirmed the vault used the **vault access policy** permission model.
3. Opened the **Keys** blade and created `DemoKey`.
4. Opened the **Secrets** blade and created `DemoSecret`.
5. Launched Azure Cloud Shell in **PowerShell** mode.
6. Changed to the Azure drive using `cd Azure:/`.
7. Defined the variable `$keyEncryptionKeyName="DemoKey"`.
8. Ran `Get-AzureKeyVaultKey` to retrieve the key metadata.
9. Used `echo $keyEncryptionKeyUrl` to display the key identifier URL.
10. Confirmed that the command returned a valid Key Vault key URL.

## Real-World Use Case

Azure Key Vault is commonly used to protect sensitive values and cryptographic assets in production environments.

Example: **Application Secret and Key Management**

| Component | Role |
|---|---|
| Azure Key Vault | Central secure storage |
| Key (`DemoKey`) | Encryption or key management |
| Secret (`DemoSecret`) | Password, token, or app secret |
| Cloud Shell / Automation | Retrieval and administration |

Typical workflow:

```text
Application or Admin Needs Secret/Key
                ↓
Requests Object from Azure Key Vault
                ↓
Azure Access Policy / Permissions Evaluated
                ↓
Key or Secret Returned Securely
```

This design reduces the need to hardcode secrets into scripts or applications and supports more secure operational practices.

## Key Takeaways

This lab demonstrated several important Azure security and administration concepts:

- Azure Key Vault securely stores keys and secrets in a centralized service
- The **vault access policy** model controls who can manage vault objects
- Keys and secrets serve different purposes but can be managed in the same vault
- Azure Cloud Shell PowerShell can retrieve Key Vault object properties programmatically
- Key Vault improves security by reducing direct exposure of sensitive values in scripts and applications

Understanding Azure Key Vault is essential for cloud administrators, security engineers, and DevOps teams responsible for protecting secrets and cryptographic assets in Azure environments.

