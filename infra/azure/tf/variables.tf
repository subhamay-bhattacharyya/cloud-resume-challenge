# --- root/azure/tf/variables.tf ---

variable "azure_subscription_id" {
  description = "The Azure Subscription ID"
  type        = string
}

# Optional: Uncomment if not using environment variables
# variable "azure_client_id" {
#   description = "The Azure Service Principal Client ID"
#   type        = string
#   sensitive   = true
# }
#
# variable "azure_client_secret" {
#   description = "The Azure Service Principal Client Secret"
#   type        = string
#   sensitive   = true
# }
#
# variable "azure_tenant_id" {
#   description = "The Azure Tenant ID"
#   type        = string
# }
