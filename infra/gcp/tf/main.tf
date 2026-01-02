# --- root/gcp/tf/main.tf ---


module "gcs" {
  source     = "./modules/gcs"
  gcs_config = local.gcs_config
}

module "compute_backend_bucket" {
  source                = "./modules/compute-engine"
  compute_bucket_config = local.compute_bucket_config
}

module "dns" {
  source     = "./modules/dns"
  dns_config = local.dns_config
}