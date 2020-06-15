resource "null_resource" "vault_cluster_node" {
  for_each = var.cluster_nodes
  provisioner "file" {
    destination = "/tmp/vault.hcl"
    content = <<-EOT
      ${templatefile(
    "${path.module}/vault-cluster.hcl.tpl",
    {
      node_id       = each.key
      node_ip       = each.value
      vault_home    = var.vault_home
      cluster_nodes = var.cluster_nodes
    }
    )}
      ${templatefile(
    "${path.module}/unseal-${var.unseal_type}.hcl.tpl",
    {
      unseal_region  = var.unseal_region
      unseal_keyring = var.unseal_keyring
      unseal_key     = var.unseal_key
      project_id     = var.unseal_project_id
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
  inline = ["sudo mv /tmp/vault.hcl /etc/vault.d/vault.hcl"]
  connection {
    type        = "ssh"
    user        = var.ssh_user
    timeout     = var.ssh_timeout
    private_key = var.ssh_private_key
    host        = var.cluster_nodes_public_ips != null ? var.cluster_nodes_public_ips[each.key] : each.value
  }
}
}

resource "null_resource" "vault_cluster_node_1_init" {

  provisioner "remote-exec" {
    inline = ["sudo systemctl start vault; export VAULT_ADDR=http://127.0.0.1:8200; vault operator init | awk '/Root Token/{print $4}' > /root/root_token"]
    connection {
      type        = "ssh"
      user        = var.ssh_user
      timeout     = var.ssh_timeout
      private_key = var.ssh_private_key
      host        = var.cluster_nodes_public_ips[keys(var.cluster_nodes)[0]]
    }
  }
}

resource "null_resource" "vault_cluster_node_not_1_init" {
  count      = length(var.cluster_nodes) - 1
  depends_on = ["null_resource.vault_cluster_node_1_init"]

  provisioner "remote-exec" {
    inline = ["sudo systemctl start vault"]
    connection {
      type        = "ssh"
      user        = var.ssh_user
      timeout     = var.ssh_timeout
      private_key = var.ssh_private_key
      host        = var.cluster_nodes_public_ips[keys(var.cluster_nodes)[count.index + 1]]
    }
  }
}

