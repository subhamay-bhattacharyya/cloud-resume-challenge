# --- root/azure/tf/main.tf ---

module "base" {
  source       = "./modules/base"
  azure_config = local.azure_config
}

module "storage" {
  source               = "./modules/storage"
  azure_storage_config = local.azure_storage_config
}

module "cdn" {
  source           = "./modules/cdn"
  azure_cdn_config = local.azure_cdn_config
}

module "dns" {
  source           = "./modules/dns"
  azure_dns_config = local.azure_dns_config
}
