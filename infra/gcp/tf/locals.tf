# --- root/gcp/tf/locals.tf ---

locals {
  gcs_config = jsondecode(file("./input-jsons/gcs-bucket.json"))

  compute_bucket_config = {
    gcs_bucket_name  = local.gcs_config.gcs_bucket_name
    website_domain   = local.gcs_config.website_domain
    static_site_name = module.gcs.gcs_bucket_name
    labels           = local.gcs_config.labels
  }

  dns_config = {
    managed_zone_name = local.gcs_config.managed_zone_name
    website_domain    = local.gcs_config.website_domain
    ipv4_address      = module.compute_backend_bucket.google_compute_ipv4_address
    # ipv6_address      = module.compute_backend_bucket.google_compute_ipv6_address
  }

}
