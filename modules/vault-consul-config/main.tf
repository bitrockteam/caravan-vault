data "vault_generic_secret" "consul_bootstrap_token" {
  path = "secret/consul/bootstrap_token"
}

resource "vault_consul_secret_backend" "consul_backend" {
  path        = "consul"
  description = "Manages the Consul backend"

  address = "127.0.0.1:8500"
  token   = data.vault_generic_secret.consul_bootstrap_token.data["secretid"]
}

resource "vault_consul_secret_backend_role" "agent_node_role" {
  name    = "agent-role"
  backend = vault_consul_secret_backend.consul_backend.path

  policies = [
    "cluster-node-agent-policy",
  ]
}


provider "consul" {
  address    = var.consul_endpoint
}

resource "consul_acl_policy" "cluster_node_agent_policy" {
  name        = "cluster-node-agent-policy"
  rules       = file("${path.module}/acls/cluster-node-agent.hcl")
}

resource "consul_acl_token_policy_attachment" "cluster_node_agent_token" {
  depends_on = [
    consul_acl_policy.cluster_node_agent_policy,
  ]
  token_id = data.vault_generic_secret.consul_bootstrap_token.data["accessorid"]
  policy = consul_acl_policy.cluster_node_agent_policy.name
}