resource "vault_auth_backend" "oci" {
  count = contains(var.auth_providers, "oci") ? 1 : 0
  type  = "oci"
  path  = "oci"
}

resource "null_resource" "oci_auth_config" {
  count      = contains(var.auth_providers, "oci") ? 1 : 0
  depends_on = [vault_auth_backend.oci[0]]
  provisioner "local-exec" {
    command = "vault write -address ${var.vault_endpoint} auth/oci/config home_tenancy_id=${var.oci_home_tenancy_id}"
  }
  provisioner "local-exec" {
    command = "vault write -address ${var.vault_endpoint} auth/oci/role/${var.oci_role_name} token_period=864000 token_policies=${vault_policy.oci_reader[0].name} ocid_list=${var.oci_dynamic_group_ocid}"
  }
}

resource "vault_policy" "oci_reader" {
  count      = contains(var.auth_providers, "oci") ? 1 : 0
  depends_on = [vault_auth_backend.oci[0]]
  name       = "${var.oci_role_name}_reader"
  policy     = <<EOT
path "auth/approle/role/${var.approle_role_name}/role-id" {
  capabilities = ["read"]
}
path "auth/approle/role/${var.approle_role_name}/secret-id" {
  capabilities = ["update"]
}
EOT
}
