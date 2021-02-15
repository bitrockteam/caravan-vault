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
| [vault_generic_secret](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_secret) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| gcp\_csi | Enable creation of secrets used by GCP CSI setup | `bool` | `false` | no |
| gcp\_project\_id | (optional) The GCP Project ID | `string` | `null` | no |

## Outputs

No output.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
