# --- modules/gcs/main.tf ---

data "google_project" "current" {}

resource "google_storage_bucket" "this" {
  name          = var.gcs_config["gcs_bucket_name"]
  location      = var.gcs_config["bucket_location"]
  storage_class = var.gcs_config["storage_class"]

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  uniform_bucket_level_access = true
  force_destroy               = true

  labels = try(var.gcs_config["labels"], null)
}

resource "google_storage_bucket_iam_binding" "this" {
  bucket  = google_storage_bucket.this.name
  role    = "roles/storage.objectViewer"
  members = ["allUsers"]
}

# Upload site files
resource "google_storage_bucket_object" "index_html" {
  name   = "index.html"
  bucket = google_storage_bucket.this.name
  source = "${path.module}/website-content/index.html"

  content_type  = "text/html; charset=utf-8"
  cache_control = "public, max-age=300"

  lifecycle {
    # Ignore changes from external uploads (Ansible)
    ignore_changes = [
      source,
      metadata,
      cache_control,
      content_type
    ]
  }
}

resource "google_storage_bucket_object" "error_404_document" {
  name   = "404.html"
  bucket = google_storage_bucket.this.name
  source = "${path.module}/website-content/404.html"

  content_type  = "text/html; charset=utf-8"
  cache_control = "public, max-age=300"

  lifecycle {
    # Ignore changes from external uploads (Ansible)
    ignore_changes = [
      source,
      metadata,
      cache_control,
      content_type
    ]
  }
}

# ✅ Required for "private bucket + Cloud CDN fill" (after Signed URL key exists)
# resource "google_storage_bucket_iam_member" "cdn_fill_object_viewer" {
#   bucket = google_storage_bucket.static_site.name
#   role   = "roles/storage.objectViewer"
#   member = "serviceAccount:service-${data.google_project.current.number}@cloud-cdn-fill.iam.gserviceaccount.com"
# }
