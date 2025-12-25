# --- root/aws/tf/modules/s3-bucket/outputs.tf ---

output "s3-bucket-name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.this.bucket
}

output "s3-bucket-arn" {
  description = "S3 bucket ARN"
  value       = aws_s3_bucket.this.arn
}

output "static-website-domain" {
  description = "The domain of the static website"
  value       = aws_s3_bucket_website_configuration.this.website_domain
}

output "static-website-endpoint" {
  description = "The endpoint of the static website"
  value       = aws_s3_bucket_website_configuration.this.website_endpoint
}