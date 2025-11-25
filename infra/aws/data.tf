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

# # --- root/data.tf ---

# # AWS Region and Caller Identity
# data "aws_region" "current" {}

# data "aws_caller_identity" "current" {}

# # AWS Managed Prefix List
# data "aws_ec2_managed_prefix_list" "s3_vpce_prefix_list" {
#   name = "com.amazonaws.${data.aws_region.current.name}.s3"
# }