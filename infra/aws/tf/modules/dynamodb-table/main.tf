# --- root/aws/tf/modules/dynamodb/main.tf ---

resource "aws_dynamodb_table" "this" {
  name         = var.dynamodb-tables["dynamodb-table"]["name"]
  billing_mode = var.dynamodb-tables["dynamodb-table"]["billing-mode"]

  hash_key = var.dynamodb-tables["dynamodb-table"]["hash-key-name"]

  attribute {
    name = var.dynamodb-tables["dynamodb-table"]["hash-key-name"]
    type = var.dynamodb-tables["dynamodb-table"]["hash-key-type"]
  }

  point_in_time_recovery {
    enabled = var.dynamodb-tables["dynamodb-table"]["point-in-time-recovery-enabled"]
  }

}
