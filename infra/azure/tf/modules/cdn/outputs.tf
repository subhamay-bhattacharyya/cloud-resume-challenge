# --- root/azure/tf/modules/cdn/outputs.tf ---

output "cdn_frontdoor_profile_id" {
  description = "The ID of the CDN Front Door Profile"
  value       = azurerm_cdn_frontdoor_profile.this.id
}

output "cdn_frontdoor_endpoint_id" {
  description = "The ID of the CDN Front Door Endpoint"
  value       = azurerm_cdn_frontdoor_endpoint.this.id
}

output "cdn_frontdoor_origin_group_name" {
  description = "The name of the CDN Front Door Origin Group"
  value       = azurerm_cdn_frontdoor_origin_group.this.name
}

output "cdn_frontdoor_endpoint_name" {
  description = "The name of the CDN Front Door Endpoint"
  value       = azurerm_cdn_frontdoor_endpoint.this.name
}

output "cdn_frontdoor_host_name" {
  description = "The name of the CDN Front Door Endpoint"
  value       = azurerm_cdn_frontdoor_endpoint.this.host_name
}



output "cdn_frontdoor_route_name" {
  description = "Azure frontdoor route name"
  value       = azurerm_cdn_frontdoor_route.default.name
}

output "cdn_frontdoor_origin_name" {
  description = "Azure frontdoor origin group name"
  value       = azurerm_cdn_frontdoor_origin.this.name
}

# output "azurerm_cdn_frontdoor_custom_domain_name" {
#   description = "Azure frontdoor custom domain name"
#   value       = azurerm_cdn_frontdoor_custom_domain.this.name
# }