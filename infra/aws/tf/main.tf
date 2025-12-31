# --- root/aws/tf/root/main.tf ---


module "acm-certificate" {
  source          = "./modules/acm-certificate"
  acm-certificate = local.acm-certificate
}

module "s3-bucket" {
  source            = "./modules/s3-bucket"
  s3-static-website = local.s3-static-website
}

module "cloudfront" {
  source                  = "./modules/cloudfront"
  cloudfront-distribution = local.cloudfront-distribution
}

module "route53" {
  source                 = "./modules/route53"
  route53-simple-routing = local.route53-simple-routing
}

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