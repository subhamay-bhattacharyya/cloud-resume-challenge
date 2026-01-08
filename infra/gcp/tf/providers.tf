# --- root/gcp/tf/providers.tf ---

terraform {
  required_version = ">= 1.11.0" # Adjust as needed for your environment

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0.0"
    }
  }
}

# Configure the Google Cloud Provider
provider "google" {
  # credentials = file("tf-sa-key/terraform-sa-key.json")
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}
