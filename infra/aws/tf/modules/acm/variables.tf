# --- root/aws/tf/modules/acm-certificate/variables.tf ---

variable "acm_certificate" {
  description = "ACM certificate configuration"
  type        = map(any)
}
