# --- root/azure/tf/modules/base/main.tf ---

resource "azurerm_resource_group" "this" {
  name     = var.azure_config.base.resource_group_name
  location = var.azure_config.base.location
  tags     = var.azure_config.default_tags
}
