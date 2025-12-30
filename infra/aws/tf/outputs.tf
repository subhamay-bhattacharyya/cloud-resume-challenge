# --- root/aws/tf/root/outputs.tf ---

############ S3 Bucket Outputs ############
output "s3-bucket-name" {
  description = "S3 bucket name used for static website"
  value       = module.s3-bucket.s3-bucket-name
}

output "s3-bucket-region" {
  description = "S3 bucket region"
  value       = module.s3-bucket.s3-bucket-region
}

output "s3-bucket-arn" {
  description = "S3 bucket ARN"
  value       = module.s3-bucket.s3-bucket-arn
}

output "s3-bucket-domain-name" {
  description = "S3 bucket domain name"
  value       = module.s3-bucket.s3-bucket-domain-name
}

# output "s3-static-website-domain" {
#   description = "The domain of the static website"
#   value       = module.s3-bucket.s3-static-website-domain
# }

# output "s3-static-website-endpoint" {
#   description = "The endpoint of the static website"
#   value       = module.s3-bucket.s3-static-website-endpoint
# }

output "s3-bucket-regional-domain-name" {
  description = "The regional domain name of the bucket"
  value       = module.s3-bucket.s3-bucket-regional-domain-name
}

############ Cloudfront Outputs ############

output "cloudfront-domain-name" {
  description = "The domain name corresponding to the CloudFront distribution."
  value       = module.cloudfront.cloudfront-domain-name
}

output "cloudfront-distribution-id" {
  description = "The ID of the CloudFront distribution."
  value       = module.cloudfront.cloudfront-distribution-id
}

output "cloudfront-distribution-arn" {
  description = "The ARN of the CloudFront distribution."
  value       = module.cloudfront.cloudfront-distribution-arn
}

# output "acm-certificate-arn" {
#   description = "The ARN of the ACM certificate"
#   value       = module.acm-certificate.acm-certificate-arn
# }