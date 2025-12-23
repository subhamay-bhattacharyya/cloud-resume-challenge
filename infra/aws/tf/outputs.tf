# --- root/aws/tf/root/outputs.tf ---

output "s3-bucket-name" {
  description = "S3 bucket name used for static website"
  value       = module.s3-bucket.s3-bucket-name
}

output "s3-bucket-arn" {
  description = "S3 bucket ARN"
  value       = module.s3-bucket.s3-bucket-arn
}

output "static-website-domain" {
  description = "The domain of the static website"
  value       = module.s3-bucket.static-website-domain
}

output "static-website-endpoint" {
  description = "The endpoint of the static website"
  value       = module.s3-bucket.static-website-endpoint
}

output "acm-certificate-arn" {
  description = "The ARN of the ACM certificate"
  value       = module.acm-certificate.acm-certificate-arn
}