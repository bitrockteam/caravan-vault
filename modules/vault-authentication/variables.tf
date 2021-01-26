variable "pre13_depends_on" {
  type    = any
  default = null
}
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
variable "gcp_csi" {
  type    = bool
  default = false
}
variable "gcp_cluster_node_service_account" {
  type    = string
  default = "cluster-node"
}
variable "gcp_worker_node_service_accounts" {
  type    = list(string)
  default = []
}

variable "oci_authenticate" {
  type    = bool
  default = false
}
variable "oci_home_tenancy_id" {
  type    = string
  default = null
}
variable "oci_pocnode_token_policies" {
  type    = list(string)
  default = null
}
variable "approle_authenticate" {
  type    = bool
  default = false
}
variable "pocnode_oci_dynamic_group_ocid" {
  type    = string
  default = null
}

variable "gcp_project_id" {
  type    = string
  default = null
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
variable "aws_authenticate" {
  type    = bool
  default = false
}
variable "aws_region" {
  type        = string
  default     = null
  description = "(optional) The AWS Region whose instances can authenticate"
}
variable "aws_vpc_id" {
  type        = string
  default     = null
  description = "(optional) The AWS VPC ID whose instances can authenticate"
}
variable "aws_cluster_node_iam_role_arns" {
  type        = list(string)
  default     = []
  description = "(optional) The list of AWS IAM Role ARNs that can authenticate as cluster nodes"
}
variable "aws_worker_node_iam_role_arns" {
  type        = list(string)
  default     = []
  description = "(optional) The list of AWS IAM Role ARNs that can authenticate as worker nodes"
}
