# --- root/gcp/tf/providers.tf ---

terraform {
  required_version = ">= 1.11.0" # Adjust as needed for your environment

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 1.12.0"
    }
  }
}

# Configure the Azure Provider
provider "google" {
  credentials = file("tf-sa-key/terraform-sa-key.json")
  project     = var.gcp-project-id
  region      = var.gcp-region
  zone        = var.gcp-zone
}
