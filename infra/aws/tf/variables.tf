# --- root/aws/tf/root/variables.tf ---

variable "aws-region" {
  type    = string
  default = "us-east-1"
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