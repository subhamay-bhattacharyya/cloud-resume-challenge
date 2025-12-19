# --- root/gcp/tf/main.tf ---

resource "google_storage_bucket" "resume-site" {
  name          = var.google-storage-bucket-name
  location      = var.gcp-region
  force_destroy = true

  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
  #   cors {
  #     origin          = ["http://image-store.com"]
  #     method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
  #     response_header = ["*"]
  #     max_age_seconds = 3600
  #   }
  #   cors {
  #     origin            = ["http://image-store.com"]
  #     method            = ["GET", "HEAD", "PUT", "POST", "DELETE"]
  #     response_header   = ["*"]
  #     max_age_seconds   = 0
  #   }
}