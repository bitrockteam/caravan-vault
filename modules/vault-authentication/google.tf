resource "vault_auth_backend" "google" {
  count = var.google_authenticate ? 1 : 0
  type  = "gcp"
}
