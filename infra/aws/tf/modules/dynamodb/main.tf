# --- root/aws/tf/modules/dynamodb/main.tf ---

resource "aws_dynamodb_table" "this" {
  name = var.dynamodb_table["name"]

  billing_mode = var.dynamodb_table["billing-mode"]

  hash_key = var.dynamodb_table["hash-key-name"]

  attribute {
    name = var.dynamodb_table["hash-key-name"]
    type = var.dynamodb_table["hash-key-type"]
  }

  point_in_time_recovery {
    enabled = var.dynamodb_table["pitr-enabled"]
  }

}
