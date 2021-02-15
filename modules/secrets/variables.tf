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
