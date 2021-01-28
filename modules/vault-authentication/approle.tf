resource "vault_auth_backend" "approle" {
  count = contains(var.auth_providers, "approle") ? 1 : 0
  type  = "approle"
}

// FIXME: do we need control plane and worker plane roles?
resource "vault_approle_auth_backend_role" "role" {
  count          = contains(var.auth_providers, "approle") ? 1 : 0
  backend        = vault_auth_backend.approle[0].path
  role_name      = var.approle_role_name
  token_period   = 864000
  token_policies = var.approle_token_policies
}
