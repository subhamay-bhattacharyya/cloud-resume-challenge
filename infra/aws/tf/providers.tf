# --- root/providers.tf ---

terraform {
  required_version = ">= 1.8.4" # Adjust as needed for your environment

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 1.12.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws-region
  # default_tags {
  #   tags = local.tags
  # }
}
