storage "raft" {
  path    = "${storage_path}/raft-vault_2/"
  node_id = "${node_id}"
}
listener "tcp" {
  address         = "0.0.0.0:8200"
  cluster_address = "0.0.0.0:8201"
  tls_disable     = true
}
seal "transit" {
  address = "http://0.0.0.0:8200"
  # token is read from VAULT_TOKEN env
  # token              = ""
  disable_renewal = "false"

  // Key configuration
  key_name   = "unseal_key"
  mount_path = "transit/"
}
disable_mlock = true
cluster_addr  = "http://127.0.0.2:8201"
