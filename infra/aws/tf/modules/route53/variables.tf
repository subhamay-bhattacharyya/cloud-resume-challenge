# --- root/aws/tf/modules/route53/variables.tf ---

variable "route53-simple-routing" {
  description = "Route53 Record configuration"
  type        = map(any)
}