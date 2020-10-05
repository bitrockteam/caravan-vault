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

resource "vault_token_auth_backend_role" "nomad-cluster" {
  role_name           = "nomad-cluster"
  disallowed_policies = ["nomad-server"]
  orphan              = true
  period              = "86400"
  renewable           = true
  explicit_max_ttl    = "115200"
}
