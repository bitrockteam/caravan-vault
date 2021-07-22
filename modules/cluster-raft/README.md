# Caravan Vault Cluster Raft

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.ssh-key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.copy_root_token](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.get_encryption_key](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.vault_cluster_node_1_init](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.vault_cluster_node_config](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.vault_cluster_node_local_service](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.vault_cluster_node_not_1_init](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [local_file.encryption_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |
| [local_file.vault_token](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_control_plane_nodes"></a> [control\_plane\_nodes](#input\_control\_plane\_nodes) | A map in form of 'node-name' => 'node's private IP' of the nodes to provision the cluster on | `map(any)` | n/a | yes |
| <a name="input_control_plane_nodes_ids"></a> [control\_plane\_nodes\_ids](#input\_control\_plane\_nodes\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_ssh_private_key"></a> [ssh\_private\_key](#input\_ssh\_private\_key) | The private key to use for SSH connection to cluster nodes | `string` | n/a | yes |
| <a name="input_aws_access_key"></a> [aws\_access\_key](#input\_aws\_access\_key) | (optional) The AWS Access Key to use for AWS KMS auto unseal. Leave null for using AWS profile or instance profile | `string` | `null` | no |
| <a name="input_aws_endpoint"></a> [aws\_endpoint](#input\_aws\_endpoint) | (optional) The custom AWS VPC Endpoint to use for AWS KMS auto unseal | `string` | `null` | no |
| <a name="input_aws_kms_key_id"></a> [aws\_kms\_key\_id](#input\_aws\_kms\_key\_id) | (optional) The AWS KMS Key ID to use for AWS KMS auto unseal | `string` | `null` | no |
| <a name="input_aws_kms_region"></a> [aws\_kms\_region](#input\_aws\_kms\_region) | (optional) The AWS KMS Region to use for AWS KMS auto unseal | `string` | `null` | no |
| <a name="input_aws_secret_key"></a> [aws\_secret\_key](#input\_aws\_secret\_key) | (optional) The AWS Secret Key to use for AWS KMS auto unseal. Leave null for using AWS profile or instance profile | `string` | `null` | no |
| <a name="input_azure_environment"></a> [azure\_environment](#input\_azure\_environment) | (optional) The Azure Cloud environment API endpoints to use. | `string` | `"AZUREPUBLICCLOUD"` | no |
| <a name="input_azure_key_name"></a> [azure\_key\_name](#input\_azure\_key\_name) | (optional) The Key Vault key to use for encryption and decryption. | `string` | `null` | no |
| <a name="input_azure_tenant_id"></a> [azure\_tenant\_id](#input\_azure\_tenant\_id) | (optional) The tenant id for the Azure Active Directory organization. | `string` | `null` | no |
| <a name="input_azure_vault_name"></a> [azure\_vault\_name](#input\_azure\_vault\_name) | (optional) The Key Vault vault to use the encryption keys for encryption and decryption. | `string` | `null` | no |
| <a name="input_control_plane_nodes_public_ips"></a> [control\_plane\_nodes\_public\_ips](#input\_control\_plane\_nodes\_public\_ips) | The public IPs of the node to SSH into them | `map(any)` | `null` | no |
| <a name="input_gcp_key"></a> [gcp\_key](#input\_gcp\_key) | n/a | `string` | `null` | no |
| <a name="input_gcp_keyring"></a> [gcp\_keyring](#input\_gcp\_keyring) | n/a | `string` | `null` | no |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | (optional) The GCP Project ID | `string` | `null` | no |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | n/a | `string` | `"global"` | no |
| <a name="input_license"></a> [license](#input\_license) | Vault license key | `string` | `""` | no |
| <a name="input_oci_crypto_endpoint"></a> [oci\_crypto\_endpoint](#input\_oci\_crypto\_endpoint) | (optional) The OCI Vault crypto endpoint | `string` | `null` | no |
| <a name="input_oci_key"></a> [oci\_key](#input\_oci\_key) | n/a | `string` | `null` | no |
| <a name="input_oci_management_endpoint"></a> [oci\_management\_endpoint](#input\_oci\_management\_endpoint) | (optional) The OCI Vault management endpoint | `string` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `""` | no |
| <a name="input_ssh_bastion_host"></a> [ssh\_bastion\_host](#input\_ssh\_bastion\_host) | The hostname of the bastion host to use for ssh into the nodes | `string` | `null` | no |
| <a name="input_ssh_bastion_port"></a> [ssh\_bastion\_port](#input\_ssh\_bastion\_port) | n/a | `string` | `"22"` | no |
| <a name="input_ssh_bastion_private_key"></a> [ssh\_bastion\_private\_key](#input\_ssh\_bastion\_private\_key) | The private key to use for SSH connection to the bastion host | `string` | `null` | no |
| <a name="input_ssh_bastion_user"></a> [ssh\_bastion\_user](#input\_ssh\_bastion\_user) | n/a | `string` | `null` | no |
| <a name="input_ssh_timeout"></a> [ssh\_timeout](#input\_ssh\_timeout) | The ssh connection timeout | `string` | `"60s"` | no |
| <a name="input_ssh_user"></a> [ssh\_user](#input\_ssh\_user) | The ssh user name to use for login into the cluster nodes | `string` | `"centos"` | no |
| <a name="input_transit_key"></a> [transit\_key](#input\_transit\_key) | n/a | `string` | `"vault_unseal_keyring"` | no |
| <a name="input_transit_mount_path"></a> [transit\_mount\_path](#input\_transit\_mount\_path) | (optional) The Vault transit engine mount path for transit auto unseal | `string` | `null` | no |
| <a name="input_transit_vault_address"></a> [transit\_vault\_address](#input\_transit\_vault\_address) | (optional) The Vault address for transit auto unseal | `string` | `null` | no |
| <a name="input_transit_vault_token"></a> [transit\_vault\_token](#input\_transit\_vault\_token) | (optional) The Vault token to access transit engine mount path for transit auto unseal | `string` | `null` | no |
| <a name="input_unseal_type"></a> [unseal\_type](#input\_unseal\_type) | The type of the unseal configuration to use | `string` | `"gcp"` | no |
| <a name="input_vault_home"></a> [vault\_home](#input\_vault\_home) | The directory where the vault's data is kept on the nodes | `string` | `"/var/lib/vault"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_consul_enc_key"></a> [consul\_enc\_key](#output\_consul\_enc\_key) | n/a |
| <a name="output_vault_address"></a> [vault\_address](#output\_vault\_address) | n/a |
| <a name="output_vault_token"></a> [vault\_token](#output\_vault\_token) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
