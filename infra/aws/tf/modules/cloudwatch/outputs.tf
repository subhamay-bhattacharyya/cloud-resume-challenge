# --- root/aws/tf/modules/cloudwatch/outputs.tf ---

output "log_group_arn" {
  description = "The ARN of the Cloudwatch log group"
  value       = aws_cloudwatch_log_group.this.arn
}

output "log_group_name" {
  description = "The name of the Cloudwatch log group"
  value       = aws_cloudwatch_log_group.this.name
}
