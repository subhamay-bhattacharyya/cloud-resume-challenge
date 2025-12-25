# --- root/aws/tf/modules/acm-certificate/main.tf ---

resource "aws_acm_certificate" "this" {
  domain_name               = var.domain-name
  validation_method         = "DNS"
  subject_alternative_names = var.subject-alternative-names
  tags = {
    project = var.project-name
  }

  lifecycle {
    create_before_destroy = true
  }
}
