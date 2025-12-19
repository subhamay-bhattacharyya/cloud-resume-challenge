# --- root/aws/tf/root/locals.tf ---

locals {
  s3-static-website = jsondecode(file("./input-jsons/s3-static-website.json"))
  acm-certificate   = jsondecode(file("./input-jsons/acm-certificate.json"))
}
