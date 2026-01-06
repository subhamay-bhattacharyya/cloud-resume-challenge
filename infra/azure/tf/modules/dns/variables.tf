# --- root/azure/tf/modules/dns/variables.tf ---

variable "azure_dns_config" {
  description = "The configuration for Azure DNS"
  type        = any
}