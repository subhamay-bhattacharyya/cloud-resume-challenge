# --- root/gcp/tf/modules/gcs/outputs.tf ---

############# GCS Bucket Outputs #############
output "gcs_bucket_name" {
  description = "GCS storage bucket name"
  value       = google_storage_bucket.this.name
}
output "gcs_bucket_url" {
  description = "GCS storage bucket url"
  value       = google_storage_bucket.this.url
}
output "gcs_bucket_self_link" {
  description = "GCS storage bucket self link"
  value       = google_storage_bucket.this.self_link
}