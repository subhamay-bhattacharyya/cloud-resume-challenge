# --- root/azure/tf/modules/dns/outputs.tf ---

output "azurerm_dns_zone_name" {
  description = "The name of the DNS zone"
  value       = azurerm_dns_zone.this.name
}

output "azurerm_dns_zone_id" {
  description = "The ID of the DNS zone"
  value       = azurerm_dns_zone.this.id
}