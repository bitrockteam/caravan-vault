variable "vault_endpoint" {
  type        = string
  description = "(required) Where the vault server is"
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
  description = "(required) map of node => public ip"
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
