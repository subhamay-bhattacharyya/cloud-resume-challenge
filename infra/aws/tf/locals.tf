# --- root/aws/tf/root/locals.tf ---

locals {
  s3-static-website = jsondecode(file("./input-jsons/s3-static-website.json"))
  acm-certificate   = jsondecode(file("./input-jsons/acm-certificate.json"))
  cloudfront-distribution = {
    "s3-bucket-arn"          = module.s3-bucket.s3-bucket-arn
    "s3-bucket-name"         = module.s3-bucket.s3-bucket-name
    "cloudfront-domain-name" = module.s3-bucket.s3-bucket-regional-domain-name
    "origin-id"              = "crc-s3-origin"
    "website-domain"         = local.s3-static-website["website-domain"]
    "comment"                = "CloudFront Distribution for ${local.s3-static-website["website-domain"]}"
    "tags"                   = var.tags
  }
  website-domain = local.s3-static-website["website-domain"]
}
