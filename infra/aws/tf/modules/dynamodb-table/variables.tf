# --- root/aws/tf/modules/dynamodb/variables.tf ---

variable "dynamodb-tables" {
  description = "DynamoDB tables configuration"
  type        = map(any)
}
