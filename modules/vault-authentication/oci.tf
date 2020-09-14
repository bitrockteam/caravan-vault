resource "vault_auth_backend" "oci" {
  count = var.oci_authenticate ? 1 : 0
  type  = "oci"
  path  = "oci"
}
resource "null_resource" "oci_auth_config" {
  count      = var.oci_authenticate ? 1 : 0
  depends_on = [vault_auth_backend.oci[0]]
  provisioner "local-exec" {
    command = "vault write -address ${var.vault_endpoint} auth/oci/config home_tenancy_id=${var.oci_home_tenancy_id}"
  }
  provisioner "local-exec" {
    command = "vault write -address ${var.vault_endpoint} auth/oci/role/pocnode token_period=864000 token_policies=pocapprole_reader ocid_list=${var.pocnode_oci_dynamic_group_ocid}"
  }
}

resource "vault_policy" "pocapprole_reader" {
  name   = "pocapprole_reader"
  policy = <<EOT
path "auth/approle/role/pocnode/role-id" {
  capabilities = ["read"]
}
path "auth/approle/role/pocnode/secret-id" {
  capabilities = ["update"]
}
EOT
}
