variable "gcp_csi" {
  type        = bool
  description = "Enable creation of secrets used by GCP CSI setup"
  default     = false
}

variable "gcp_project_id" {
  type        = string
  default     = null
  description = "(optional) The GCP Project ID"
}

variable "azure_csi" {
  type        = bool
  default     = false
  description = "Setup secrets needed for Azure CSI."
}

variable "azure_subscription_id" {
  type        = string
  default     = null
  description = "(optional) The Azure Subscription ID."
}

variable "azure_resource_group" {
  type        = string
  default     = null
  description = "(optional) The Azure Resource Group."
}

variable "azure_tenant_id" {
  type        = string
  default     = null
  description = "(optional) The Azure Tenant ID."
}

variable "azure_client_id" {
  type        = string
  default     = null
  description = "(optional) The Azure Client ID."
}

variable "azure_client_secret" {
  type        = string
  default     = null
  description = "(optional) The Azure Client Secret."
}
