# --- root/aws/tf/modules/dynamodb/outputs.tf ---

output "dynamodb-table-name" {
  description = "Name of the DynamoDB table"
  value       = aws_dynamodb_table.this.name
}

output "dynamodb-table-arn" {
  description = "ARN of the DynamoDB table"
  value       = aws_dynamodb_table.this.arn
}

output "dynamodb-table-id" {
  description = "ID of the DynamoDB table"
  value       = aws_dynamodb_table.this.id
}

output "dynamodb-pitr-status" {
  description = "Point-in-Time Recovery status"
  value       = aws_dynamodb_table.this.point_in_time_recovery[0].enabled
}