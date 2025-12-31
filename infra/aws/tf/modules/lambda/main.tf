# --- root/aws/tf/modules/lambda/main.tf ---

# Package the Lambda function code
data "archive_file" "function_code" {
  type        = "zip"
  source_file = "${path.root}/${var.lambda_function["source_path"]}"
  output_path = "${path.root}/${var.lambda_function["output_path"]}"
}

resource "aws_lambda_function" "this" {
  function_name = var.lambda_function["function-name"]
  description   = var.lambda_function["description"]
  handler       = var.lambda_function["handler"]
  logging_config {
    log_group  = var.lambda_function["cw_log_group"]
    log_format = "JSON"
  }

  runtime  = var.lambda_function["runtime"]
  role     = var.lambda_function["role_arn"]
  filename = data.archive_file.function_code.output_path

  timeout     = lookup(var.lambda_function, "timeout", 10)
  memory_size = lookup(var.lambda_function, "memory-size", 128)

  environment {
    variables = var.lambda_function["environment"]
  }

  source_code_hash = data.archive_file.function_code.output_base64sha256
}