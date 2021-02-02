seal "gcpckms" {
  region      = "${gcp_region}"
  key_ring    = "${gcp_keyring}"
  crypto_key  = "${gcp_key}"
  project     = "${gcp_project_id}"
}
