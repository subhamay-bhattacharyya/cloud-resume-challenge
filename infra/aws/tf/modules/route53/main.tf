# --- root/aws/tf/modules/route53/main.tf ---

resource "aws_route53_record" "this" {
  zone_id = var.route53-simple-routing["zone-id"]
  name    = "resume.${var.route53-simple-routing["website-domain"]}"
  type    = var.route53-simple-routing["type"]

  alias {
    name                   = var.route53-simple-routing["cloudfront-domain"]
    zone_id                = var.route53-simple-routing["cloudfront-hosted-zone-id"]
    evaluate_target_health = false
  }
}