# --- root/gcp/tf/terraform.tfvars ---

gcp_project_id = "cloud-resume-challenge-06902"
gcp_region     = "us-east1"
gcp_zone       = "us-east1-a"
project_name   = "crc"
environment    = "devl"


# bucket-name      = "subhamay-tf-template-bucket-06611-143"
# project-name     = "gha-tmpl"
# environment-name = "devl"

## Uncomment the following lines to use S3 as the backend for Terraform state management when running locally.
## For GitHub Actions, the backend is configured in the workflow file.

# tf-state-bucket  = "subhamay-tf-state-637423502513-devl-us-east-1"