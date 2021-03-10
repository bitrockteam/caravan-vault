# Vault Authentication module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| null | n/a |
| vault | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [null_resource](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) |
| [vault_approle_auth_backend_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_role) |
| [vault_audit](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/audit) |
| [vault_auth_backend](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/auth_backend) |
| [vault_aws_auth_backend_client](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_auth_backend_client) |
| [vault_aws_auth_backend_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_auth_backend_role) |
| [vault_azure_auth_backend_config](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/azure_auth_backend_config) |
| [vault_azure_auth_backend_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/azure_auth_backend_role) |
| [vault_gcp_auth_backend_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/gcp_auth_backend_role) |
| [vault_jwt_auth_backend](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend) |
| [vault_jwt_auth_backend_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend_role) |
| [vault_policy](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| approle\_role\_name | (optional) When using APPROLE auth provider, the role name | `string` | `null` | no |
| approle\_token\_policies | (optional) When using APPROLE auth provider, the token policies associated with the role | `list(string)` | `null` | no |
| auth\_providers | Allowed auth providers: aws, gcp, gsuite, oci, approle | `list(string)` | `[]` | no |
| aws\_cluster\_node\_iam\_role\_arns | (optional) The list of AWS IAM Role ARNs that can authenticate as cluster nodes | `list(string)` | `[]` | no |
| aws\_region | (optional) The AWS Region whose instances can authenticate | `string` | `null` | no |
| aws\_vpc\_id | (optional) The AWS VPC ID whose instances can authenticate | `string` | `null` | no |
| aws\_worker\_node\_iam\_role\_arns | (optional) The list of AWS IAM Role ARNs that can authenticate as worker nodes | `list(string)` | `[]` | no |
| azure\_client\_id | (Optional) The client id for credentials to query the Azure APIs. Currently read permissions to query compute resources are required. | `string` | `""` | no |
| azure\_client\_secret | (Optional) The client secret for credentials to query the Azure APIs. | `string` | `""` | no |
| azure\_control\_plane\_service\_principal\_ids | (optional) Defines a constraint on the service principals that can perform the login operation that they should be possess the ids specified by this field. | `list(string)` | `[]` | no |
| azure\_resource | (optional) The configured URL for the application registered in Azure Active Directory. | `string` | `"https://management.azure.com/"` | no |
| azure\_resource\_groups | (optional) Defines a constraint on the virtual machiness that can perform the login operation that they be associated with the resource group that matches the value specified by this field. | `list(string)` | `[]` | no |
| azure\_subscription\_ids | (optional) Defines a constraint on the subscriptions that can perform the login operation to ones which matches the value specified by this field. | `list(string)` | `[]` | no |
| azure\_tenant\_id | (optional) The tenant id for the Azure Active Directory organization. | `string` | `null` | no |
| azure\_worker\_plane\_service\_principal\_ids | (optional) Defines a constraint on the service principals that can perform the login operation that they should be possess the ids specified by this field. | `list(string)` | `[]` | no |
| control\_plane\_role\_name | The control plane role name | `string` | `"control-plane"` | no |
| control\_plane\_token\_policies\_name | The policies associated with control plane roles | `list(string)` | <pre>[<br>  "consul-agent-role",<br>  "nomad-server"<br>]</pre> | no |
| gcp\_control\_plane\_service\_accounts | (optional) When using GCP auth provider, the list of control plane service accounts | `list(string)` | `[]` | no |
| gcp\_project\_id | (optional) When using GCP auth provider, the Project ID | `string` | `null` | no |
| gcp\_worker\_plane\_service\_accounts | (optional) When using GCP auth provider, the list of worker plane service accounts | `list(string)` | `[]` | no |
| gsuite\_allowed\_redirect\_uris | (optional) When using GSUITE auth provider, the allowed redirect uris | `list(string)` | `[]` | no |
| gsuite\_client\_id | (optional) When using GSUITE auth provider, the client id | `string` | `null` | no |
| gsuite\_client\_secret | (optional) When using GSUITE auth provider, the client secret | `string` | `null` | no |
| gsuite\_default\_role | (optional) When using GSUITE auth provider, the name of the default role | `string` | `null` | no |
| gsuite\_default\_role\_policies | (optional) When using GSUITE auth provider, the list of policies associated with the default role | `list(string)` | `[]` | no |
| gsuite\_domain | (optional) When using GSUITE auth provider, the domain name | `string` | `null` | no |
| oci\_dynamic\_group\_ocid | (optional) When using OCI auth provider, the dynamic group ocid | `string` | `null` | no |
| oci\_home\_tenancy\_id | (optional) When using OCI auth provider, the Tenant Id | `string` | `null` | no |
| oci\_role\_name | (optional) When using OCI auth provider, the role name to create | `string` | `null` | no |
| vault\_endpoint | Fully qualified vault address as used in VAULT\_ADDR | `string` | `null` | no |
| worker\_plane\_role\_name | The worker plane role name | `string` | `"worker-plane"` | no |
| worker\_plane\_token\_policies\_name | The policies associated with worker plane roles | `list(string)` | <pre>[<br>  "consul-agent-role",<br>  "nomad-app-devs-volumes"<br>]</pre> | no |

## Outputs

No output.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
