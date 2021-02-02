variable "control_plane_nodes" {
  type = map(any)
}
variable "control_plane_nodes_public_ips" {
  type    = map(any)
  default = null
}
variable "control_plane_nodes_ids" {
  type = list(string)
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
  validation {
    condition     = contains(toset(["gcp", "oci", "transit", "aws"]), var.unseal_type)
    error_message = "Unsupported unseal_type value. Supported values: gcp, oci, transit, aws."
  }
}
variable "prefix" {
  type    = string
  default = ""
}

// GCP
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
variable "gcp_region" {
  type = string
  default = "global"
}
variable "gcp_keyring" {
  type = string
  default = null
}
variable "gcp_key" {
  type = string
  default = null
}

// OCI
variable "oci_crypto_endpoint" {
  type        = string
  default     = null
  description = "(optional) The OCI Vault crypto endpoint"
}
variable "oci_management_endpoint" {
  type        = string
  default     = null
  description = "(optional) The OCI Vault management endpoint"
}
variable "oci_key" {
  type = string
  default = null
}

// TRANSIT
variable "transit_vault_address" {
  type        = string
  default     = null
  description = "(optional) The Vault address for transit auto unseal"
}
variable "transit_mount_path" {
  type        = string
  default     = null
  description = "(optional) The Vault transit engine mount path for transit auto unseal"
}
variable "transit_vault_token" {
  type        = string
  default     = null
  description = "(optional) The Vault token to access transit engine mount path for transit auto unseal"
}
variable "transit_key" {
  type    = string
  default = "vault_unseal_keyring"
}

// AWS
variable "aws_kms_region" {
  type        = string
  default     = null
  description = "(optional) The AWS KMS Region to use for AWS KMS auto unseal"
}
variable "aws_kms_key_id" {
  type        = string
  default     = null
  description = "(optional) The AWS KMS Key ID to use for AWS KMS auto unseal"
}
variable "aws_access_key" {
  type        = string
  default     = null
  description = "(optional) The AWS Access Key to use for AWS KMS auto unseal. Leave null for using AWS profile or instance profile"
}
variable "aws_secret_key" {
  type        = string
  default     = null
  description = "(optional) The AWS Secret Key to use for AWS KMS auto unseal. Leave null for using AWS profile or instance profile"
}
variable "aws_endpoint" {
  type        = string
  default     = null
  description = "(optional) The custom AWS VPC Endpoint to use for AWS KMS auto unseal"
}
