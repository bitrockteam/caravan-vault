# Cluster Raft module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| local | n/a |
| null | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [local_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) |
| [null_resource](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_access\_key | (optional) The AWS Access Key to use for AWS KMS auto unseal. Leave null for using AWS profile or instance profile | `string` | `null` | no |
| aws\_endpoint | (optional) The custom AWS VPC Endpoint to use for AWS KMS auto unseal | `string` | `null` | no |
| aws\_kms\_key\_id | (optional) The AWS KMS Key ID to use for AWS KMS auto unseal | `string` | `null` | no |
| aws\_kms\_region | (optional) The AWS KMS Region to use for AWS KMS auto unseal | `string` | `null` | no |
| aws\_secret\_key | (optional) The AWS Secret Key to use for AWS KMS auto unseal. Leave null for using AWS profile or instance profile | `string` | `null` | no |
| azure\_environment | (optional) The Azure Cloud environment API endpoints to use. | `string` | `"AZUREPUBLICCLOUD"` | no |
| azure\_key\_name | (optional) The Key Vault key to use for encryption and decryption. | `string` | `null` | no |
| azure\_tenant\_id | (optional) The tenant id for the Azure Active Directory organization. | `string` | `null` | no |
| azure\_vault\_name | (optional) The Key Vault vault to use the encryption keys for encryption and decryption. | `string` | `null` | no |
| control\_plane\_nodes | A map in form of 'node-name' => 'node's private IP' of the nodes to provision the cluster on | `map(any)` | n/a | yes |
| control\_plane\_nodes\_ids | n/a | `list(string)` | n/a | yes |
| control\_plane\_nodes\_public\_ips | The public IPs of the node to SSH into them | `map(any)` | `null` | no |
| gcp\_key | n/a | `string` | `null` | no |
| gcp\_keyring | n/a | `string` | `null` | no |
| gcp\_project\_id | (optional) The GCP Project ID | `string` | `null` | no |
| gcp\_region | n/a | `string` | `"global"` | no |
| license | Vault license key | `string` | `""` | no |
| oci\_crypto\_endpoint | (optional) The OCI Vault crypto endpoint | `string` | `null` | no |
| oci\_key | n/a | `string` | `null` | no |
| oci\_management\_endpoint | (optional) The OCI Vault management endpoint | `string` | `null` | no |
| prefix | n/a | `string` | `""` | no |
| ssh\_bastion\_host | The hostname of the bastion host to use for ssh into the nodes | `string` | `null` | no |
| ssh\_bastion\_port | n/a | `string` | `"22"` | no |
| ssh\_bastion\_private\_key | The private key to use for SSH connection to the bastion host | `string` | `null` | no |
| ssh\_bastion\_user | n/a | `string` | `null` | no |
| ssh\_private\_key | The private key to use for SSH connection to cluster nodes | `string` | n/a | yes |
| ssh\_timeout | The ssh connection timeout | `string` | `"60s"` | no |
| ssh\_user | The ssh user name to use for login into the cluster nodes | `string` | `"centos"` | no |
| transit\_key | n/a | `string` | `"vault_unseal_keyring"` | no |
| transit\_mount\_path | (optional) The Vault transit engine mount path for transit auto unseal | `string` | `null` | no |
| transit\_vault\_address | (optional) The Vault address for transit auto unseal | `string` | `null` | no |
| transit\_vault\_token | (optional) The Vault token to access transit engine mount path for transit auto unseal | `string` | `null` | no |
| unseal\_type | The type of the unseal configuration to use | `string` | `"gcp"` | no |
| vault\_home | The directory where the vault's data is kept on the nodes | `string` | `"/var/lib/vault"` | no |

## Outputs

| Name | Description |
|------|-------------|
| vault\_address | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
