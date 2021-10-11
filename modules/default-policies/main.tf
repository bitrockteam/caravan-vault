resource "vault_policy" "consul_agent" {
  name   = "consul-agent-role"
  policy = file("${path.module}/policies/consul-agent-policy.hcl")
}

resource "vault_policy" "vault_admin" {
  name   = "vault-admin-role"
  policy = file("${path.module}/policies/vault-admin-policy.hcl")
}

resource "vault_policy" "nomad_server" {
  count  = var.enable_nomad ? 1 : 0
  name   = "nomad-server"
  policy = templatefile("${path.module}/policies/nomad-server-policy.hcl", { control_plane_role_name = var.control_plane_role_name })
}

resource "vault_policy" "nomad_token_manager" {
  count  = var.enable_nomad ? 1 : 0
  name   = "nomad-token-manager"
  policy = file("${path.module}/policies/nomad-token-manager-policy.hcl")
}

resource "vault_policy" "nomad_app_devs_volumes" {
  count  = var.enable_nomad ? 1 : 0
  name   = "nomad-app-devs-volumes"
  policy = file("${path.module}/policies/nomad-app-devs-volumes-policy.hcl")
}
resource "vault_policy" "nomad_app_devs" {
  count  = var.enable_nomad ? 1 : 0
  name   = "nomad-app-devs"
  policy = file("${path.module}/policies/nomad-app-devs-policy.hcl")
}
resource "vault_policy" "nomad_ops" {
  count  = var.enable_nomad ? 1 : 0
  name   = "nomad-ops"
  policy = file("${path.module}/policies/nomad-ops-policy.hcl")
}

resource "vault_policy" "nomad_anon_restricted" {
  count  = var.enable_nomad ? 1 : 0
  name   = "nomad-anon-restricted"
  policy = file("${path.module}/policies/nomad-anon-restricted-policy.hcl")
}

#tfsec:ignore:GEN003
resource "vault_token_auth_backend_role" "nomad_cluster_node" {
  count                  = var.enable_nomad ? 1 : 0
  role_name              = var.control_plane_role_name
  allowed_policies       = [vault_policy.nomad_app_devs_volumes.*.name, vault_policy.nomad_ops.*.name]
  orphan                 = true
  token_period           = "259200"
  renewable              = true
  token_explicit_max_ttl = "0"
}
