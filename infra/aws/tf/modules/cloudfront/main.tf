# --- root/aws/tf/modules/cloudfront/main.tf ---

# --- root/aws/tf/modules/cloudfront/main.tf ---

resource "aws_cloudfront_origin_access_control" "this" {
  name                              = var.cloudfront-distribution["cloudfront-domain-name"]
  description                       = "OAC for private S3 bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# (Recommended) Origin Request Policy for S3:
# Forward nothing (best for static S3) while still allowing CloudFront to cache efficiently.
resource "aws_cloudfront_origin_request_policy" "this" {
  name    = "CRC-CloudFront-Origin-Request-Policy"
  comment = "Origin request policy for S3 (no cookies/query strings)"

  cookies_config {
    cookie_behavior = "none"
  }

  headers_config {
    header_behavior = "whitelist"
    headers {
      items = ["origin", "access-control-request-headers", "access-control-request-method"]
    }
  }

  query_strings_config {
    query_string_behavior = "none"
  }
}

resource "aws_cloudfront_cache_policy" "this" {
  name    = "CRC-CloudFront-Cache-Policy"
  comment = "Cache policy for CloudFront distribution (S3 static)"

  default_ttl = 3600
  max_ttl     = 86400
  min_ttl     = 0

  parameters_in_cache_key_and_forwarded_to_origin {
    enable_accept_encoding_gzip   = true
    enable_accept_encoding_brotli = true

    cookies_config {
      cookie_behavior = "none"
    }

    headers_config {
      header_behavior = "none"
    }

    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

resource "aws_cloudfront_distribution" "this" {
  enabled         = true
  is_ipv6_enabled = true
  comment         = var.cloudfront-distribution["comment"]
  # default_root_object = "index.html"
  price_class = "PriceClass_All"

  origin {
    # IMPORTANT: for S3 + OAC use the bucket *regional* domain name:
    # e.g. my-bucket.s3.us-east-1.amazonaws.com
    domain_name              = var.cloudfront-distribution["cloudfront-domain-name"]
    origin_id                = var.cloudfront-distribution["origin-id"]
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id

    # REQUIRED BLOCK for S3 origins (even with OAC)
    s3_origin_config {
      # OAC does NOT use OAI, so keep this empty
      origin_access_identity = ""
    }

  }


  default_cache_behavior {
    target_origin_id       = var.cloudfront-distribution["origin-id"]
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    # ✅ Use cache policy instead of forwarded_values + TTLs
    cache_policy_id = aws_cloudfront_cache_policy.this.id ##"658327ea-f89d-4fab-a63d-7e88639e58f6"        # Managed-CachingOptimized 

    # ✅ Recommended: keep origin request minimal for S3
    origin_request_policy_id = aws_cloudfront_origin_request_policy.this.id ## "88a5eaf4-2fd4-4709-b370-b4c650ea3fcf" ##
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = merge(var.cloudfront-distribution["tags"], {
    Name = "CRC-CloudFront-Distribution"
  })
}

resource "aws_s3_bucket_policy" "this" {
  bucket = var.cloudfront-distribution["s3-bucket-name"]
  # depends_on = [aws_s3_bucket_public_access_block.this]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "PublicReadGetObject"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${var.cloudfront-distribution["s3-bucket-arn"]}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.this.arn
          }
        }
      }
    ]
  })
}
