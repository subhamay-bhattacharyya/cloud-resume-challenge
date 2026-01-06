# --- root/azure/tf/modules/cdn/main.tf ---

##############################
# 1) Front Door Profile + Endpoint
##############################

resource "azurerm_cdn_frontdoor_profile" "this" {
  name                = var.azure_cdn_config.front_door_config.name
  resource_group_name = var.azure_cdn_config.resource_group_name
  sku_name            = "Standard_AzureFrontDoor"
  tags                = var.azure_cdn_config.default_tags
}

resource "azurerm_cdn_frontdoor_endpoint" "this" {
  name                     = var.azure_cdn_config.front_door_endpoint
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
  tags                     = var.azure_cdn_config.default_tags
}

##############################
# 2) Origin Group + Origin (Storage Static Website)
##############################

resource "azurerm_cdn_frontdoor_origin_group" "this" {
  name                     = "crc-origin-static-site"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id

  load_balancing {}

  health_probe {
    interval_in_seconds = 120
    path                = "/index.html"
    protocol            = "Https"
    request_type        = "GET"
  }
}

resource "azurerm_cdn_frontdoor_origin" "this" {
  name                          = "crc-origin-storage-static-web"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.this.id

  # IMPORTANT: host_name must be ONLY the hostname (no https://, no trailing /)
  # Example: subhamaycrcoxv15o.z13.web.core.windows.net
  host_name          = var.azure_cdn_config.origin.host_name
  origin_host_header = var.azure_cdn_config.origin.host_name

  http_port  = 80
  https_port = 443

  certificate_name_check_enabled = true
  enabled                        = true

  priority = 1
  weight   = 1000
}

##############################
# 3) Default Route (serves *.azurefd.net)
##############################

resource "azurerm_cdn_frontdoor_route" "default" {
  name                          = "crc-route-default"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.this.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.this.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.this.id]

  enabled                = true
  link_to_default_domain = true

  patterns_to_match      = ["/*"]
  supported_protocols    = ["Http", "Https"]
  forwarding_protocol    = "HttpsOnly"
  https_redirect_enabled = true

  # ✅ Attach custom domain here (this replaces the association resource)
  cdn_frontdoor_custom_domain_ids = [
    azurerm_cdn_frontdoor_custom_domain.www.id
  ]
}


##############################
# 4) Custom Domain + Association (www.<domain>)
##############################

resource "azurerm_cdn_frontdoor_custom_domain" "www" {
  name                     = "www"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
  host_name                = "www.subhamay-resume-azure.space"

  tls {
    certificate_type = "ManagedCertificate"
  }
}


