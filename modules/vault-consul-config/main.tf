provider "vault" {
  address = "http://${var.vault_endpoint}:8200"
  skip_tls_verify = true
}

resource "vault_mount" "GCP_secrets" {
  path        = "gcp"
  type        = "gcp"
  description = "Enable GCP secrets engine"
}

resource "vault_consul_secret_backend" "consul_backend" {
  path        = "consul/config/access"
  description = "Manages the Consul backend"

  address = "127.0.0.1:8500"
  token   = var.bootstrap_token
}