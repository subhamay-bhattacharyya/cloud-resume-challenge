# --- root/aws/tf/modules/s3/main.tf ---

resource "aws_s3_bucket" "this" {
  bucket        = var.s3_static_website["s3-bucket-name"]
  force_destroy = true

}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.this.id
  key    = "index.html"
  source = "${path.module}/website-content/index.html"


  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag         = filemd5("${path.module}/website-content/index.html")
  content_type = "text/html; charset=utf-8"
}

