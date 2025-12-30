# --- root/aws/tf/root/variables.tf ---

variable "aws-region" {
  type    = string
  default = "us-east-1"
}

variable "crc-domain-name" {
  description = "The domain name for the Cloud Resume Challenge website"
  type        = string
  default     = "abc.com"
}

######################################## Project Name ##############################################
variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default = {
    Project = "Cloud Resume Challenge"
    Owner   = "Subhamay Bhattacharyya"
    Env     = "Dev"
  }
}