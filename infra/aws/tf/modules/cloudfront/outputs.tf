# --- root/aws/tf/modules/cloudfront/outputs.tf ---

output "cloudfront-domain-name" {
  description = "The domain name corresponding to the CloudFront distribution."
  value       = aws_cloudfront_distribution.this.domain_name
}
output "cloudfront-distribution-id" {
  description = "The ID of the CloudFront distribution."
  value       = aws_cloudfront_distribution.this.id
}
output "cloudfront-distribution-arn" {
  description = "The ARN of the CloudFront distribution."
  value       = aws_cloudfront_distribution.this.arn
}   