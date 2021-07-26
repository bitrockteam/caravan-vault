# Caravan Vault Secrets

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_azure_secret_backend.azure](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/azure_secret_backend) | resource |
| [vault_azure_secret_backend_role.contributor](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/azure_secret_backend_role) | resource |
| [vault_generic_secret.pd_csi_sa_credentials](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_client_id"></a> [azure\_client\_id](#input\_azure\_client\_id) | (optional) The Azure Client ID. | `string` | `null` | no |
| <a name="input_azure_client_secret"></a> [azure\_client\_secret](#input\_azure\_client\_secret) | (optional) The Azure Client Secret. | `string` | `null` | no |
| <a name="input_azure_csi"></a> [azure\_csi](#input\_azure\_csi) | Setup secrets needed for Azure CSI. | `bool` | `false` | no |
| <a name="input_azure_resource_group"></a> [azure\_resource\_group](#input\_azure\_resource\_group) | (optional) The Azure Resource Group. | `string` | `null` | no |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | (optional) The Azure Subscription ID. | `string` | `null` | no |
| <a name="input_azure_tenant_id"></a> [azure\_tenant\_id](#input\_azure\_tenant\_id) | (optional) The Azure Tenant ID. | `string` | `null` | no |
| <a name="input_gcp_csi"></a> [gcp\_csi](#input\_gcp\_csi) | Enable creation of secrets used by GCP CSI setup | `bool` | `false` | no |
| <a name="input_gcp_pd_csi_sa_key"></a> [gcp\_pd\_csi\_sa\_key](#input\_gcp\_pd\_csi\_sa\_key) | Private Key of the Google Service Account with Persistent Disk permissions | `string` | `null` | no |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | (optional) The GCP Project ID | `string` | `null` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
