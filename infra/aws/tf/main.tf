# --- root/aws/tf/root/main.tf ---

module "acm" {
  source          = "./modules/acm"
  acm_certificate = local.acm_config
}

module "s3" {
  source            = "./modules/s3"
  s3_static_website = local.s3_config
}

module "cloudfront" {
  source                  = "./modules/cloudfront"
  cloudfront_distribution = local.cloudfront
}

module "route53" {
  source                 = "./modules/route53"
  route53_simple_routing = local.route53_record
}

module "dynamodb" {
  source         = "./modules/dynamodb"
  dynamodb_table = local.dynamodb
}

module "iam_get_endpoint_role" {
  source      = "./modules/iam"
  lambda_role = local.lambda_get_role
}

module "iam_put_endpoint_role" {
  source      = "./modules/iam"
  lambda_role = local.lambda_put_role
}

module "lambda_get_cw_log_group" {
  source                   = "./modules/cloudwatch"
  cloudwatch_configuration = local.get_function_cw_log
}

module "lambda_put_cw_log_group" {
  source                   = "./modules/cloudwatch"
  cloudwatch_configuration = local.put_function_cw_log
}

module "lambda_get_function" {
  source          = "./modules/lambda"
  lambda_function = local.lambda_get_function
}

module "lambda_put_function" {
  source          = "./modules/lambda"
  lambda_function = local.lambda_put_function
}


# module "api-gateway" {
#   source              = "./modules/api-gateway"
#   api-gateways = local.api-gateways
# }