# Caravan Vault Default Policies

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
| [vault_policy.consul_agent](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.nomad_anon_restricted](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.nomad_app_devs](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.nomad_app_devs_volumes](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.nomad_ops](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.nomad_server](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.nomad_token_manager](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.vault_admin](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_token_auth_backend_role.nomad_cluster_node](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/token_auth_backend_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_control_plane_role_name"></a> [control\_plane\_role\_name](#input\_control\_plane\_role\_name) | (optional) The control plane role name | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_control_plane_policies"></a> [control\_plane\_policies](#output\_control\_plane\_policies) | n/a |
| <a name="output_worker_plane_policies"></a> [worker\_plane\_policies](#output\_worker\_plane\_policies) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
