## =====================================================================================================================
## 📁 Project Name        : Terraform GitHub Template Repository
## 📝 Description         : A reusable template for setting up Terraform-based Infrastructure-as-Code (IaC) projects
##                         on GitHub using GitHub Actions for CI/CD automation.
##
## 🔄 Modification History:
##   Version   Date          Author     Description
##   -------   ------------  --------   -------------------------------------------------------------------------------
##   1.0.0     Jun 20, 2025  Subhamay   Initial version with GitHub Actions workflow for Terraform CI/CD
##
## =====================================================================================================================

# --- root/locals.tf ---

resource "random_string" "ci-build-string" {
  length  = 5
  upper   = false
  lower   = true
  numeric = false
  special = false
}

## Uncomment the following lines to use S3 as the backend for Terraform state management when running locally.
## For GitHub Actions, the backend is configured in the workflow file.
#locals {
# tf-state-key = "${var.project-name}/terraform.tfstate"
#}

locals {
  ci-build = var.ci-pipeline == "true" ? "-${random_string.ci-build-string.result}" : ""
}

locals {
  bucket-name = "${var.project-name}-${var.bucket-name}-${var.environment-name}${local.ci-build}"
}