# Agent module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.vault_agent_local_service](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.vault_approle_agent_config](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.vault_aws_agent_config](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.vault_azure_agent_config](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.vault_gcp_agent_config](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.vault_oci_agent_config](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.vault_oci_agent_hook](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_nodes"></a> [nodes](#input\_nodes) | (required) map of node => ip | `map(any)` | n/a | yes |
| <a name="input_nodes_ids"></a> [nodes\_ids](#input\_nodes\_ids) | (required) IDs of nodes to trigger reprovision of agents | `list(string)` | n/a | yes |
| <a name="input_ssh_private_key"></a> [ssh\_private\_key](#input\_ssh\_private\_key) | n/a | `string` | n/a | yes |
| <a name="input_vault_endpoint"></a> [vault\_endpoint](#input\_vault\_endpoint) | (required) Where the vault server is | `string` | n/a | yes |
| <a name="input_approle_auto_auth"></a> [approle\_auto\_auth](#input\_approle\_auto\_auth) | (optional) Should agent auto authenticate via AppRole | `bool` | `false` | no |
| <a name="input_aws_access_key"></a> [aws\_access\_key](#input\_aws\_access\_key) | (optional) Static AWS Access Key credential for authentication | `string` | `null` | no |
| <a name="input_aws_auto_auth"></a> [aws\_auto\_auth](#input\_aws\_auto\_auth) | (optional) Should agent auto authenticate via AWS's IAM | `bool` | `false` | no |
| <a name="input_aws_node_role"></a> [aws\_node\_role](#input\_aws\_node\_role) | (optional) Configured AWS role of the node | `string` | `null` | no |
| <a name="input_aws_secret_key"></a> [aws\_secret\_key](#input\_aws\_secret\_key) | (optional) Static AWS Secret Key credential for authentication | `string` | `null` | no |
| <a name="input_azure_auto_auth"></a> [azure\_auto\_auth](#input\_azure\_auto\_auth) | (optional) Should agent auto authenticate via Azure's IAM | `bool` | `false` | no |
| <a name="input_azure_node_role"></a> [azure\_node\_role](#input\_azure\_node\_role) | (optional) Configured Azure role of the node | `string` | `null` | no |
| <a name="input_azure_resource"></a> [azure\_resource](#input\_azure\_resource) | (optional) A configured Azure AD application which is used as the resource for generating MSI access tokens | `string` | `"https://management.azure.com/"` | no |
| <a name="input_gcp_auto_auth"></a> [gcp\_auto\_auth](#input\_gcp\_auto\_auth) | (optional) Should agent auto authenticate via GCP's IAM | `bool` | `false` | no |
| <a name="input_gcp_node_role"></a> [gcp\_node\_role](#input\_gcp\_node\_role) | (optional) Configured GCP role of the node | `string` | `null` | no |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | (optional) The GCP Project ID | `string` | `null` | no |
| <a name="input_gcp_service_account"></a> [gcp\_service\_account](#input\_gcp\_service\_account) | (optional) Configured GCP service account | `string` | `null` | no |
| <a name="input_nodes_public_ips"></a> [nodes\_public\_ips](#input\_nodes\_public\_ips) | (optional) map of node => public ip | `map(any)` | `null` | no |
| <a name="input_oci_auto_auth"></a> [oci\_auto\_auth](#input\_oci\_auto\_auth) | (optional) Should agent auto authenticate via OCI's IAM | `bool` | `false` | no |
| <a name="input_oci_node_role"></a> [oci\_node\_role](#input\_oci\_node\_role) | (optional) Configured OCI role of the node | `string` | `null` | no |
| <a name="input_ssh_bastion_host"></a> [ssh\_bastion\_host](#input\_ssh\_bastion\_host) | n/a | `string` | `null` | no |
| <a name="input_ssh_bastion_port"></a> [ssh\_bastion\_port](#input\_ssh\_bastion\_port) | n/a | `string` | `"22"` | no |
| <a name="input_ssh_bastion_private_key"></a> [ssh\_bastion\_private\_key](#input\_ssh\_bastion\_private\_key) | n/a | `string` | `null` | no |
| <a name="input_ssh_bastion_user"></a> [ssh\_bastion\_user](#input\_ssh\_bastion\_user) | n/a | `string` | `null` | no |
| <a name="input_ssh_timeout"></a> [ssh\_timeout](#input\_ssh\_timeout) | n/a | `string` | `"60s"` | no |
| <a name="input_ssh_user"></a> [ssh\_user](#input\_ssh\_user) | n/a | `string` | `"centos"` | no |
| <a name="input_tcp_listener"></a> [tcp\_listener](#input\_tcp\_listener) | (optional) Where agent should bind in form of host:port | `string` | `"127.0.0.1:9200"` | no |
| <a name="input_tcp_listener_tls"></a> [tcp\_listener\_tls](#input\_tcp\_listener\_tls) | (optional) Should TLS be enabled on TCP listener | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
