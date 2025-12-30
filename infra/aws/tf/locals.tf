# --- root/aws/tf/root/locals.tf ---

locals {
  acm-certificate = {
    "domain-name" : var.crc-domain-name,
    "subject-alternative-names" : ["resume.${var.crc-domain-name}"]
  }
  s3-static-website = jsondecode(file("./input-jsons/s3-static-website.json"))

  cloudfront-distribution = {
    "s3-bucket-arn"          = module.s3-bucket.s3-bucket-arn
    "s3-bucket-name"         = module.s3-bucket.s3-bucket-name
    "cloudfront-domain-name" = module.s3-bucket.s3-bucket-regional-domain-name
    "origin-id"              = "crc-s3-origin"
    "website-domain"         = local.s3-static-website["website-domain"]
    "comment"                = "CloudFront Distribution for ${local.s3-static-website["website-domain"]}"
    "tags"                   = var.tags
  }
  dynamodb-table = jsondecode(file("./input-jsons/dynamodb-table.json"))
}
