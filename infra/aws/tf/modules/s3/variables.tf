# --- root/aws/tf/modules/s3/variables.tf ---

variable "s3_static_website" {
  description = "S3 static website configuration"
  type        = map(any)
}

