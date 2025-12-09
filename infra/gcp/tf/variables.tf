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
}

# GCP Zone
variable "gcp-zone" {
  description = "The GCP zone where resources will be created."
  type        = string
}


variable "google-storage-bucket-name" {
  description = "The name of the Google Storage bucket"
  type        = string
}