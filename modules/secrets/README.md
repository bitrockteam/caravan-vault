# Secrets module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| vault | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [google_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account) |
| [google_service_account_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) |
| [vault_azure_secret_backend](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/azure_secret_backend) |
| [vault_azure_secret_backend_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/azure_secret_backend_role) |
| [vault_generic_secret](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_secret) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azure\_client\_id | (optional) The Azure Client ID. | `string` | `null` | no |
| azure\_client\_secret | (optional) The Azure Client Secret. | `string` | `null` | no |
| azure\_csi | Setup secrets needed for Azure CSI. | `bool` | `false` | no |
| azure\_resource\_group | (optional) The Azure Resource Group. | `string` | `null` | no |
| azure\_subscription\_id | (optional) The Azure Subscription ID. | `string` | `null` | no |
| azure\_tenant\_id | (optional) The Azure Tenant ID. | `string` | `null` | no |
| gcp\_csi | Enable creation of secrets used by GCP CSI setup | `bool` | `false` | no |
| gcp\_project\_id | (optional) The GCP Project ID | `string` | `null` | no |

## Outputs

No output.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
