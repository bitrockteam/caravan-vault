storage "raft" {
  path    = "${vault_home}/storage"
  node_id = "${node_id}"
  %{ for n in setsubtract(keys("${cluster_nodes}"), [node_id]) ~}
  retry_join {
    leader_api_addr = "http://${cluster_nodes[n]}:8200"
  }
  %{ endfor ~}
}

listener "tcp" {
  address         = "0.0.0.0:8200"
  cluster_address = "0.0.0.0:8201"
  tls_disable     = true
}

telemetry = {
  prometheus_retention_time = "30s"
  disable_hostname = true
}

log_level = "Debug"

ui = true
disable_mlock = true
cluster_addr  = "http://${node_ip}:8201"
api_addr      = "http://${node_ip}:8200"
