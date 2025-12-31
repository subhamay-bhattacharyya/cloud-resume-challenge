# --- root/aws/tf/modules/acm-certificate/main.tf ---

resource "aws_acm_certificate" "this" {
  domain_name       = "resume.${var.acm_certificate["domain-name"]}"
  validation_method = var.acm_certificate["validation-method"]

  subject_alternative_names = ["*.${var.acm_certificate["domain-name"]}"]

  lifecycle {
    create_before_destroy = true
  }
}
