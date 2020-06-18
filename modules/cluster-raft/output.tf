output "vault_endpoint" {
  value = var.cluster_nodes_public_ips[keys(var.cluster_nodes)[0]]
}