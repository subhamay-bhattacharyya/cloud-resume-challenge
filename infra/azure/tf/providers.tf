# --- root/azure/tf/providers.tf ---

terraform {
  required_version = ">= 1.14.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.55.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.0"
    }
  }
}


provider "azurerm" {
  subscription_id = var.azure_subscription_id
  features {}
}

provider "random" {
  # Configuration options (if any) for the random provider
}
