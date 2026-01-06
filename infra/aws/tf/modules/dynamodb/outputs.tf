# --- root/aws/tf/modules/dynamodb/outputs.tf ---

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  value       = aws_dynamodb_table.this.name
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table"
  value       = aws_dynamodb_table.this.arn
}

output "dynamodb_table_id" {
  description = "ID of the DynamoDB table"
  value       = aws_dynamodb_table.this.id
}

output "dynamodb_pitr_status" {
  description = "Point-in-Time Recovery status"
  value       = aws_dynamodb_table.this.point_in_time_recovery[0].enabled
}