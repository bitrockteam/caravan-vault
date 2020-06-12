storage "raft" {
  path    = "${vault_home}/raft-vault_2/"
  node_id = "${node_id}"
}
listener "tcp" {
  address         = "0.0.0.0:8200"
  cluster_address = "0.0.0.0:8201"
  tls_disable     = true
}
disable_mlock = true
cluster_addr  = "http://127.0.0.2:8201"
