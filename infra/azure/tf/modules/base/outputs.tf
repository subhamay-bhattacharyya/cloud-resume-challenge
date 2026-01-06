# --- root/azure/tf/modules/base/outputs.tf ---


output "resource_group_id" {
  description = "Azure resource group id"
  value       = azurerm_resource_group.this.id
}

output "resource_group_name" {
  description = "Azure resource group name"
  value       = azurerm_resource_group.this.name
}

output "resource_group_location" {
  description = "Azure resource group location"
  value       = azurerm_resource_group.this.location
}