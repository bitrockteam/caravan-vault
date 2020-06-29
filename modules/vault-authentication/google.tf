resource "vault_auth_backend" "gcp" {
  count = var.google_authenticate ? 1 : 0
  type  = "gcp"
  path  = "gcp"
}
