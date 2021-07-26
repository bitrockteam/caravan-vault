variable "vault_endpoint" {
  type        = string
  default     = null
  description = "Fully qualified vault address as used in VAULT_ADDR"
}
variable "auth_providers" {
  type        = list(string)
  default     = []
  description = "Allowed auth providers: aws, gcp, gsuite, oci, approle"
}

variable "control_plane_token_policies_name" {
  type = list(string)
  default = [
    "consul-agent-role",
    "nomad-server"
  ]
  description = "The policies associated with control plane roles"
}
variable "worker_plane_token_policies_name" {
  type = list(string)
  default = [
    "consul-agent-role",
    "nomad-app-devs-volumes"
  ]
  description = "The policies associated with worker plane roles"
}
variable "control_plane_role_name" {
  type        = string
  default     = "control-plane"
  description = "The control plane role name"
}
variable "worker_plane_role_name" {
  type        = string
  default     = "worker-plane"
  description = "The worker plane role name"
}

// GCP configs
variable "gcp_control_plane_service_accounts" {
  type        = list(string)
  default     = []
  description = "(optional) When using GCP auth provider, the list of control plane service accounts"
}
variable "gcp_worker_plane_service_accounts" {
  type        = list(string)
  default     = []
  description = "(optional) When using GCP auth provider, the list of worker plane service accounts"
}
variable "gcp_project_id" {
  type        = string
  default     = null
  description = "(optional) When using GCP auth provider, the Project ID"
}

// OCI configs
variable "oci_home_tenancy_id" {
  type        = string
  default     = null
  description = "(optional) When using OCI auth provider, the Tenant Id"
}
variable "oci_role_name" {
  type        = string
  default     = null
  description = "(optional) When using OCI auth provider, the role name to create"
}
variable "oci_dynamic_group_ocid" {
  type        = string
  default     = null
  description = "(optional) When using OCI auth provider, the dynamic group ocid"
}

// APPROLE configs
variable "approle_token_policies" {
  type        = list(string)
  default     = null
  description = "(optional) When using APPROLE auth provider, the token policies associated with the role"
}
variable "approle_role_name" {
  type        = string
  default     = null
  description = "(optional) When using APPROLE auth provider, the role name"
}

// GSUITE configs
variable "gsuite_domain" {
  type        = string
  default     = null
  description = "(optional) When using GSUITE auth provider, the domain name"
}
variable "gsuite_client_id" {
  type        = string
  default     = null
  description = "(optional) When using GSUITE auth provider, the client id"
}
variable "gsuite_client_secret" {
  type        = string
  default     = null
  description = "(optional) When using GSUITE auth provider, the client secret"
  sensitive   = true
}
variable "gsuite_default_role" {
  type        = string
  default     = null
  description = "(optional) When using GSUITE auth provider, the name of the default role"
}
variable "gsuite_default_role_policies" {
  type        = list(string)
  default     = []
  description = "(optional) When using GSUITE auth provider, the list of policies associated with the default role"
}
variable "gsuite_allowed_redirect_uris" {
  type        = list(string)
  default     = []
  description = "(optional) When using GSUITE auth provider, the allowed redirect uris"
}

// AWS configs
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

// Azure
variable "azure_tenant_id" {
  type        = string
  default     = null
  description = "(optional) The tenant id for the Azure Active Directory organization."
}
variable "azure_resource" {
  type        = string
  default     = "https://management.azure.com/"
  description = "(optional) The configured URL for the application registered in Azure Active Directory."
}
variable "azure_control_plane_service_principal_ids" {
  type        = list(string)
  default     = []
  description = "(optional) Defines a constraint on the service principals that can perform the login operation that they should be possess the ids specified by this field."
}
variable "azure_worker_plane_service_principal_ids" {
  type        = list(string)
  default     = []
  description = "(optional) Defines a constraint on the service principals that can perform the login operation that they should be possess the ids specified by this field."
}
variable "azure_resource_groups" {
  type        = list(string)
  default     = []
  description = "(optional) Defines a constraint on the virtual machiness that can perform the login operation that they be associated with the resource group that matches the value specified by this field."
}
variable "azure_subscription_ids" {
  type        = list(string)
  default     = []
  description = "(optional) Defines a constraint on the subscriptions that can perform the login operation to ones which matches the value specified by this field."
}
variable "azure_client_id" {
  type        = string
  default     = null
  description = "(Optional) The client id for credentials to query the Azure APIs. Currently read permissions to query compute resources are required."
}
variable "azure_client_secret" {
  type        = string
  default     = null
  description = "(Optional) The client secret for credentials to query the Azure APIs."
  sensitive   = true
}
