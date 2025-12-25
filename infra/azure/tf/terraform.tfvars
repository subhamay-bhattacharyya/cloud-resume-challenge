# bucket-name      = "subhamay-tf-template-bucket-06611-143"
# project-name     = "gha-tmpl"
# environment-name = "devl"

# Azure Subscription ID
azure_subscription_id = "8ea2d3cf-0884-4fea-ab51-9b88f5644937"

## Uncomment the following lines to use S3 as the backend for Terraform state management when running locally.
## For GitHub Actions, the backend is configured in the workflow file.

# tf-state-bucket  = "subhamay-tf-state-637423502513-devl-us-east-1"az account show --query id -o tsv