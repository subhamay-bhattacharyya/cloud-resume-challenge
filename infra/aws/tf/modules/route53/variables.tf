# --- root/aws/tf/modules/route53/variables.tf ---

variable "route53_simple_routing" {
  description = "Route53 Record configuration"
  type        = map(any)
}