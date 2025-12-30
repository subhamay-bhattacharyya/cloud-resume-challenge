# --- root/aws/tf/root/main.tf ---


# module "acm-certificate" {
#   source                    = "./modules/acm-certificate"
#   domain-name               = local.acm-certificate.domain-name
#   subject-alternative-names = local.acm-certificate.subject-alternative-names
#   project-name              = var.project-name
# }

module "s3-bucket" {
  source            = "./modules/s3-bucket"
  s3-static-website = local.s3-static-website
}

module "cloudfront" {
  source                  = "./modules/cloudfront"
  cloudfront-distribution = local.cloudfront-distribution
}

# module "route53" {
#   source          = "./modules/route53"
#   route53-zones  = local.route53-zones
#   route53-records = local.route53-records
# }

module "dynamodb-table" {
  source          = "./modules/dynamodb-table"
  dynamodb-tables = local.dynamodb-table
}

# module "iam-role" {
#   source    = "./modules/iam-role"
#   iam-roles = local.iam-roles
# }

# module "lambda-function" {
#   source           = "./modules/lambda-function"
#   lambda-functions = local.lambda-functions
# }

# module "api-gateway" {
#   source              = "./modules/api-gateway"
#   api-gateways = local.api-gateways
# }