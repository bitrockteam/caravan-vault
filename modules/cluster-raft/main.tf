resource "null_resource" "vault_cluster_node" {
  for_each = var.cluster_nodes
  provisioner "file" {
    destination = "/tmp/vault.hcl"
    content = <<-EOT
      ${templatefile(
      "${path.module}/vault-cluster.hcl.tpl",
      {
        node_id    = each.key
        vault_home = var.vault_home
      }
      )}
      ${templatefile(
      "${path.module}/unseal-${var.unseal_type}.hcl.tpl",
      {
        unseal_region  = var.unseal_region
        unseal_keyring = var.unseal_keyring
        unseal_key     = var.unseal_key
      }
    )}
    EOT
  }
  connection {
    type        = "ssh"
    user        = var.ssh_user
    private_key = var.ssh_private_key
    timeout     = var.ssh_timeout
    host        = var.cluster_nodes_public_ips != null ? var.cluster_nodes_public_ips[each.key] : each.value
  }

  provisioner "remote-exec" {
    inline = ["sudo mv /tmp/vault.hcl /etc/vault.d/vault.hcl; sudo mkdir -p /var/lib/vault/raft-vault_2/storage; sudo systemctl restart vault"]
    connection {
      type        = "ssh"
      user        = var.ssh_user
      timeout     = var.ssh_timeout
      private_key = var.ssh_private_key
      host        = var.cluster_nodes_public_ips != null ? var.cluster_nodes_public_ips[each.key] : each.value
    }
  }
}
