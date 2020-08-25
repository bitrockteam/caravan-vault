resource "null_resource" "vault_cluster_node_local_service" {
  triggers = {
    ids = join("-", var.cluster_nodes_ids)
  }
  for_each = var.cluster_nodes

  provisioner "file" {
    destination = "/tmp/vault-cluster-service.json"
    source      = "${path.module}/vault-service.json"
    connection {
      type                = "ssh"
      user                = var.ssh_user
      private_key         = var.ssh_private_key
      timeout             = var.ssh_timeout
      host                = var.cluster_nodes_public_ips != null ? var.cluster_nodes_public_ips[each.key] : each.value
      bastion_host        = var.ssh_bastion_host
      bastion_port        = var.ssh_bastion_port
      bastion_private_key = var.ssh_bastion_private_key
      bastion_user        = var.ssh_bastion_user
    }
  }

  provisioner "remote-exec" {
    inline = ["sudo mv /tmp/vault-cluster-service.json /etc/consul.d"]
    connection {
      type                = "ssh"
      user                = var.ssh_user
      timeout             = var.ssh_timeout
      private_key         = var.ssh_private_key
      host                = var.cluster_nodes_public_ips != null ? var.cluster_nodes_public_ips[each.key] : each.value
      bastion_host        = var.ssh_bastion_host
      bastion_port        = var.ssh_bastion_port
      bastion_private_key = var.ssh_bastion_private_key
      bastion_user        = var.ssh_bastion_user
    }
  }
}
