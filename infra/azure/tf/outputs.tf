# --- root/azure/tf/outputs.tf ---

################### Base Resources ##############################
output "resource_group_id" {
  description = "Azure subscription id"
  value       = module.base.resource_group_id
}

output "resource_group_name" {
  description = "Azure resource group name"
  value       = module.base.resource_group_name
}

output "resource_group_location" {
  description = "Azure resource group location"
  value       = module.base.resource_group_location
}

################### Storage Resources ##############################
output "storage_account_name" {
  description = "The name of the Azure Storage Account"
  value       = module.storage.storage_account_name
}

output "storage_account_id" {
  description = "The id of the Azure Storage Account Id"
  value       = module.storage.storage_account_id
}

output "storage_account_location" {
  description = "The location of the Azure Storage Account"
  value       = module.storage.storage_account_location
}

output "static_website_url" {
  description = "The primary web endpoint for the static website of the storage account"
  value       = module.storage.static_website_url
}

output "cdn_frontdoor_profile_id" {
  description = "The ID of the CDN Front Door Profile"
  value       = module.cdn.cdn_frontdoor_profile_id
}

output "cdn_frontdoor_endpoint_id" {
  description = "The ID of the CDN Front Door Endpoint"
  value       = module.cdn.cdn_frontdoor_endpoint_id
}

output "cdn_frontdoor_origin_group_name" {
  description = "The name of the CDN Front Door Origin Group"
  value       = module.cdn.cdn_frontdoor_origin_group_name
}

output "cdn_frontdoor_endpoint_name" {
  description = "The name of the CDN Front Door Endpoint"
  value       = module.cdn.cdn_frontdoor_endpoint_name
}

output "cdn_frontdoor_route_name" {
  description = "Azure frontdoor route name"
  value       = module.cdn.cdn_frontdoor_route_name
}

output "cdn_frontdoor_host_name" {
  description = "Azure frontdoor host  name"
  value       = module.cdn.cdn_frontdoor_host_name
}

output "cdn_frontdoor_origin_name" {
  description = "Azure frontdoor origin name"
  value       = module.cdn.cdn_frontdoor_origin_name
}

# output "azurerm_cdn_frontdoor_custom_domain_name" {
#   description = "Azure frontdoor custom domain name"
#   value       = module.cdn.azurerm_cdn_frontdoor_custom_domain_name
# }

# output "azurerm_dns_zone_name" {
#   description = "The name of the DNS zone"
#   value       = module.dns.azurerm_dns_zone_name
# }

# output "azurerm_dns_zone_id" {
#   description = "The ID of the DNS zone"
#   value       = module.dns.azurerm_dns_zone_id
# }