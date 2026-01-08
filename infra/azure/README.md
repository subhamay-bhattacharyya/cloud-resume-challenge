# Azure Infrastructure

## 1. Overview

- Purpose of Azure IaC in this repo
- High-level architecture:
  - Management groups / subscriptions
  - Resource groups by environment

## 2. Prerequisites

- Azure subscription(s)
- Access to Azure AD (Entra ID) to create app registrations/service principals
- Terraform Cloud organization & workspaces (see root infra README)
- `az` CLI (for initial setup, if needed)

## 3. OIDC / Federated Credentials Setup: GitHub → Azure

### 3.1 Conceptual Overview

- Why federated credentials (no client secrets)
- Relationship between:
  - App Registration
  - Service Principal
  - Federated Credential (GitHub)

### 3.2 Create App Registration & Service Principal

- Naming conventions:
  - `terraform-github-dev`
- Permissions:
  - `Owner` or `Contributor` on target subscription(s)
  - RBAC assignments at subscription/resource group level

### 3.3 Configure Federated Credentials

- Add federated credentials for GitHub:
  - Define issuer (GitHub)
  - Subject (repo, branch, workflow)
- Recommended patterns:
  - One app per environment vs. shared app

### 3.4 GitHub Actions Configuration

- Using `azure/login` with `client-id`, `tenant-id`, `subscription-id`
- Required GitHub `permissions` block (id-token, contents)

## 4. Azure Subscription & Environment Layout

- Subscription strategy:
  - Single subscription, multiple RGs
  - Or multiple subscriptions per environment
- Resource group naming conventions:
  - `rg-<app>-dev`
  - `rg-<app>-prod`
- Tagging standards:
  - `Environment`, `Application`, `Owner`, `CostCenter`

## 5. Terraform Configuration for Azure

### 5.1 Backend & Workspaces

- Terraform Cloud workspace name mapping for Azure
- `backend.tf` example for Azure stacks

### 5.2 Providers & Authentication

- `azurerm` provider configuration:
  - `features {}`
  - Subscription ID, tenant ID
- Auth via OIDC & federated credentials

### 5.3 Resource Organization Patterns

- Recommended module layout for:
  - Resource groups
  - Networking (vnets/subnets)
  - Key Vault
  - App services / AKS (if applicable)

## 6. Core Modules & Stacks

- `modules/network/`
- `modules/rg/`
- `modules/aks/` *(if applicable)*
- `environments/dev/`, `environments/prod/` stacks

Include for each:
- Inputs
- Outputs
- Dependencies

## 7. Running Terraform for Azure

### 7.1 From DevContainer / Locally

- Commands:
  - `terraform init`
  - `terraform plan`
  - `terraform apply`
- Environment selection via workspace / variables

### 7.2 From GitHub Actions

- Reusable workflow usage & example
- Required secrets/variables:
  - `AZURE_TENANT_ID`
  - `AZURE_SUBSCRIPTION_ID_DEV`
  - `AZURE_CLIENT_ID_DEV` (App registration)

## 8. 🔐 GitHub → Azure OIDC from Scratch — Step by Step

---

## Prerequisites

- Azure CLI `>= 2.45.0`
- Entra ID permissions:
  - **Application Administrator** (or higher)
  - Permission to assign Azure RBAC roles
- GitHub Actions enabled

---

## Variables Used

Update once and reuse throughout:

```powershell
$TENANT_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
$SUBSCRIPTION_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

$APP_NAME="github-oidc"
$GITHUB_ORG="subhamay-bhattacharyya"

$ISSUER="https://token.actions.githubusercontent.com"
$AUDIENCE="api://AzureADTokenExchange"
```

This section recreates GitHub OIDC authentication **from a clean slate**, starting with a **new Azure Entra App Registration** and ending with a **scalable OIDC setup** that supports **any repository / any branch** in a GitHub organization.

### Step 8.1 — Login to Azure

```powershell
az cloud set --name AzureCloud
az login --tenant $TENANT_ID
az account set --subscription $SUBSCRIPTION_ID

az account show --query "{tenantId:tenantId, subscriptionId:id, user:user.name}" -o table
```

### Step 8.2 - Create a New App Registration

```powershell
$CLIENT_ID = az ad app create `
  --display-name $APP_NAME `
  --query appId -o tsv

$CLIENT_ID
```
➡️ Save this value as AZURE_CLIENT_ID.

### Step 8.3 - Get the Application Object ID

```powershell
$APP_OBJECT_ID = az ad app show `
  --id $CLIENT_ID `
  --query id -o tsv

$APP_OBJECT_ID
```

### Step 8.4 - Create the Service Principal (Enterprise App)

```powershell
az ad sp create --id $CLIENT_ID

$SP_OBJECT_ID = az ad sp show `
  --id $CLIENT_ID `
  --query id -o tsv

$SP_OBJECT_ID
```

### Step 8.5 - Assign Azure RBAC Permissions

```powershell
$SCOPE="/subscriptions/$SUBSCRIPTION_ID"

az role assignment create `
  --assignee-object-id $SP_OBJECT_ID `
  --assignee-principal-type ServicePrincipal `
  --role "Contributor" `
  --scope $SCOPE
```

> 💡 Verify:

```powershell

az role assignment list `
  --assignee-object-id $SP_OBJECT_ID `
  --all -o table
```

### Step 8.6 - Ensure No Classic Federated Credentials Exist

```powershell
az ad app federated-credential list --id $CLIENT_ID -o table
```

> 💡 If any exist, delete them:
```powershell
$classicIds = az ad app federated-credential list `
  --id $CLIENT_ID `
  --query "[].id" -o tsv

foreach ($id in $classicIds) {
  az ad app federated-credential delete `
    --id $CLIENT_ID `
    --federated-credential-id $id
}
```

### Step 8.7 - Create Scalable GitHub OIDC Trust (Flexible Federated Credential)
```powershell
$expression = "claims['sub'] matches 'repo:$GITHUB_ORG/*:ref:refs/heads/*'"
```

> 💡 Create Flexible Federated Identity Credential

```powershell
$body = @{
  name      = "github-any-repo-any-branch"
  issuer    = $ISSUER
  audiences = @($AUDIENCE)
  claimsMatchingExpression = @{
    value           = $expression
    languageVersion = 1
  }
} | ConvertTo-Json -Depth 10

az rest `
  --method POST `
  --uri "https://graph.microsoft.com/beta/applications/$APP_OBJECT_ID/federatedIdentityCredentials" `
  --headers "Content-Type=application/json" `
  --body $body
```

### Step 8.8 - Verify Federated Identity Credentials

```powershell
az rest `
  --method GET `
  --uri "https://graph.microsoft.com/beta/applications/$APP_OBJECT_ID/federatedIdentityCredentials" `
  -o jsonc
```

### Step 8.9 - Create repository secrets 
- Create three repository secrets named `AZURE_CLIENT_ID`, `AZURE_SUBSCRIPTION_ID` and `AZURE_TENANT_ID` with the values from the steps above.

---


## 9. Operational Notes

- How to add new resource groups/subscriptions with Terraform
- How to rotate app registrations / federated credentials
- Troubleshooting Azure login / OIDC issues
