resource "vault_policy" "consul_agent" {
  name   = "consul-agent-role"
  policy = file("${path.module}/policies/consul-agent-policy.hcl")
}

resource "vault_policy" "vault_admin" {
  name   = "vault-admin-role"
  policy = file("${path.module}/policies/vault-admin-policy.hcl")
}

resource "vault_policy" "nomad_server" {
  name   = "nomad-server"
  policy = file("${path.module}/policies/nomad-server-policy.hcl")
}

resource "vault_policy" "nomad_token_manager" {
  name   = "nomad-token-manager"
  policy = file("${path.module}/policies/nomad-token-manager-policy.hcl")
}

resource "vault_policy" "nomad_app_devs_volumes" {
  name   = "nomad-app-devs-volumes"
  policy = file("${path.module}/policies/nomad-app-devs-volumes-policy.hcl")
}
resource "vault_policy" "nomad_app_devs" {
  name   = "nomad-app-devs"
  policy = file("${path.module}/policies/nomad-app-devs-policy.hcl")
}
resource "vault_policy" "nomad_ops" {
  name   = "nomad-ops"
  policy = file("${path.module}/policies/nomad-ops-policy.hcl")
}

resource "vault_policy" "nomad_anon_restricted" {
  name   = "nomad-anon-restricted"
  policy = file("${path.module}/policies/nomad-anon-restricted-policy.hcl")
}

resource "vault_token_auth_backend_role" "nomad-cluster-node" {
  role_name              = "cluster-node"
  allowed_policies       = ["nomad-app-devs-volumes", "nomad-ops"]
  orphan                 = true
  token_period           = "259200"
  renewable              = true
  token_explicit_max_ttl = "0"
}
