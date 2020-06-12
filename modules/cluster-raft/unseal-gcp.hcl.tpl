seal "gcpckms" {
  region      = "${unseal_region}"
  key_ring    = "${unseal_keyring}"
  crypto_key  = "${unseal_key}"
  project     = "${project_id}"
}
