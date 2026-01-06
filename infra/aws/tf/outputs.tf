# --- root/aws/tf/root/outputs.tf ---

############ ACM Certificate Outputs ######################
output "acm_certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = module.acm.acm_certificate_arn
}

############ S3 Bucket Outputs ############################
output "s3_bucket_name" {
  description = "S3 bucket name used for static website"
  value       = module.s3.s3_bucket_name
}
output "s3_bucket_region" {
  description = "S3 bucket region"
  value       = module.s3.s3_bucket_region
}
output "s3_bucket_arn" {
  description = "S3 bucket ARN"
  value       = module.s3.s3_bucket_arn
}
output "s3_bucket_domain_name" {
  description = "S3 bucket domain name"
  value       = module.s3.s3_bucket_domain_name
}
output "s3_bucket_regional_domain_name" {
  description = "The regional domain name of the bucket"
  value       = module.s3.s3_bucket_regional_domain_name
}

############ Cloudfront Outputs #############################
output "cloudfront_domain_name" {
  description = "The domain name corresponding to the CloudFront distribution."
  value       = module.cloudfront.cloudfront_domain_name
}
output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution."
  value       = module.cloudfront.cloudfront_distribution_id
}
output "cloudfront_distribution_arn" {
  description = "The ARN of the CloudFront distribution."
  value       = module.cloudfront.cloudfront_distribution_arn
}
output "cloudfront_hosted_zone_id" {
  description = "The Route 53 hosted zone ID for the CloudFront distribution."
  value       = module.cloudfront.cloudfront_hosted_zone_id
}

############ DynamoDB  Outputs ###############################
output "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  value       = module.dynamodb.dynamodb_table_name
}
output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table"
  value       = module.dynamodb.dynamodb_table_arn
}
output "dynamodb_table_id" {
  description = "ID of the DynamoDB table"
  value       = module.dynamodb.dynamodb_table_id
}
output "dynamodb_pitr_status" {
  description = "Point-in-Time Recovery status"
  value       = module.dynamodb.dynamodb_pitr_status
}

############ IAM Role Outputs ####################################
output "lambda_get_endpoint_iam_role_arn" {
  description = "IAM role arn for the Lambda get endpoint function"
  value       = module.iam_get_endpoint_role.iam_role_arn
}
output "lambda_put_endpoint_iam_role_arn" {
  description = "IAM role arn for the Lambda put endpoint function"
  value       = module.iam_put_endpoint_role.iam_role_arn
}

############ Cloudwatch Log Group Outputs ########################
output "lambda_get_cw_log_group_name" {
  description = "The name of the Lambda get function Cloudwatch log group"
  value       = module.lambda_get_cw_log_group.log_group_name
}
output "lambda_get_cw_log_group_arn" {
  description = "The ARN of the Lambda get function Cloudwatch log arn"
  value       = module.lambda_get_cw_log_group.log_group_arn
}
output "lambda_put_cw_log_group_name" {
  description = "The name of the Lambda put function Cloudwatch log group name"
  value       = module.lambda_put_cw_log_group.log_group_name
}
output "lambda_put_cw_log_group_arn" {
  description = "The ARN of the Lambda put function Cloudwatch log group"
  value       = module.lambda_put_cw_log_group.log_group_arn
}

############ Lambda Function Outputs ###############################
output "lambda_get_function_name" {
  description = "The name of the Lambda get function"
  value       = module.lambda_get_function.lambda_function_name
}
output "lambda_put_function_name" {
  description = "The name of the Lambda put function"
  value       = module.lambda_put_function.lambda_function_name
}
output "lambda_get_function_arn" {
  description = "The ARN of the Lambda get function"
  value       = module.lambda_get_function.lambda_function_arn
}
output "lambda_put_function_arn" {
  description = "The ARN of the Lambda put function"
  value       = module.lambda_put_function.lambda_function_arn
}