# --- root/aws/tf/modules/route53/main.tf ---

resource "aws_route53_record" "this" {
  zone_id = var.route53_simple_routing["zone-id"]
  name    = "resume.${var.route53_simple_routing["website-domain"]}"
  type    = var.route53_simple_routing["type"]


  alias {
    name                   = var.route53_simple_routing["cloudfront-domain"]
    zone_id                = var.route53_simple_routing["cloudfront-hosted-zone-id"]
    evaluate_target_health = false
  }
}