resource "vault_policy" "consul_agent" {
  name   = "consul-agent-role"
  policy = file("${path.module}/policies/consul-agent-policy.hcl")
}

resource "vault_policy" "vault_admin" {
  name   = "vault-admin-role"
  policy = file("${path.module}/policies/vault-admin-policy.hcl")
}

resource "vault_policy" "nomad_cluster" {
  name   = "nomad-server"
  policy = file("${path.module}/policies/nomad-server-policy.hcl")
}

resource "vault_policy" "nomad_token_manager" {
  name   = "nomad-token-manager"
  policy = file("${path.module}/policies/nomad-token-manager.hcl")
}

resource "vault_token_auth_backend_role" "nomad-cluster" {
  role_name                 = "nomad-cluster"
  disallowed_policies       = ["nomad-server"]
  orphan                    = true
  token_period              = "259200"
  renewable                 = true
  token_explicit_max_ttl    = "0"
}
