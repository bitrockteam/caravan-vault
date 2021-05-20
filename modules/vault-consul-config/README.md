# Vault Consul Config module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_consul"></a> [consul](#provider\_consul) | n/a |
| <a name="provider_vault"></a> [vault](#provider\_vault) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [consul_acl_policy.cluster_node_agent_policy](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/resources/acl_policy) | resource |
| [consul_acl_policy.consul_esm_policy](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/resources/acl_policy) | resource |
| [consul_acl_policy.nomad_client_policy](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/resources/acl_policy) | resource |
| [consul_acl_policy.nomad_server_policy](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/resources/acl_policy) | resource |
| [consul_acl_policy.ui_policy](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/resources/acl_policy) | resource |
| [consul_acl_token.nomad_client_token](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/resources/acl_token) | resource |
| [consul_acl_token.nomad_server_token](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/resources/acl_token) | resource |
| [consul_acl_token.ui_token](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/resources/acl_token) | resource |
| [consul_acl_token_policy_attachment.cluster_node_agent_token](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/resources/acl_token_policy_attachment) | resource |
| [vault_consul_secret_backend.consul_backend](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/consul_secret_backend) | resource |
| [vault_consul_secret_backend_role.agent_node_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/consul_secret_backend_role) | resource |
| [vault_consul_secret_backend_role.esm_node](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/consul_secret_backend_role) | resource |
| [vault_generic_secret.nomad_client_token](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_secret) | resource |
| [vault_generic_secret.nomad_server_token](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_secret) | resource |
| [vault_generic_secret.ui_token](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_secret) | resource |
| [consul_acl_token_secret_id.nomad_client_token](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/data-sources/acl_token_secret_id) | data source |
| [consul_acl_token_secret_id.nomad_server_token](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/data-sources/acl_token_secret_id) | data source |
| [consul_acl_token_secret_id.ui_token](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/data-sources/acl_token_secret_id) | data source |
| [vault_generic_secret.consul_bootstrap_token](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
