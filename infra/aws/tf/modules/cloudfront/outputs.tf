# --- root/aws/tf/modules/cloudfront/outputs.tf ---

output "cloudfront_domain_name" {
  description = "The domain name corresponding to the CloudFront distribution."
  value       = aws_cloudfront_distribution.this.domain_name
}
output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution."
  value       = aws_cloudfront_distribution.this.id
}
output "cloudfront_distribution_arn" {
  description = "The ARN of the CloudFront distribution."
  value       = aws_cloudfront_distribution.this.arn
}
output "cloudfront_hosted_zone_id" {
  description = "The Route 53 hosted zone ID for the CloudFront distribution."
  value       = aws_cloudfront_distribution.this.hosted_zone_id
}