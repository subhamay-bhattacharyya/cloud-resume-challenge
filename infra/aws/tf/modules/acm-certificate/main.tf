# --- root/aws/tf/modules/acm-certificate/main.tf ---

resource "aws_acm_certificate" "this" {
  domain_name       = "resume.${var.acm-certificate["domain-name"]}"
  validation_method = var.acm-certificate["validation-method"]

  subject_alternative_names = ["*.${var.acm-certificate["domain-name"]}"]

  lifecycle {
    create_before_destroy = true
  }
}
