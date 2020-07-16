variable "cluster_nodes" {
  type = map(any)
}
variable "cluster_nodes_public_ips" {
  type    = map(any)
  default = null
}
variable "vault_home" {
  type    = string
  default = "/var/lib/vault"
}
variable "ssh_private_key" {
  type = string
}
variable "ssh_user" {
  type    = string
  default = "centos"
}
variable "ssh_timeout" {
  type    = string
  default = "60s"
}
variable "ssh_bastion_host" {
  type    = string
  default = null
}
variable "ssh_bastion_port" {
  type    = string
  default = "22"
}
variable "ssh_bastion_private_key" {
  type    = string
  default = null
}
variable "ssh_bastion_user" {
  type    = string
  default = null
}

variable "unseal_type" {
  type    = string
  default = "gcp"
}
variable "unseal_region" {
  type    = string
  default = "global"
}
variable "unseal_keyring" {
  type    = string
  default = "vault_unseal_keyring"
}
variable "unseal_key" {
  type    = string
  default = "vault_unseal_keyring"
}
variable "unseal_project_id" {
  type    = string
  default = ""
}
variable "cluster_nodes_ids" {
  type = list(string)
}

variable "gcp_node_role" {
  type        = string
  default     = null
  description = "(optional) Configured GCP role of the node"
}
variable "gcp_service_account" {
  type        = string
  default     = null
  description = "(optional) Configured GCP service account"
}
variable "gcp_project_id" {
  type        = string
  default     = null
  description = "(optional) The GCP Project ID"
}

variable "unseal_crypto_endpoint" {
  type        = string
  default     = null
  description = "(optional) The OCI Vault crypto endpoint"
}
variable "unseal_management_endpoint" {
  type        = string
  default     = null
  description = "(optional) The OCI Vault management endpoint"
}
