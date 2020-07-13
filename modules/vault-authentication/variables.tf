variable "vault_endpoint" {
  type    = string
  default = null
}

variable "gcp_authenticate" {
  type    = bool
  default = false
}

variable "gcp_authenticate_admin_group_name" {
  type    = string
  default = null
}
variable "gcp_cluster_node_service_account" {
  type = string
  default = "cluster-node"
}
variable "gcp_worker_node_service_accounts" {
  type = list(string)
  default = []
}


variable "gcp_project_id" {
  type = string
}

variable "gsuite_authenticate" {
  type    = bool
  default = false
}
variable "gsuite_domain" {
  type    = string
  default = null
}
variable "gsuite_client_id" {
  type    = string
  default = null
}
variable "gsuite_client_secret" {
  type    = string
  default = null
}
variable "gsuite_default_role" {
  type    = string
  default = null
}
variable "gsuite_default_role_policies" {
  type    = list(string)
  default = []
}
variable "gsuite_allowed_redirect_uris" {
  type    = list(string)
  default = []
}
