output "vault_address" {
  value = "http://127.0.${length(null_resource.vault_cluster_node_1_init.id) - length(null_resource.vault_cluster_node_1_init.id)}.1:8200"
}