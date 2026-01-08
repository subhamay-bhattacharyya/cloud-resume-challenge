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

## 8. 🔐 Azure OIDC for GitHub Actions — Step by Step
- #### Architecture (1-liner)

  GitHub issues an OIDC token → Azure validates it via a Federated Credential → Azure AD issues an access token → GitHub Action accesses Azure.

  > STEP 1️⃣ Login to Azure and select subscription
  ```bash
  az login
  az account set --subscription "<SUBSCRIPTION_ID>"
  ```


  > ⚠️ **Verify:**
  ```bash
  az account show --query "{subscription:id, tenant:tenantId}" -o table
  ```

  > STEP 2️⃣ Create an Azure AD App Registration
  ```bash
  APP_NAME="github-oidc-app"

  az ad app create \
    --display-name "$APP_NAME"
  ```

  > ⚠️ **Get the Application (Client) ID:**
  ```baah
    AZURE_CLIENT_ID=$(az ad app list \
      --display-name "$APP_NAME" \
      --query "[0].appId" -o tsv)

    echo $AZURE_CLIENT_ID
  ```

  > STEP 3️⃣ Create a Service Principal for the App
  ```bash
  az ad sp create --id "$AZURE_CLIENT_ID"
  ```

  > STEP 4️⃣ Assign Azure RBAC role (least privilege)

  **Example: Storage Blob Contributor (adjust as needed)**
  ```bash
    SUBSCRIPTION_ID=$(az account show --query id -o tsv)

    az role assignment create \
      --assignee "$AZURE_CLIENT_ID" \
      --role "Contributor" \
      --scope "/subscriptions/$SUBSCRIPTION_ID"
  ```

  🔒 For production, scope this to:
  - Resource Group
  - Storage Account
  - Specific service

  > STEP 5️⃣ Create the Federated Credential (OIDC trust)

  > *⚠️ *This is the most important step.**
  ```bash
    $PARAMS=@"
    {
      "name": "github-any-repo-any-branch",
      "issuer": "https://token.actions.githubusercontent.com",
      "subject": "repo:subhamay-bhattacharyya/*:ref:refs/heads/*",
      "audiences": ["api://AzureADTokenExchange"]
    }
    "@

    az ad app federated-credential create --id $CLIENT_ID --parameters $PARAMS
  ```

  > 🔎 What this means
  Field	Value
  issuer	GitHub OIDC issuer
  subject	Restricts access to repo + branch
  audience	Required by Azure

  > 📌 You can loosen this if needed:

  `repo:subhamay-bhattacharyya/cloud-resume-challenge:*`>

  > STEP 6️⃣ Collect required values for GitHub
  ```bash
  AZURE_TENANT_ID=$(az account show --query tenantId -o tsv)
  AZURE_SUBSCRIPTION_ID=$(az account show --query id -o tsv)

  echo "CLIENT_ID=$AZURE_CLIENT_ID"
  echo "TENANT_ID=$AZURE_TENANT_ID"
  echo "SUBSCRIPTION_ID=$AZURE_SUBSCRIPTION_ID"
  ```

> STEP 7️⃣ Add GitHub Secrets

**In GitHub → Repo → Settings → Secrets → Actions, add:**

  >> 💁🏼 **Secret Name	Value**
  - AZURE_CLIENT_ID	App (client) ID
  - AZURE_TENANT_ID	Tenant ID
  - AZURE_SUBSCRIPTION_ID	Subscription ID**

  >> Note 📝
  - ❌ Do NOT add client secret
  - ❌ Do NOT add password

## 9. Operational Notes

- How to add new resource groups/subscriptions with Terraform
- How to rotate app registrations / federated credentials
- Troubleshooting Azure login / OIDC issues
