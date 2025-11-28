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

# --- root/main.tf ---

resource "aws_s3_bucket" "s3_bucket" {
  bucket = local.bucket-name

  tags = {
    environment          = var.environment-name
    Owner                = "subhamay.aws@gmail.com"
    git_commit           = "6d168a8c28fa982f7527dde045a69499cca0dce5"
    git_file             = "tf/main.tf"
    git_last_modified_at = "2025-07-02 02:23:06"
    git_last_modified_by = "142895397+bsubhamay@users.noreply.github.com"
    git_modifiers        = "142895397+bsubhamay"
    git_org              = "subhamay-bhattacharyya"
    git_repo             = "terraform-template"
  }
}