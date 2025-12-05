# AWS Infrastructure

## 1. Overview

- Purpose of AWS IaC in this repo
- High-level architecture:
  - Accounts (e.g. `dev`, `stg`, `prod`)
  - Core resources (VPC, subnets, IAM, etc.)

## 2. Prerequisites

- AWS account(s) with appropriate permissions
- AWS IAM admin or infra role
- Terraform Cloud organization & workspaces (see root infra README)

## 3. OIDC Setup: GitHub → AWS

### 3.1 Design Overview

- Why OIDC (no long-lived access keys)
- Trust relationships:
  - GitHub OIDC provider
  - AWS IAM roles

### 3.2 Create IAM OIDC Identity Provider

- URL & thumbprint (GitHub)
- Audience (e.g. `sts.amazonaws.com`)

### 3.3 IAM Role for GitHub Actions

- Trust policy:
  - Conditions on `sub` (repo, env)
- Recommended role naming and path conventions
- Example mapping:
  - `role/github-aws-infra-dev`
  - `role/github-aws-infra-prod`

### 3.4 GitHub Actions Configuration

- Required GitHub `permissions` block (id-token, contents)
- Example workflow snippet for `aws-actions/configure-aws-credentials`

## 4. AWS Account & Environment Layout

- Account strategy:
  - Single account w/ multiple environments
  - Or multi-account setup (Org)
- Naming conventions:
  - `aws-dev`, `aws-stg`, `aws-prod`
- Tags/labels standards:
  - `Environment`, `Owner`, `CostCenter`, `Application`

## 5. Terraform Configuration for AWS

### 5.1 Backend & Workspaces

- Reference to Terraform Cloud workspace names
- `backend.tf` example:
  - Organization
  - Workspace

### 5.2 Providers & Authentication

- `aws` provider config:
  - Region
  - Assume role via OIDC
- Multiple accounts/aliases (if applicable)

### 5.3 State & Locking

- Remote state in Terraform Cloud
- Locking behavior and concurrency

## 6. Core Modules & Stacks

- `modules/network/`
- `modules/iam/`
- `modules/eks/` *(if applicable)*
- `environments/dev/`, `environments/prod/` stacks

Include for each:
- Input variables (high-level)
- Outputs (high-level)
- Dependencies between modules

## 7. Running Terraform for AWS

### 7.1 From DevContainer / Locally

- Commands:
  - `terraform init`
  - `terraform plan`
  - `terraform apply`
- Environment selection (workspaces, variables)

### 7.2 From GitHub Actions

- Reusable workflow usage:
  - Inputs (environment, directory path)
  - Required secrets:
    - `AWS_ACCOUNT_ID_DEV`, `AWS_ROLE_ARN_DEV`, etc.

## 8. Operational Notes

- How to rotate roles/permissions
- How to add new AWS regions or accounts
- Troubleshooting common OIDC / IAM issues
