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

## 8. Operational Notes

- How to add new resource groups/subscriptions with Terraform
- How to rotate app registrations / federated credentials
- Troubleshooting Azure login / OIDC issues
