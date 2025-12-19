# --- root/aws/tf/modules/s3-bucket/main.tf ---

resource "aws_s3_bucket" "this" {
  bucket        = var.s3-static-website["s3-bucket-name"]
  force_destroy = true

  tags = {
    project = var.project-name
  }
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}