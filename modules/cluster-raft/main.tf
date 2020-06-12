resource "null_resource" "vault_cluster_node" {
  for_each = var.cluster_nodes
  provisioner "file" {
    destination = "/tmp/vault.hcl"
    content = templatefile(
      "${path.module}/vault-cluster.hcl.tpl",
      {
        node_id    = each.key
        vault_home = var.vault_home
      }
    )
    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = var.ssh_private_key
      timeout     = var.ssh_timeout
      host        = var.cluster_nodes_public_ips != null ? var.cluster_nodes_public_ips[each.key] : each.value
    }
  }
  provisioner "remote-exec" {
    inline = ["sudo systemctl restart vault"]
    connection {
      type    = "ssh"
      user    = var.ssh_user
      timeout = var.ssh_timeout
      private_key = var.ssh_private_key
      host    = var.cluster_nodes_public_ips != null ? var.cluster_nodes_public_ips[each.key] : each.value
    }
  }
}
