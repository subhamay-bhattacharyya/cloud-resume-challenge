# --- root/azure/tf/modules/dns/main.tf ---

# CNAME: www → <endpoint>.azurefd.net
# Front Door endpoint host is typically <endpoint>.azurefd.net
# The endpoint resource exposes a host_name attribute in newer provider versions;


resource "azurerm_dns_zone" "this" {
  name                = var.azure_dns_config.zone_name
  resource_group_name = var.azure_dns_config.resource_group_name
  tags                = var.azure_dns_config.default_tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_dns_cname_record" "custom_domain" {
  name                = "www"
  zone_name           = azurerm_dns_zone.this.name
  resource_group_name = var.azure_dns_config.resource_group_name ##var.azure_dns_config.resource_group_name
  ttl                 = 300
  record              = var.azure_dns_config.front_door_target ##var.azure_dns_config.records[0] # "<endpoint>.azurefd.net"
  tags                = var.azure_dns_config.default_tags
}

# Validation helper record (often required): afdverify.www -> afdverify.<endpoint>.azurefd.net
resource "azurerm_dns_cname_record" "afdverify" {
  name                = "afdverify.www"
  zone_name           = azurerm_dns_zone.this.name
  resource_group_name = var.azure_dns_config.resource_group_name
  ttl                 = 300
  record              = "afdverify.${var.azure_dns_config.front_door_target}"
  tags                = var.azure_dns_config.default_tags
}