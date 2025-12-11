output "azure_subscription_id" {
  description = "Azure subscription id"
  value       = azurerm_resource_group.this.id
}

output "azurerm_resource_group_name" {
  description = "Azure resource group name"
  value       = azurerm_resource_group.this.name
}

output "azurerm_resource_group_location" {
  description = "Azure resource group location"
  value       = azurerm_resource_group.this.location
}

output "azurerm_storage_account" {
  description = "Azure storage account"
  value       = azurerm_storage_account.this.name
}

output "static_website_url" {
  description = "The primary web endpoint for the static website of the storage account"
  value       = azurerm_storage_account.this.primary_web_endpoint
}

