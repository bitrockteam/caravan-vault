# Caravan Vault Authentication

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_vault"></a> [vault](#provider\_vault) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.oci_auth_config](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [vault_approle_auth_backend_role.role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_role) | resource |
| [vault_audit.syslog](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/audit) | resource |
| [vault_auth_backend.approle](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/auth_backend) | resource |
| [vault_auth_backend.aws](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/auth_backend) | resource |
| [vault_auth_backend.azure](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/auth_backend) | resource |
| [vault_auth_backend.gcp](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/auth_backend) | resource |
| [vault_auth_backend.oci](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/auth_backend) | resource |
| [vault_aws_auth_backend_client.config](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_auth_backend_client) | resource |
| [vault_aws_auth_backend_role.aws_cluster_node](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_auth_backend_role) | resource |
| [vault_aws_auth_backend_role.aws_worker_node](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_auth_backend_role) | resource |
| [vault_azure_auth_backend_config.config](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/azure_auth_backend_config) | resource |
| [vault_azure_auth_backend_role.control_plane](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/azure_auth_backend_role) | resource |
| [vault_azure_auth_backend_role.worker_plane](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/azure_auth_backend_role) | resource |
| [vault_gcp_auth_backend_role.gcp_cluster_node](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/gcp_auth_backend_role) | resource |
| [vault_gcp_auth_backend_role.gcp_worker_node](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/gcp_auth_backend_role) | resource |
| [vault_jwt_auth_backend.gsuite](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend) | resource |
| [vault_jwt_auth_backend_role.gsuite_default_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend_role) | resource |
| [vault_policy.oci_reader](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_approle_role_name"></a> [approle\_role\_name](#input\_approle\_role\_name) | (optional) When using APPROLE auth provider, the role name | `string` | `null` | no |
| <a name="input_approle_token_policies"></a> [approle\_token\_policies](#input\_approle\_token\_policies) | (optional) When using APPROLE auth provider, the token policies associated with the role | `list(string)` | `null` | no |
| <a name="input_auth_providers"></a> [auth\_providers](#input\_auth\_providers) | Allowed auth providers: aws, gcp, gsuite, oci, approle | `list(string)` | `[]` | no |
| <a name="input_aws_cluster_node_iam_role_arns"></a> [aws\_cluster\_node\_iam\_role\_arns](#input\_aws\_cluster\_node\_iam\_role\_arns) | (optional) The list of AWS IAM Role ARNs that can authenticate as cluster nodes | `list(string)` | `[]` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | (optional) The AWS Region whose instances can authenticate | `string` | `null` | no |
| <a name="input_aws_vpc_id"></a> [aws\_vpc\_id](#input\_aws\_vpc\_id) | (optional) The AWS VPC ID whose instances can authenticate | `string` | `null` | no |
| <a name="input_aws_worker_node_iam_role_arns"></a> [aws\_worker\_node\_iam\_role\_arns](#input\_aws\_worker\_node\_iam\_role\_arns) | (optional) The list of AWS IAM Role ARNs that can authenticate as worker nodes | `list(string)` | `[]` | no |
| <a name="input_azure_client_id"></a> [azure\_client\_id](#input\_azure\_client\_id) | (Optional) The client id for credentials to query the Azure APIs. Currently read permissions to query compute resources are required. | `string` | `null` | no |
| <a name="input_azure_client_secret"></a> [azure\_client\_secret](#input\_azure\_client\_secret) | (Optional) The client secret for credentials to query the Azure APIs. | `string` | `null` | no |
| <a name="input_azure_control_plane_service_principal_ids"></a> [azure\_control\_plane\_service\_principal\_ids](#input\_azure\_control\_plane\_service\_principal\_ids) | (optional) Defines a constraint on the service principals that can perform the login operation that they should be possess the ids specified by this field. | `list(string)` | `[]` | no |
| <a name="input_azure_resource"></a> [azure\_resource](#input\_azure\_resource) | (optional) The configured URL for the application registered in Azure Active Directory. | `string` | `"https://management.azure.com/"` | no |
| <a name="input_azure_resource_groups"></a> [azure\_resource\_groups](#input\_azure\_resource\_groups) | (optional) Defines a constraint on the virtual machiness that can perform the login operation that they be associated with the resource group that matches the value specified by this field. | `list(string)` | `[]` | no |
| <a name="input_azure_subscription_ids"></a> [azure\_subscription\_ids](#input\_azure\_subscription\_ids) | (optional) Defines a constraint on the subscriptions that can perform the login operation to ones which matches the value specified by this field. | `list(string)` | `[]` | no |
| <a name="input_azure_tenant_id"></a> [azure\_tenant\_id](#input\_azure\_tenant\_id) | (optional) The tenant id for the Azure Active Directory organization. | `string` | `null` | no |
| <a name="input_azure_worker_plane_service_principal_ids"></a> [azure\_worker\_plane\_service\_principal\_ids](#input\_azure\_worker\_plane\_service\_principal\_ids) | (optional) Defines a constraint on the service principals that can perform the login operation that they should be possess the ids specified by this field. | `list(string)` | `[]` | no |
| <a name="input_control_plane_role_name"></a> [control\_plane\_role\_name](#input\_control\_plane\_role\_name) | The control plane role name | `string` | `"control-plane"` | no |
| <a name="input_control_plane_token_policies_name"></a> [control\_plane\_token\_policies\_name](#input\_control\_plane\_token\_policies\_name) | The policies associated with control plane roles | `list(string)` | <pre>[<br>  "consul-agent-role",<br>  "nomad-server"<br>]</pre> | no |
| <a name="input_gcp_control_plane_service_accounts"></a> [gcp\_control\_plane\_service\_accounts](#input\_gcp\_control\_plane\_service\_accounts) | (optional) When using GCP auth provider, the list of control plane service accounts | `list(string)` | `[]` | no |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | (optional) When using GCP auth provider, the Project ID | `string` | `null` | no |
| <a name="input_gcp_worker_plane_service_accounts"></a> [gcp\_worker\_plane\_service\_accounts](#input\_gcp\_worker\_plane\_service\_accounts) | (optional) When using GCP auth provider, the list of worker plane service accounts | `list(string)` | `[]` | no |
| <a name="input_gsuite_allowed_redirect_uris"></a> [gsuite\_allowed\_redirect\_uris](#input\_gsuite\_allowed\_redirect\_uris) | (optional) When using GSUITE auth provider, the allowed redirect uris | `list(string)` | `[]` | no |
| <a name="input_gsuite_client_id"></a> [gsuite\_client\_id](#input\_gsuite\_client\_id) | (optional) When using GSUITE auth provider, the client id | `string` | `null` | no |
| <a name="input_gsuite_client_secret"></a> [gsuite\_client\_secret](#input\_gsuite\_client\_secret) | (optional) When using GSUITE auth provider, the client secret | `string` | `null` | no |
| <a name="input_gsuite_default_role"></a> [gsuite\_default\_role](#input\_gsuite\_default\_role) | (optional) When using GSUITE auth provider, the name of the default role | `string` | `null` | no |
| <a name="input_gsuite_default_role_policies"></a> [gsuite\_default\_role\_policies](#input\_gsuite\_default\_role\_policies) | (optional) When using GSUITE auth provider, the list of policies associated with the default role | `list(string)` | `[]` | no |
| <a name="input_gsuite_domain"></a> [gsuite\_domain](#input\_gsuite\_domain) | (optional) When using GSUITE auth provider, the domain name | `string` | `null` | no |
| <a name="input_oci_dynamic_group_ocid"></a> [oci\_dynamic\_group\_ocid](#input\_oci\_dynamic\_group\_ocid) | (optional) When using OCI auth provider, the dynamic group ocid | `string` | `null` | no |
| <a name="input_oci_home_tenancy_id"></a> [oci\_home\_tenancy\_id](#input\_oci\_home\_tenancy\_id) | (optional) When using OCI auth provider, the Tenant Id | `string` | `null` | no |
| <a name="input_oci_role_name"></a> [oci\_role\_name](#input\_oci\_role\_name) | (optional) When using OCI auth provider, the role name to create | `string` | `null` | no |
| <a name="input_vault_endpoint"></a> [vault\_endpoint](#input\_vault\_endpoint) | Fully qualified vault address as used in VAULT\_ADDR | `string` | `null` | no |
| <a name="input_worker_plane_role_name"></a> [worker\_plane\_role\_name](#input\_worker\_plane\_role\_name) | The worker plane role name | `string` | `"worker-plane"` | no |
| <a name="input_worker_plane_token_policies_name"></a> [worker\_plane\_token\_policies\_name](#input\_worker\_plane\_token\_policies\_name) | The policies associated with worker plane roles | `list(string)` | <pre>[<br>  "consul-agent-role",<br>  "nomad-app-devs-volumes"<br>]</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
