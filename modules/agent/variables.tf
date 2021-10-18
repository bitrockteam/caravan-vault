variable "vault_endpoint" {
  type        = string
  description = "(required) Where the vault server is"
}

variable "enable_nomad" {
  type        = string
  description = "(required) Enable Nomad cluster"
}

variable "tcp_listener" {
  type        = string
  description = "(optional) Where agent should bind in form of host:port"
  default     = "127.0.0.1:9200"
}
variable "tcp_listener_tls" {
  type        = bool
  default     = false
  description = "(optional) Should TLS be enabled on TCP listener"
}

variable "gcp_auto_auth" {
  type        = bool
  default     = false
  description = "(optional) Should agent auto authenticate via GCP's IAM"
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

variable "oci_auto_auth" {
  type        = bool
  default     = false
  description = "(optional) Should agent auto authenticate via OCI's IAM"
}
variable "oci_node_role" {
  type        = string
  default     = null
  description = "(optional) Configured OCI role of the node"
}

variable "approle_auto_auth" {
  type        = bool
  default     = false
  description = "(optional) Should agent auto authenticate via AppRole"
}

variable "aws_auto_auth" {
  type        = bool
  default     = false
  description = "(optional) Should agent auto authenticate via AWS's IAM"
}
variable "aws_node_role" {
  type        = string
  default     = null
  description = "(optional) Configured AWS role of the node"
}
variable "aws_access_key" {
  type        = string
  default     = null
  description = "(optional) Static AWS Access Key credential for authentication"
}
variable "aws_secret_key" {
  type        = string
  default     = null
  description = "(optional) Static AWS Secret Key credential for authentication"
}

variable "azure_auto_auth" {
  type        = bool
  default     = false
  description = "(optional) Should agent auto authenticate via Azure's IAM"
}
variable "azure_node_role" {
  type        = string
  default     = null
  description = "(optional) Configured Azure role of the node"
}
variable "azure_resource" {
  type        = string
  default     = "https://management.azure.com/"
  description = "(optional) A configured Azure AD application which is used as the resource for generating MSI access tokens"
}

variable "nodes_ids" {
  type        = list(string)
  description = "(required) IDs of nodes to trigger reprovision of agents"
}
variable "nodes" {
  type        = map(any)
  description = "(required) map of node => ip"
}
variable "nodes_public_ips" {
  type        = map(any)
  default     = null
  description = "(optional) map of node => public ip"
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
