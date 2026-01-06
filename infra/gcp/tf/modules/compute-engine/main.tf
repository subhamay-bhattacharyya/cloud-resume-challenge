# 1) Backend bucket (Cloud CDN origin)
resource "google_compute_backend_bucket" "this" {
  name        = "${var.compute_bucket_config["gcs_bucket_name"]}-backend"
  bucket_name = var.compute_bucket_config["gcs_bucket_name"] # must be the real GCS bucket name
  enable_cdn  = true

  description = "Backend bucket for private GCS static site served via Cloud CDN"
}

# 1b) Signed URL key for Cloud CDN (OPTION 2 requirement)
# resource "random_bytes" "cdn_key" { length = 16 }

# resource "google_compute_backend_bucket_signed_url_key" "cdn_key" {
#   name           = "cdn-key-1"
#   backend_bucket = google_compute_backend_bucket.this.name
#   key_value      = random_bytes.cdn_key.base64
# }


# 2) Global static IP
resource "google_compute_global_address" "this" {
  name        = "${var.compute_bucket_config["gcs_bucket_name"]}-lb-ip"
  description = "Global static IP for resume HTTPS load balancer"

  # If this errors in your provider version, comment it out.
  labels = var.compute_bucket_config["labels"]
}


# 3) URL map (includes rewrite / -> /index.html)
resource "google_compute_url_map" "this" {
  name        = "${var.compute_bucket_config["gcs_bucket_name"]}-url-map"
  description = "URL map for static site -> backend bucket"

  # Default: no rewrite, just serve the path as-is
  default_service = google_compute_backend_bucket.this.id

  host_rule {
    hosts        = ["resume.${var.compute_bucket_config["website_domain"]}"]
    path_matcher = "pm"
  }

  path_matcher {
    name            = "pm"
    default_service = google_compute_backend_bucket.this.id

    route_rules {
      priority = 1

      match_rules {
        full_path_match = "/"
      }

      route_action {
        url_rewrite {
          path_prefix_rewrite = "/index.html"
        }
      }

      service = google_compute_backend_bucket.this.id
    }
  }
}


# 4) Managed SSL certificate
resource "google_compute_managed_ssl_certificate" "this" {
  name = "${var.compute_bucket_config["gcs_bucket_name"]}-cert"

  managed {
    domains = [
      "resume.${var.compute_bucket_config["website_domain"]}",
    ]
  }
}

# 5) HTTPS proxy
resource "google_compute_target_https_proxy" "this" {
  name        = "${var.compute_bucket_config["gcs_bucket_name"]}-https-proxy"
  url_map     = google_compute_url_map.this.id
  description = "HTTPS proxy for resume site"

  ssl_certificates = [
    google_compute_managed_ssl_certificate.this.id
  ]
}

# 6) HTTPS forwarding rule
resource "google_compute_global_forwarding_rule" "this" {
  name        = "${var.compute_bucket_config["gcs_bucket_name"]}-https-fr"
  description = "HTTPS forwarding rule for resume site"

  ip_address = google_compute_global_address.this.address
  port_range = "443"
  target     = google_compute_target_https_proxy.this.id
}
