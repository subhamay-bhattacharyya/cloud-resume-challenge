# --- root/gcp/tf/modules/compute-engine/outputs.tf ---

############# Compute Engine Bucket Outputs #############
output "google_compute_backend_bucket_id" {
  description = "Compute Engine Backend Bucket Id"
  value       = google_compute_backend_bucket.this.id
}
output "google_compute_backend_bucket_self_link" {
  description = "Compute Engine Backend Bucket Self Link"
  value       = google_compute_backend_bucket.this.self_link
}
output "google_compute_global_address_id" {
  description = "Compute Engine Global Address Id"
  value       = google_compute_global_address.this.id
}
output "google_compute_global_address_self_link" {
  description = "Compute Engine Global Address Self Link"
  value       = google_compute_global_address.this.self_link
}
output "google_compute_ipv4_address" {
  description = "Compute Engine Global IPv4 Address"
  value       = google_compute_global_address.this.address
}
output "google_compute_url_map_id" {
  description = "Compute Engine URL Map Id"
  value       = google_compute_url_map.this.id
}
output "google_compute_url_map_self_link" {
  description = "Compute Engine URL Map Self Link"
  value       = google_compute_url_map.this.self_link
}
output "google_compute_ssl_certificate_id" {
  description = "Compute Engine SSL Certificate Id"
  value       = google_compute_managed_ssl_certificate.this.id
}
output "google_compute_ssl_certificate_self_link" {
  description = "Compute Engine SSL Certificate Self Link"
  value       = google_compute_managed_ssl_certificate.this.self_link
}
output "google_compute_http_proxy_id" {
  description = "Compute Engine HTTPS Proxy Id"
  value       = google_compute_target_https_proxy.this.id
}
output "google_compute_http_proxy_self_link" {
  description = "Compute Engine HTTPS Proxy Self Link"
  value       = google_compute_target_https_proxy.this.self_link
}
output "google_compute_forwarding_rule_id" {
  description = "Compute Engine HTTPS Forwarding Rule Id"
  value       = google_compute_global_forwarding_rule.this.id
}
output "google_compute_forwarding_rule_self_link" {
  description = "Compute Engine HTTPS Forwarding Rule Self Link"
  value       = google_compute_global_forwarding_rule.this.self_link
}



# # output "google_compute_ipv6_address" {
# #   description = "Compute Engine Global IPv6 Address"
# #   value       = google_compute_global_address.this.ipv6_address
# # }
