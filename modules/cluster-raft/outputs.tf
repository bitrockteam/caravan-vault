output "vault_address" {
  value = "http://127.0.${length(null_resource.vault_cluster_node_1_init.id) - length(null_resource.vault_cluster_node_1_init.id)}.1:8200"
}
output "consul_enc_key" {
  value     = data.local_file.encryption_key.content
  sensitive = true
}

output "vault_token" {
  value     = trim(data.local_file.vault_token.content, "\n")
  sensitive = true
}
