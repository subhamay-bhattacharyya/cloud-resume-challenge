# --- root/gcp/tf/variables.tf ---

# GCP Project ID
variable "gcp_project_id" {
  description = "The GCP Project ID where resources will be created."
  type        = string
}
# GCP Region
variable "gcp_region" {
  description = "The GCP region where resources will be created."
  type        = string
}

# GCP Zone
variable "gcp_zone" {
  description = "The GCP zone where resources will be created."
  type        = string
}

# variable "project_name" {
#   description = "name of the project"
#   type        = string
#   default     = "crc"
# }
# variable "environment" {
#   description = "The project short name to be used in the resource name prefix"
#   type        = string
#   default     = "devl"
#   validation {
#     condition     = contains(["devl", "test", "prod"], var.environment)
#     error_message = "The environment must be one of: devl, test, prod."
#   }
# }
