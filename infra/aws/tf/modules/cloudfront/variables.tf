# --- root/aws/tf/modules/cloudfront/variables.tf ---
variable "cloudfront-distribution" {
  description = "Cloudfront distribution configuration"
  type        = any
}

variable "project-name" {
  description = "name of the project"
  type        = string
  default     = "CRC"
}

