provider "vault" {
  address = "https://${var.vault_endpoint}:8200"
}

resource "vault_mount" "consul" {
  path        = "consul"
  type        = "consul"
  description = "Enable Consul secrets engine"
}

resource "vault_mount" "userpass" {
  path        = "userpass"
  type        = "userpass"
  description = "Enable UserPass auth method"
}

resource "vault_mount" "approle" {
  path        = "approle"
  type        = "approle"
  description = "Enable AppRole auth method"
}

resource "vault_mount" "GCP_secrets" {
  path        = "GCP"
  type        = "GCP"
  description = "Enable GCP secrets engine"
}