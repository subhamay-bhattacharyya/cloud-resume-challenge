# --- root/aws/tf/root/data.tf ---

data "aws_route53_zone" "this" {
  name         = var.website-domain
  private_zone = false
}