# --- root/aws/tf/root/variables.tf ---

variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "website_domain" {
  description = "The root domain name for Route53 hosted zone lookup"
  type        = string
  default     = "subhamay.us"
}
######################################## Project Name ##############################################
variable "project_name" {
  description = "name of the project"
  type        = string
  default     = "crc"
}
variable "environment" {
  description = "The project short name to be used in the resource name prefix"
  type        = string
  default     = "devl"
  validation {
    condition     = contains(["devl", "test", "prod"], var.environment)
    error_message = "The environment must be one of: devl, test, prod."
  }
}

######################################## Tags ######################################################
variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default = {
    Project = "Cloud Resume Challenge"
    Owner   = "Subhamay Bhattacharyya"
    Env     = "Dev"
  }
}