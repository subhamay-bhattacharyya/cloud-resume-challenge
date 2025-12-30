# --- root/aws/tf/modules/s3-bucket/variables.tf ---

variable "s3-static-website" {
  description = "S3 static website configuration"
  type        = map(any)
}

