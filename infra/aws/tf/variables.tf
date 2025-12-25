# --- root/aws/tf/root/variables.tf ---

variable "aws-region" {
  type    = string
  default = "us-east-1"
}
######################################## Project Name ##############################################
variable "project-name" {
  description = "The name of the project"
  type        = string
  default     = "Cloud Resume Challenge"
}

####################################### S3 Bucket Configuration ##########################################
