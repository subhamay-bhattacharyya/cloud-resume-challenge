# --- root/aws/tf/modules/acm-certificate/variables.tf ---

variable "domain-name" {
  description = "Primary domain name for the certificate (e.g., example.com)"
  type        = string
}

variable "subject-alternative-names" {
  description = "Additional names (e.g., ['www.example.com'])."
  type        = list(string)
  default     = []
}

variable "project-name" {
  description = "name of the project"
  type        = string
  default     = "Cloud Reusable Challenge"
}