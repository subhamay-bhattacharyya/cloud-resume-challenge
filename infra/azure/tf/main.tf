# --- root/azure/tf/main.tf ---

resource "azurerm_resource_group" "this" {
  name     = "cloud-resume-challenge-rg"
  location = "East US"
  tags = {
    project = "Cloud Resume Challenge"
  }
}

resource "random_string" "this" {
  length  = 6
  upper   = false
  numeric = true
  special = false
}

resource "azurerm_storage_account" "this" {
  name                = "subhamaycrc${random_string.this.result}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Hot"
  account_kind             = "StorageV2"

  min_tls_version = "TLS1_2"

  allow_nested_items_to_be_public = false

  tags = {
    project = "Cloud Resume Challenge"
  }
}

# ---------------------------------------------------------------
# 🔥 Enable Static Website Hosting on the Storage Account
# ---------------------------------------------------------------

resource "azurerm_storage_account_static_website" "this" {
  storage_account_id = azurerm_storage_account.this.id

  index_document     = "index.html"
  error_404_document = "404.html"
}
