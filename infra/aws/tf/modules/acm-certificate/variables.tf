# --- root/aws/tf/modules/acm-certificate/variables.tf ---

variable "acm-certificate" {
  description = "ACM certificate configuration"
  type        = map(any)
}
