# --- root/aws/tf/modules/iam/main.tf ---

resource "aws_iam_role" "this" {
  name               = var.lambda_role["role-name"]
  assume_role_policy = jsonencode(var.lambda_role["assume-role-policy"])
}

resource "aws_iam_role_policy" "this" {
  for_each = var.lambda_role["policy-document"]

  role   = aws_iam_role.this.id
  name   = each.key
  policy = jsonencode(each.value)
}