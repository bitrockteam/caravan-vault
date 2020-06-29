provider "vault" {
  address = "http://${var.vault_endpoint}:8200"
  skip_tls_verify = true
}

data "vault_generic_secret" "consul_bootstrap_token" {
  path = "secret/consul/bootstrap_token"
}

resource "vault_consul_secret_backend" "consul_backend" {
  path        = "consul"
  description = "Manages the Consul backend"

  address = "127.0.0.1:8500"
  token   = data.vault_generic_secret.consul_bootstrap_token.data["token"]
}

resource "vault_consul_secret_backend_role" "agent_policy_node_0" {
  name    = "agent-role"
  backend = vault_consul_secret_backend.consul_backend.path

  policies = [
    "agent-token",
  ]
}