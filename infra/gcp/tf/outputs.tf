# --- root/gcp/tf/outputs.tf ---

output "google_storage_bucket_name" {
  description = "Google Storage Bucket Name"
  value       = google_storage_bucket.resume-site.name
}

output "google_storage_bucket_url" {
  description = "Google Storage Bucket URL"
  value       = google_storage_bucket.resume-site.url
}
