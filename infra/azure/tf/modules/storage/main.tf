# --- root/azure/tf/modules/storage/main.tf ---

resource "azurerm_storage_account" "this" {
  name                            = var.azure_storage_config.name
  resource_group_name             = var.azure_storage_config.resource_group_name
  location                        = var.azure_storage_config.location
  account_tier                    = var.azure_storage_config.account_tier
  account_replication_type        = var.azure_storage_config.account_replication_type
  access_tier                     = var.azure_storage_config.account_tier == "Standard" ? "Hot" : null
  account_kind                    = var.azure_storage_config.account_kind
  min_tls_version                 = var.azure_storage_config.min_tls_version
  allow_nested_items_to_be_public = var.azure_storage_config.allow_nested_items_to_be_public
  tags                            = var.azure_storage_config.default_tags
}

# ---------------------------------------------------------------
# 🔥 Enable Static Website Hosting on the Storage Account
# ---------------------------------------------------------------

resource "azurerm_storage_account_static_website" "this" {
  storage_account_id = azurerm_storage_account.this.id

  index_document     = "index.html"
  error_404_document = "404.html"
}

resource "azurerm_storage_blob" "index_html" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "${path.module}/website-content/index.html"
  content_type           = "text/html; charset=utf-8"
  cache_control          = "public, max-age=300"

  lifecycle {
    # Ignore changes from external uploads (Ansible)
    ignore_changes = [
      source,
      content_md5,
      metadata,
      cache_control,
      content_type
    ]
  }
}

resource "azurerm_storage_blob" "error_404_document" {
  name                   = "404.html"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "${path.module}/website-content/404.html"
  content_type           = "text/html; charset=utf-8"
  cache_control          = "public, max-age=300"

  lifecycle {
    # Ignore changes from external uploads (Ansible)
    ignore_changes = [
      source,
      content_md5,
      metadata,
      cache_control,
      content_type
    ]
  }
}
