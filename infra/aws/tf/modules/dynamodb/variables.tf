# --- root/aws/tf/modules/dynamodb/variables.tf ---

variable "dynamodb_table" {
  description = "DynamoDB table configuration"
  type        = map(any)
}
