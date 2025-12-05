terraform {
  backend "s3" {}
}


# terraform {
#   backend "s3" {
#     bucket = var.tf-state-bucket
#     key    = local.tf-state-key
#     region = var.aws-region
#   }
# }