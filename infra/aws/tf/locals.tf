# --- root/aws/tf/root/locals.tf ---

data "aws_region" "current" {}

locals {
  current_region = data.aws_region.current.id

  acm_config          = jsondecode(file("./input-jsons/acm-certificate.json"))
  s3_config           = jsondecode(file("./input-jsons/s3-static-website.json"))
  dynamodb_config     = jsondecode(file("./input-jsons/dynamodb-table.json"))
  lambda_roles_config = jsondecode(file("./input-jsons/lambda-roles.json"))
  lambda_config       = jsondecode(file("./input-jsons/lambda-funtions.json"))
  cw_log_config       = jsondecode(file("./input-jsons/cw-log-groups.json"))

  cloudfront = {
    "s3-bucket-arn"          = module.s3.s3_bucket_arn
    "s3-bucket-name"         = module.s3.s3_bucket_name
    "cloudfront-domain-name" = module.s3.s3_bucket_regional_domain_name
    "origin-id"              = "crc-s3-origin"
    "website-domain"         = local.s3_config["website-domain"]
    "cname"                  = ["resume.${local.s3_config["website-domain"]}"]
    "comment"                = "CloudFront Distribution for ${local.s3_config["website-domain"]}"
    "acm-certificate-arn"    = module.acm.acm_certificate_arn
    "tags"                   = var.tags
  }

  route53_record = {
    "zone-id"                   = data.aws_route53_zone.this.zone_id
    "website-domain"            = local.s3_config["website-domain"]
    "cloudfront-domain"         = module.cloudfront.cloudfront_domain_name
    "cloudfront-hosted-zone-id" = module.cloudfront.cloudfront_hosted_zone_id
    "type"                      = "A"
  }

  dynamodb = {
    "name"          = "${var.project_name}-${local.dynamodb_config["name"]}-${var.environment}-${local.current_region}",
    "billing-mode"  = local.dynamodb_config["billing-mode"],
    "hash-key-name" = local.dynamodb_config["hash-key-name"],
    "hash-key-type" = local.dynamodb_config["hash-key-type"],
    "pitr-enabled"  = local.dynamodb_config["pitr-enabled"]
  }

  lambda_assume_policy = {
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  }

  # Extract ARNs to avoid repetition
  s3_arn                = module.s3.s3_bucket_arn
  dynamodb_arn          = module.dynamodb.dynamodb_table_arn
  get_lambda_cw_log_arn = module.lambda_get_cw_log_group.log_group_arn
  put_lambda_cw_log_arn = module.lambda_put_cw_log_group.log_group_arn

  # Dynamically build policy resource map based on policy names from JSON
  lambda_get_policy_map = {
    for policy_name, p in try(local.lambda_roles_config["get_lambda_role"]["inline-policies"], {}) :
    policy_name => (
      strcontains(policy_name, "dynamodb") ? [local.dynamodb_arn] :
      strcontains(policy_name, "s3") ? [local.s3_arn, "${local.s3_arn}/*"] :
      strcontains(policy_name, "cloudwatch-create-log-group") ? ["*"] :
      strcontains(policy_name, "cloudwatch-write-log-event") ? ["${local.get_lambda_cw_log_arn}:*"] :
      []
    )
  }

  lambda_put_policy_map = {
    for policy_name, p in try(local.lambda_roles_config["put_lambda_role"]["inline-policies"], {}) :
    policy_name => (
      strcontains(policy_name, "dynamodb") ? [local.dynamodb_arn] :
      strcontains(policy_name, "s3") ? [local.s3_arn, "${local.s3_arn}/*"] :
      strcontains(policy_name, "cloudwatch-create-log-group") ? ["*"] :
      strcontains(policy_name, "cloudwatch-write-log-event") ? ["${local.put_lambda_cw_log_arn}:*"] :
      []
    )
  }

  lambda_get_policies = {
    for policy_name, p in try(local.lambda_roles_config["get_lambda_role"]["inline-policies"], {}) :
    policy_name => {
      Version = "2012-10-17"
      Statement = [
        {
          Effect   = p.Effect
          Action   = p.Api
          Resource = local.lambda_get_policy_map[policy_name]
        }
      ]
    }
  }

  lambda_put_policies = {
    for policy_name, p in try(local.lambda_roles_config["put_lambda_role"]["inline-policies"], {}) :
    policy_name => {
      Version = "2012-10-17"
      Statement = [
        {
          Effect   = p.Effect
          Action   = p.Api
          Resource = local.lambda_put_policy_map[policy_name]
        }
      ]
    }
  }

  lambda_get_role = {
    "role-name"          = "${var.project_name}-${local.lambda_roles_config["get_lambda_role"]["name"]}-${var.environment}-${local.current_region}",
    "assume-role-policy" = local.lambda_assume_policy,
    "policy-name"        = "${local.lambda_roles_config["get_lambda_role"]["name"]} inline policy",
    "policy-document"    = local.lambda_get_policies
  }

  lambda_put_role = {
    "role-name"          = "${var.project_name}-${local.lambda_roles_config["put_lambda_role"]["name"]}-${var.environment}-${local.current_region}",
    "assume-role-policy" = local.lambda_assume_policy,
    "policy-name"        = "${local.lambda_roles_config["put_lambda_role"]["name"]} inline policy",
    "policy-document"    = local.lambda_put_policies
  }

  get_function_name = local.lambda_config["lambda_functions"]["get_visitor_count_function"]["function_name"]
  put_function_name = local.lambda_config["lambda_functions"]["put_visitor_count_function"]["function_name"]

  get_function_cw_log = {
    "log_group_name"    = "/aws/lambda/${var.project_name}-${local.get_function_name}-${var.environment}-${local.current_region}",
    "log_group_class"   = local.cw_log_config["get_lambda_log_group"]["log_group_class"],
    "retention_in_days" = local.cw_log_config["get_lambda_log_group"]["retention_in_days"]
  }

  put_function_cw_log = {
    "log_group_name"    = "/aws/lambda/${var.project_name}-${local.put_function_name}-${var.environment}-${local.current_region}",
    "log_group_class"   = local.cw_log_config["post_lambda_log_group"]["log_group_class"],
    "retention_in_days" = local.cw_log_config["post_lambda_log_group"]["retention_in_days"]
  }

  lambda_common_arguments = {
    "runtime"     = local.lambda_config["common_arguments"]["runtime"],
    "timeout"     = local.lambda_config["common_arguments"]["timeout"],
    "memory-size" = local.lambda_config["common_arguments"]["memory_size"],
    "handler"     = local.lambda_config["common_arguments"]["handler"],
    "environment" = {
      DYNAMODB_TABLE_NAME = module.dynamodb.dynamodb_table_arn
    }
  }

  lambda_get_function = merge(local.lambda_common_arguments, {
    "function-name" = "${var.project_name}-${local.get_function_name}-${var.environment}-${local.current_region}",
    "description"   = local.lambda_config["lambda_functions"]["get_visitor_count_function"]["description"],
    "role_arn"      = module.iam_get_endpoint_role.iam_role_arn,
    "cw_log_group"  = module.lambda_get_cw_log_group.log_group_name,
    "source_path"   = local.lambda_config["lambda_functions"]["get_visitor_count_function"]["source_path"],
    "output_path"   = local.lambda_config["lambda_functions"]["get_visitor_count_function"]["output_path"],
  })

  lambda_put_function = merge(local.lambda_common_arguments, {
    "function-name" = "${var.project_name}-${local.put_function_name}-${var.environment}-${local.current_region}",
    "description"   = local.lambda_config["lambda_functions"]["put_visitor_count_function"]["description"],
    "cw_log_group"  = module.lambda_put_cw_log_group.log_group_name,
    "role_arn"      = module.iam_put_endpoint_role.iam_role_arn,
    "source_path"   = local.lambda_config["lambda_functions"]["put_visitor_count_function"]["source_path"],
    "output_path"   = local.lambda_config["lambda_functions"]["put_visitor_count_function"]["output_path"]
  })
}
