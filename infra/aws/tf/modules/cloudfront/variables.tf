# --- root/aws/tf/modules/cloudfront/variables.tf ---

variable "cloudfront_distribution" {
  description = "Cloudfront distribution configuration"
  type        = any
}

variable "project_name" {
  description = "name of the project"
  type        = string
  default     = "CRC"
}

