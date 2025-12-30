# --- root/aws/tf/modules/s3-bucket/outputs.tf ---

output "s3-bucket-name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.this.id
}

output "s3-bucket-arn" {
  description = "S3 bucket ARN"
  value       = aws_s3_bucket.this.arn
}

output "s3-bucket-domain-name" {
  description = "S3 bucket domain name"
  value       = aws_s3_bucket.this.bucket_domain_name
}

output "s3-bucket-region" {
  description = "S3 bucket region"
  value       = aws_s3_bucket.this.bucket_region
}

output "s3-bucket-regional-domain-name" {
  description = "The regional domain name of the bucket"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}