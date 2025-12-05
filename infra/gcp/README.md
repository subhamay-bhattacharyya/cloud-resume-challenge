# Setup GCP Service Account

### 1. Admin Setup (Service Account + WIF + IAM Binding)
```mermaid
flowchart TD
  SA["1. Create Service Account"]
  WIP["2. Create Workload Identity Pool"]
  OIDCProv["3. Create OIDC Provider"]
  Bind["4. Add IAM Policy Binding roles/iam.workloadIdentityUser"]
  Roles["5. Grant IAM Roles to Service Account"]

  SA --> Roles
  SA --> Bind
  WIP --> OIDCProv
  WIP --> Bind
```

### 1.1 the Active GCP Project

```bash
gcloud config set project YOUR_PROJECT_ID
```
### 1.2  Create the Terraform Service Account

```bash
gcloud iam service-accounts create terraform-sa \
  --display-name="Terraform Service Account"
```

#### 1.3 Assign IAM Roles to the Service Account

```bash
gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
  --member="serviceAccount:terraform-sa@YOUR_PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/storage.admin"
```

###### 1.3.1 Grant read-only access across the project (Optional)

```bash
gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
  --member="serviceAccount:terraform-sa@YOUR_PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/viewer"
```

#### 1.4 Create and Download the Service Account JSON Key

```bash
gcloud iam service-accounts keys create terraform-sa-key.json \
  --iam-account="terraform-sa@YOUR_PROJECT_ID.iam.gserviceaccount.com"
```

#### 1.5 Configure Terraform to Use the Service Account

```bash
export GOOGLE_APPLICATION_CREDENTIALS="/absolute/path/to/terraform-sa-key.json"
```

## Future: Move from JSON Keys to Workload Identity Federation (OIDC)

<!-- In the future, to avoid long-lived JSON keys, this setup can be migrated to **Workload Identity Federation (WIF)** / OIDC:

1. **Create a Workload Identity Pool and Provider**  
   - Use `gcloud iam workload-identity-pools create`  
   - Then add a provider (e.g., GitHub Actions, GitLab, or another IdP).

2. **Allow the Pool to Impersonate the Terraform Service Account**  
   - Grant `roles/iam.workloadIdentityUser` on the service account to identities from the pool.

3. **Update Terraform Authentication**  
   - Remove `credentials = file("...")` and JSON keys.  
   - Use application default credentials / OIDC token from your CI (e.g., GitHub Actions) plus:
     ```hcl
     provider "google" {
       project  = "YOUR_PROJECT_ID"
       region   = "us-east4"

       impersonate_service_account = "terraform-sa@YOUR_PROJECT_ID.iam.gserviceaccount.com"
     }
     ```

4. **Delete Old JSON Keys**  
   - Once WIF is working, remove any `terraform-sa` JSON keys:
     ```bash
     gcloud iam service-accounts keys list \
       --iam-account="terraform-sa@YOUR_PROJECT_ID.iam.gserviceaccount.com"

     gcloud iam service-accounts keys delete KEY_ID \
       --iam-account="terraform-sa@YOUR_PROJECT_ID.iam.gserviceaccount.com"
     ``` -->

```mermaid
flowchart TD

  CI["1. CI/CD Pipeline (GitHub Actions)"]
  OIDCToken["2. OIDC Token Issued by GitHub"]
  Pool["3. Workload Identity Pool Validates Token"]
  Impersonation["4. Service Account Impersonation Allowed by IAM Binding"]
  Resources["5. Access GCP Resources (Example: GCS Buckets)"]

  CI --> OIDCToken
  OIDCToken --> Pool
  Pool --> Impersonation
  Impersonation --> Resources

```

## Configure Hashicorp Cloud for state management

## Create the Terraform config files

