variable "control_plane_nodes" {
  type        = map(any)
  description = "A map in form of 'node-name' => 'node's private IP' of the nodes to provision the cluster on"
}
variable "control_plane_nodes_public_ips" {
  type        = map(any)
  description = "The public IPs of the node to SSH into them"
  default     = null
}
variable "control_plane_nodes_ids" {
  type = list(string)
}
variable "vault_home" {
  type        = string
  description = "The directory where the vault's data is kept on the nodes"
  default     = "/var/lib/vault"
}
variable "ssh_private_key" {
  type        = string
  description = "The private key to use for SSH connection to cluster nodes"
}
variable "ssh_user" {
  type        = string
  description = "The ssh user name to use for login into the cluster nodes"
  default     = "centos"
}
variable "ssh_timeout" {
  type        = string
  description = "The ssh connection timeout"
  default     = "60s"
}
variable "ssh_bastion_host" {
  type        = string
  description = "The hostname of the bastion host to use for ssh into the nodes"
  default     = null
}
variable "ssh_bastion_port" {
  type    = string
  default = "22"
}
variable "ssh_bastion_private_key" {
  type        = string
  description = "The private key to use for SSH connection to the bastion host"
  default     = null
}
variable "ssh_bastion_user" {
  type    = string
  default = null
}
variable "unseal_type" {
  type        = string
  description = "The type of the unseal configuration to use"
  default     = "gcp"
  validation {
    condition     = contains(toset(["gcp", "oci", "transit", "aws", "azure"]), var.unseal_type)
    error_message = "Unsupported unseal_type value. Supported values: gcp, oci, transit, aws, azure."
  }
}
variable "prefix" {
  type    = string
  default = ""
}

// GCP
variable "gcp_project_id" {
  type        = string
  default     = null
  description = "(optional) The GCP Project ID"
}
variable "gcp_region" {
  type    = string
  default = "global"
}
variable "gcp_keyring" {
  type    = string
  default = null
}
variable "gcp_key" {
  type    = string
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
  type    = string
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

// AZURE
variable "azure_tenant_id" {
  type        = string
  default     = null
  description = "(optional) The tenant id for the Azure Active Directory organization."
}
variable "azure_environment" {
  type        = string
  default     = "AZUREPUBLICCLOUD"
  description = "(optional) The Azure Cloud environment API endpoints to use."
}
variable "azure_vault_name" {
  type        = string
  default     = null
  description = "(optional) The Key Vault vault to use the encryption keys for encryption and decryption."
}
variable "azure_key_name" {
  type        = string
  default     = null
  description = "(optional) The Key Vault key to use for encryption and decryption."
}
variable "license" {
  type        = string
  default     = ""
  description = "Vault license key"
}