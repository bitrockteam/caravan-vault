resource "null_resource" "vault_cluster_node_config" {
  triggers = {
    ids = join("-", var.cluster_nodes_ids)
  }
  for_each = var.cluster_nodes
  provisioner "file" {
    destination = "/tmp/vault.hcl"
    content = <<-EOT
      ${templatefile(
    "${path.module}/vault-cluster.hcl.tpl",
    {
      node_id           = each.key
      node_ip           = each.value
      vault_home        = var.vault_home
      cluster_nodes     = var.cluster_nodes
      cluster_nodes_ids = var.cluster_nodes_ids
    }
    )}
      ${templatefile(
    "${path.module}/unseal-${var.unseal_type}.hcl.tpl",
    {
      unseal_region              = var.unseal_region
      unseal_keyring             = var.unseal_keyring
      unseal_key                 = var.unseal_key
      unseal_crypto_endpoint     = var.unseal_crypto_endpoint
      unseal_management_endpoint = var.unseal_management_endpoint
      project_id                 = var.unseal_project_id
    }
)}
    EOT
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
  inline = ["sudo mv /tmp/vault.hcl /etc/vault.d/vault.hcl"]
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

resource "null_resource" "vault_cluster_node_1_init" {
  triggers = {
    nodes = (length(null_resource.vault_cluster_node_config) > 0 ? null_resource.vault_cluster_node_config[keys(null_resource.vault_cluster_node_config)[0]].id : null)
  }
  provisioner "remote-exec" {
    script = "${path.module}/scripts/vault_cluster_node_1_init.sh"
    connection {
      type                = "ssh"
      user                = var.ssh_user
      timeout             = var.ssh_timeout
      private_key         = var.ssh_private_key
      host                = var.cluster_nodes_public_ips[keys(var.cluster_nodes)[0]]
      bastion_host        = var.ssh_bastion_host
      bastion_port        = var.ssh_bastion_port
      bastion_private_key = var.ssh_bastion_private_key
      bastion_user        = var.ssh_bastion_user
    }
  }
}

resource "local_file" "ssh-key" {
  depends_on = [
    null_resource.vault_cluster_node_1_init
  ]
  sensitive_content = var.ssh_private_key
  filename          = "${path.module}/.ssh-key"
  file_permission   = "0600"
}

resource "null_resource" "copy_root_token" {
  depends_on = [
    local_file.ssh-key,
    null_resource.vault_cluster_node_1_init
  ]
  provisioner "local-exec" {
    command = "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ${path.module}/.ssh-key ${var.ssh_user}@${var.cluster_nodes_public_ips[keys(var.cluster_nodes)[0]]} 'sudo cat /root/root_token' > .root_token"
  }
  provisioner "local-exec" {
    command = "rm ${path.module}/.ssh-key"
  }
}

resource "null_resource" "vault_cluster_node_not_1_init" {
  count = length(var.cluster_nodes_ids) - 1 < 0 ? 0 : length(var.cluster_nodes_ids) - 1
  triggers = {
    nodes = join(",", try(null_resource.vault_cluster_node_config[*].id, []))
  }
  depends_on = [
    null_resource.vault_cluster_node_1_init,
  ]

  provisioner "remote-exec" {
    inline = ["sudo systemctl start vault"]
    connection {
      type                = "ssh"
      user                = var.ssh_user
      timeout             = var.ssh_timeout
      private_key         = var.ssh_private_key
      host                = var.cluster_nodes_public_ips[keys(var.cluster_nodes)[count.index + 1]]
      bastion_host        = var.ssh_bastion_host
      bastion_port        = var.ssh_bastion_port
      bastion_private_key = var.ssh_bastion_private_key
      bastion_user        = var.ssh_bastion_user
    }
  }
}

resource "null_resource" "vault_certificates_sync" {
  
  depends_on = [
    null_resource.vault_cluster_node_1_init,
    null_resource.vault_cluster_node_not_1_init,
    null_resource.vault_gcp_agent_config
  ]
  
  for_each = var.cluster_nodes

  provisioner "remote-exec" {
    script = "${path.module}/scripts/sync_certs.sh"
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
