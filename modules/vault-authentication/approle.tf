resource "vault_auth_backend" "approle" {
  count = var.approle_authenticate ? 1 : 0
  type  = "approle"
}

resource "vault_approle_auth_backend_role" "pocnode" {
  count          = var.approle_authenticate ? 1 : 0
  backend        = var.approle_authenticate ? vault_auth_backend.approle[0].path : ""
  role_name      = "pocnode"
  token_period   = 864000
  token_policies = var.oci_pocnode_token_policies
}

