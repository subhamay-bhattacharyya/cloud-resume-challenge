# --- root/azure/tf/locals.tf ---
resource "random_string" "this" {
  length  = 6
  upper   = false
  numeric = true
  special = false
}

locals {
  azure_config = jsondecode(file("./input-jsons/azure-storage.json"))
  azure_storage_config = {
    resource_group_name             = module.base.resource_group_name
    location                        = module.base.resource_group_location
    name                            = "${local.azure_config.storage_account.name}${random_string.this.result}"
    account_replication_type        = local.azure_config.storage_account.account_replication_type
    account_tier                    = local.azure_config.storage_account.account_tier
    account_kind                    = local.azure_config.storage_account.account_kind
    min_tls_version                 = local.azure_config.storage_account.min_tls_version
    allow_nested_items_to_be_public = local.azure_config.storage_account.allow_nested_items_to_be_public
    default_tags                    = local.azure_config.default_tags
  }
  azure_cdn_config = {
    resource_group_name = module.base.resource_group_name
    front_door_config = {
      name     = local.azure_config.cdn.front_door_name
      sku_name = local.azure_config.cdn.sku_name
      front_door_endpoint = {
        name = local.azure_config.cdn.front_door_endpoint
      }
    }
    front_door_endpoint = local.azure_config.cdn.front_door_endpoint
    default_tags        = local.azure_config.default_tags
    origin = {
      name      = "storage-origin"
      host_name = "${local.azure_storage_config.name}.z13.web.core.windows.net"
    }
    custom_domain_host = local.azure_config.website_domain_name
  }
  azure_dns_config = {
    resource_group_name = module.base.resource_group_name
    zone_name           = local.azure_config.dns.zone_name
    default_tags        = local.azure_config.default_tags
    front_door_target   = module.cdn.cdn_frontdoor_host_name
    domain_name         = local.azure_config.website_domain_name
    records = [
      module.cdn.cdn_frontdoor_endpoint_name
    ]
  }
}