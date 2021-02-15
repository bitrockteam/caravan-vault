# Default Policies module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| vault | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [vault_policy](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) |
| [vault_token_auth_backend_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/token_auth_backend_role) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| control\_plane\_role\_name | (optional) The control plane role name | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| control\_plane\_policies | n/a |
| worker\_plane\_policies | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
