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

# --- root/variables.tf ---

# GCP Project ID
variable "gcp-project-id" {
  description = "The GCP Project ID where resources will be created."
  type        = string
}
# GCP Region
variable "gcp-region" {
  description = "The GCP region where resources will be created."
  type        = string
  default     = "us-central1"
}