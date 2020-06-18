resource "null_resource" "vault_cluster_node_config" {
  triggers = {
    nodes = join(",", keys(var.cluster_nodes))
  }
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
connection {
  type        = "ssh"
  user        = var.ssh_user
  private_key = var.ssh_private_key
  timeout     = var.ssh_timeout
  host        = var.cluster_nodes_public_ips != null ? var.cluster_nodes_public_ips[each.key] : each.value
}
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
  triggers = {
    nodes = null_resource.vault_cluster_node_config[keys(var.cluster_nodes)[0]].id
  }
  provisioner "remote-exec" {
    script = "${path.module}/scripts/vault_cluster_node_1_init.sh"
    connection {
      type        = "ssh"
      user        = var.ssh_user
      timeout     = var.ssh_timeout
      private_key = var.ssh_private_key
      host        = var.cluster_nodes_public_ips[keys(var.cluster_nodes)[0]]
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
  count = length(var.cluster_nodes) - 1 < 0 ? 0 : length(var.cluster_nodes) - 1
  triggers = {
    nodes = join(",", keys(null_resource.vault_cluster_node_config))
  }
  depends_on = [
    null_resource.vault_cluster_node_1_init,
  ]

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

provider "vault" {
  address = "https://${null_resource.vault_cluster_node_config[keys(var.cluster_nodes)[0]].id}:8200"
}

resource "vault_mount" "consul" {
  depends_on = [
    null_resource.vault_cluster_node_1_init,
  ]
  path        = "consul"
  type        = "consul"
  description = "Enable Consul secrets engine"
}

resource "vault_mount" "userpass" {
  depends_on = [
    null_resource.vault_cluster_node_1_init,
  ]
  path        = "userpass"
  type        = "userpass"
  description = "Enable UserPass auth method"
}

resource "vault_mount" "approle" {
  depends_on = [
    null_resource.vault_cluster_node_1_init,
  ]
  path        = "approle"
  type        = "approle"
  description = "Enable AppRole auth method"
}

resource "vault_mount" "GCP_secrets" {
  depends_on = [
    null_resource.vault_cluster_node_1_init,
  ]
  path        = "GCP"
  type        = "GCP"
  description = "Enable GCP secrets engine"
}

