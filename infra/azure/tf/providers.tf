# --- root/azure/tf/providers.tf ---

terraform {
  required_version = ">= 1.14.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.55.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.azure_subscription_id

  # Use service principal authentication (via environment variables)
  # Set these in Terraform Cloud or as environment variables:
  # - ARM_CLIENT_ID
  # - ARM_CLIENT_SECRET
  # - ARM_TENANT_ID
  # Or use OIDC authentication with:
  # - ARM_USE_OIDC=true
  # - ARM_OIDC_TOKEN

  # use_cli         = false  # Disable Azure CLI authentication
  # use_oidc        = true   # Enable OIDC authentication (recommended for GitHub Actions)

  features {}
}

provider "random" {
  # Configuration options (if any) for the random provider
}
