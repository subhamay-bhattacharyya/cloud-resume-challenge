# --- root/aws/tf/root/locals.tf ---

locals {
  acm-certificate   = jsondecode(file("./input-jsons/acm-certificate.json"))
  s3-static-website = jsondecode(file("./input-jsons/s3-static-website.json"))

  cloudfront-distribution = {
    "s3-bucket-arn"          = module.s3-bucket.s3-bucket-arn
    "s3-bucket-name"         = module.s3-bucket.s3-bucket-name
    "cloudfront-domain-name" = module.s3-bucket.s3-bucket-regional-domain-name
    "origin-id"              = "crc-s3-origin"
    "website-domain"         = local.s3-static-website["website-domain"]
    "cname"                  = ["resume.${local.s3-static-website["website-domain"]}"]
    "comment"                = "CloudFront Distribution for ${local.s3-static-website["website-domain"]}"
    "acm-certificate-arn"    = module.acm-certificate.acm-certificate-arn
    "tags"                   = var.tags
  }

  route53-simple-routing = {
    "zone-id"                   = data.aws_route53_zone.this.zone_id
    "website-domain"            = local.s3-static-website["website-domain"]
    "cloudfront-domain"         = module.cloudfront.cloudfront-domain-name
    "cloudfront-hosted-zone-id" = "Z2FDTNDATAQYW2"
    "type"                      = "A"
  }
  dynamodb-table = jsondecode(file("./input-jsons/dynamodb-table.json"))
}
