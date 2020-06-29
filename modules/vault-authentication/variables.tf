variable "google_authenticate" {
  type    = bool
  default = false
}

variable "google_authenticate_admin_group_name" {
  type    = string
  default = null
}

variable "vault_endpoint" {
  type    = string
  default = null
}

variable "project_id" {}
