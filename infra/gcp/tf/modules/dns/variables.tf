# --- root/gcp/tf/modules/dns/variables.tf ---

variable "dns_config" {
  description = "DNS configuration including managed zone name and website domain"
  type        = map(string)
}