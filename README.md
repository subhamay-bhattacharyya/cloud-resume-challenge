# infra/README.md

## 1. Overview

- **Purpose**
  - Centralized infrastructure IaC for all cloud providers (AWS, GCP, Azure)
  - Managed via Terraform with HashiCorp Cloud (Terraform Cloud)
- **Repo Structure (infra)**
  - `aws/` – AWS-specific Terraform modules and stacks
  - `gcp/` – GCP-specific Terraform modules and stacks
  - `azure/` – Azure-specific Terraform modules and stacks
  - `.devcontainer/` – Dev container configuration for infra development
  - `frontenv/` – Conatins the HTML codes for the Resume

## 2. Prerequisites

- **Accounts/Access**
  - GitHub account with access to this monorepo
  - HashiCorp Cloud (Terraform Cloud) account
  - AWS, GCP, and Azure accounts with sufficient permissions (per-provider docs in subfolders)
<!-- - **Local Tooling (if not using devcontainer)**
  - `git`
  - `terraform` (version X.Y.Z)
  - `tfc-agent` *(if applicable)*
  - `docker` / `docker desktop` (for devcontainer) -->

## 3. HashiCorp Cloud / Terraform Cloud Setup

### 3.1 Create Terraform Cloud Organization & Projects

- Steps (high-level):
  - Create **organization**
    ![](infra/assets/images/terraform-cloud-create-org.jpg)

  - Create **project**
    ![](infra/assets/images/terraform-cloud-create-project.jpg)
  
  - Create **workspaces** per cloud environment:
    - `cloud-resume-challenge-aws`
    - `cloud-resume-challenge-gcp`
    - `cloud-resume-challengeazure`
    ![](infra/assets/images/terraform-cloud-create-workspaces.jpg)

  - Set **execution mode** to `Local`
    ![](infra/assets/images/terraform-cloud-workspace-execution-mode.jpg)

  - Create **API Token** to be used in GitHub Codespace and GitHub Action

    ![](infra/assets/images/terraform-cloud-generate-api-token.jpg)

    ![](infra/assets/images/terraform-cloud-api-token.jpg)
### 3.2 Workspaces & Remote Backend Configuration

- Standard naming conventions for workspaces
- Backend block structure (example):
  - Organization name
  - Workspace name
- Reference to per-provider backend examples:
  - AWS: `aws/backend.tf`
  - GCP: `gcp/backend.tf`
  - Azure: `azure/backend.tf`

### 3.3 Terraform Cloud API Tokens

- **User API Token** vs **Team/Org Token**
- Where tokens are used:
  - Devcontainer integration
  - GitHub Actions CI/CD
- Token storage locations (never commit to git):
  - GitHub Secrets (e.g. `TFC_TOKEN`)
  - Devcontainer env variables / `.env` (not committed)
  - Local OS keychain *(optional)*

## 4. DevContainer Setup (Recommended)

### 4.1 DevContainer Overview

- Location: `.devcontainer/`
- Base image & tools:
  - Terraform, Terraform-docs
  - AWS/GCP/Azure CLIs
  - `tflint`, `checkov`, `infracost` *(if applicable)*

### 4.2 How to Open in DevContainer

- Steps:
  - Clone repo
  - Open in VS Code
  - Reopen in container (Dev Containers extension)
- First-run expectations:
  - Automatic installation of tools
  - Automatic loading of Terraform Cloud token (if configured)

### 4.3 Configuring Terraform Cloud Token in DevContainer

- Using `.devcontainer/devcontainer.json` and `.env` file
- Example:
  - `TFC_TOKEN=***` in `.env` or GitHub Codespaces secrets
- Security notes:
  - Never commit `.env`
  - Use Codespaces secrets in GitHub for shared cloud dev

## 5. Secret Management

### 5.1 Secret Types

- Terraform Cloud:
  - `TFC_TOKEN`
- Cloud Providers:
  - AWS: Access keys (if used), role ARNs, account IDs
  - GCP: Service account emails, project IDs
  - Azure: Tenant ID, Subscription ID, Client ID

### 5.2 Where Secrets Live

- **GitHub Actions**
  - `TFC_TOKEN`
  - `AWS_ROLE_TO_ASSUME`, `AWS_ACCOUNT_ID`
  - `GCP_PROJECT_ID`, `GCP_WIF_POOL_ID`, etc.
  - `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID`, etc.
- **Terraform Cloud Workspace Variables**
  - Per-environment variables (e.g. `TF_VAR_environment`)
  - Provider credentials (if not purely OIDC)

### 5.3 Secret Naming Conventions

- Prefix conventions:
  - `AWS_...`
  - `GCP_...`
  - `AZURE_...`
  - `TFC_...`
- Environment-specific suffixes:
  - `_DEV`, `_STG`, `_PROD`

## 6. Common Terraform Project Layout & Standards

### 6.1 Folder & Module Structure

- `environments/` (optional) – environment-level stacks
- `modules/` – reusable modules per cloud
- `main.tf`, `variables.tf`, `outputs.tf`, `providers.tf`

### 6.2 Code Quality & Policies

- Formatting & linting:
  - `terraform fmt`
  - `tflint`
- Security & policy:
  - `checkov` / `tfsec`
  - Sentinel / OPA policies *(if using)*

## 7. GitHub Actions / CI-CD Overview (Infra)

- High-level description:
  - Reusable workflows for `plan` / `apply`
- Triggers:
  - PR (plan)
  - Merge to main (apply)
- Common environment variables and inputs:
  - `cloud_provider` (aws/gcp/azure)
  - `environment` (dev/stg/prod)

## 8. Per-Cloud Documentation

- See:
  - [`aws/README.md`](./aws/README.md)
  - [`gcp/README.md`](./gcp/README.md)
  - [`azure/README.md`](./azure/README.md)
