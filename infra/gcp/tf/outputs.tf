# --- root/gcp/tf/outputs.tf ---

############# GCS Bucket Outputs #############
output "google_storage_bucket_name" {
  description = "Google Storage Bucket Name"
  value       = module.gcs.gcs_bucket_name
}
output "google_storage_bucket_url" {
  description = "Google Storage Bucket URL"
  value       = module.gcs.gcs_bucket_url
}
output "google_storage_bucket_self_link" {
  description = "Google Storage Bucket Self Link"
  value       = module.gcs.gcs_bucket_self_link
}
############# GCS Compute Bucket Outputs #############
output "backend_bucket_id" {
  description = "Compute Engine Backend Bucket Id"
  value       = module.compute_backend_bucket.google_compute_backend_bucket_id
}
output "backend_bucket_self_link" {
  description = "Compute Engine Backend Bucket Self Link"
  value       = module.compute_backend_bucket.google_compute_backend_bucket_self_link
}
output "global_address_id" {
  description = "Compute Engine Global Address Id"
  value       = module.compute_backend_bucket.google_compute_global_address_id
}
output "global_address_self_link" {
  description = "Compute Engine Global Address Self Link"
  value       = module.compute_backend_bucket.google_compute_global_address_self_link
}
output "url_map_id" {
  description = "Compute Engine URL Map Id"
  value       = module.compute_backend_bucket.google_compute_url_map_id
}
output "url_map_self_link" {
  description = "Compute Engine URL Map Self Link"
  value       = module.compute_backend_bucket.google_compute_url_map_self_link
}
output "ssl_certificate_id" {
  description = "Compute Engine SSL Certificate Id"
  value       = module.compute_backend_bucket.google_compute_ssl_certificate_id
}
output "ssl_certificate_self_link" {
  description = "Compute Engine SSL Certificate Self Link"
  value       = module.compute_backend_bucket.google_compute_ssl_certificate_self_link
}
output "https_proxy_id" {
  description = "Compute Engine HTTPS Proxy Id"
  value       = module.compute_backend_bucket.google_compute_http_proxy_id
}
output "https_proxy_self_link" {
  description = "Compute Engine HTTPS Proxy Self Link"
  value       = module.compute_backend_bucket.google_compute_http_proxy_self_link
}
output "https_forwarding_rule_id" {
  description = "Compute Engine HTTPS Forwarding Rule Id"
  value       = module.compute_backend_bucket.google_compute_forwarding_rule_id
}
output "https_forwarding_rule_self_link" {
  description = "Compute Engine HTTPS Forwarding Rule Self Link"
  value       = module.compute_backend_bucket.google_compute_forwarding_rule_self_link
}
############# DNS Outputs #############
output "google_dns_managed_zone_name" {
  description = "Google DNS Managed Zone Name"
  value       = module.dns.google_dns_managed_zone_name
}
output "dns_managed_zone_id" {
  description = "Google DNS Managed Zone Id"
  value       = module.dns.google_dns_managed_zone_id
}
output "a_record_name" {
  description = "DNS A Record for resume subdomain"
  value       = module.dns.a_record_name
}
# # output "aaaa_record_name" {
# #   description = "DNS AAAA Record for resume subdomain"
# #   value       = module.dns.aaaa_record_name
# # }
# # output "google_project_number" {
# #   description = "Google Cloud Project Number"
# #   value       = module.gcs.project_number
# # }