# --- root/gcp/tf/modules/dns/outputs.tf ---

output "google_dns_managed_zone_name" {
  description = "Google DNS Managed Zone Name"
  value       = data.google_dns_managed_zone.primary.name
}
output "google_dns_managed_zone_id" {
  description = "Google DNS Managed Zone Id"
  value       = data.google_dns_managed_zone.primary.id
}
output "a_record_name" {
  description = "DNS A Record for resume subdomain"
  value       = google_dns_record_set.a_record.name
}
# output "aaaa_record_name" {
#   description = "DNS AAAA Record for resume subdomain"
#   value       = google_dns_record_set.aaaa_record.name
# }
