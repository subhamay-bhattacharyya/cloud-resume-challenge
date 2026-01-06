# --- root/aws/tf/modules/iam/variables.tf ---

variable "lambda_role" {
  description = "IAM Role and Policy configuration for Lambda Get Function"
  type        = any
}