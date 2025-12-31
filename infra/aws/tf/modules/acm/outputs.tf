# --- root/aws/tf/modules/acm-certificate/outputs.tf ---

output "acm_certificate_arn" {
  description = "ARN of the ACM certificate."
  value       = aws_acm_certificate.this.arn
}

output "domain_validation_options" {
  description = "Domain validation options to create Route53 DNS validation records."
  value = [
    for dvo in aws_acm_certificate.this.domain_validation_options : {
      domain_name           = dvo.domain_name
      resource_record_name  = dvo.resource_record_name
      resource_record_type  = dvo.resource_record_type
      resource_record_value = dvo.resource_record_value
    }
  ]
}
