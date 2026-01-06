# --- root/azure/tf/modules/storage/outputs.tf ---

output "storage_account_id" {
  description = "ARM resource ID of the Azure Storage Account used as the private origin for the Cloud Resume Challenge website."
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "Globally unique name of the Azure Storage Account hosting the Cloud Resume Challenge static website."
  value       = azurerm_storage_account.this.name
}

output "storage_account_location" {
  description = "Azure region where the Cloud Resume Challenge storage account is deployed."
  value       = azurerm_storage_account.this.location
}

output "static_website_url" {
  description = "The primary web endpoint for the static website of the storage account"
  value       = azurerm_storage_account.this.primary_web_endpoint
}

