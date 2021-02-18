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
  type = bool
  default = false
}

variable "azure_subscription_id" {
  type = string
  default = null
}

variable "azure_resource_group" {
  type = string
  default = null
}

variable "azure_tenant_id" {
  type = string
  default = null
}
