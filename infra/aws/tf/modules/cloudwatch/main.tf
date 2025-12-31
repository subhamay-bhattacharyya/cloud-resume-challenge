# --- root/aws/tf/modules/cloudwatch/main.tf ---

resource "aws_cloudwatch_log_group" "this" {
  name              = var.cloudwatch_configuration["log_group_name"]
  log_group_class   = var.cloudwatch_configuration["log_group_class"]
  retention_in_days = var.cloudwatch_configuration["retention_in_days"]
}