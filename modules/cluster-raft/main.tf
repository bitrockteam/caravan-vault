resource "null_resource" "vault_cluster_node_config" {
  triggers = {
    ids = join("-", var.control_plane_nodes_ids)
  }
  for_each = var.control_plane_nodes
  provisioner "file" {
    destination = "/tmp/vault.hcl"
    content = <<-EOT
      ${templatefile(
    "${path.module}/vault-cluster.hcl.tpl",
    {
      node_id           = each.key
      node_ip           = each.value
      vault_home        = var.vault_home
      cluster_nodes     = var.control_plane_nodes
      cluster_nodes_ids = var.control_plane_nodes_ids
    }
    )}
      ${templatefile(
    "${path.module}/unseal-${var.unseal_type}.hcl.tpl",
    {
      transit_vault_address = var.transit_vault_address
      transit_mount_path    = var.transit_mount_path
      transit_vault_token   = var.transit_vault_token
      transit_key           = var.transit_key

      oci_key                 = var.oci_key
      oci_crypto_endpoint     = var.oci_crypto_endpoint
      oci_management_endpoint = var.oci_management_endpoint

      gcp_region     = var.gcp_region
      gcp_keyring    = var.gcp_keyring
      gcp_key        = var.gcp_key
      gcp_project_id = var.gcp_project_id

      aws_kms_region = var.aws_kms_region
      aws_kms_key_id = var.aws_kms_key_id
      aws_access_key = var.aws_access_key
      aws_secret_key = var.aws_secret_key
      aws_endpoint   = var.aws_endpoint

      azure_tenant_id   = var.azure_tenant_id
      azure_environment = var.azure_environment
      azure_vault_name  = var.azure_vault_name
      azure_key_name    = var.azure_key_name
    }
)}

    EOT
connection {
  type                = "ssh"
  user                = var.ssh_user
  private_key         = var.ssh_private_key
  timeout             = var.ssh_timeout
  host                = var.control_plane_nodes_public_ips != null ? var.control_plane_nodes_public_ips[each.key] : each.value
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
    host                = var.control_plane_nodes_public_ips != null ? var.control_plane_nodes_public_ips[each.key] : each.value
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
  provisioner "file" {
    source      = "${path.module}/scripts/vault_cluster_node_1_init.sh"
    destination = "/tmp/vault_cluster_node_1_init.sh"
    connection {
      type                = "ssh"
      user                = var.ssh_user
      timeout             = var.ssh_timeout
      private_key         = var.ssh_private_key
      host                = var.control_plane_nodes_public_ips != null ? var.control_plane_nodes_public_ips[keys(var.control_plane_nodes)[0]] : var.control_plane_nodes[keys(var.control_plane_nodes)[0]]
      bastion_host        = var.ssh_bastion_host
      bastion_port        = var.ssh_bastion_port
      bastion_private_key = var.ssh_bastion_private_key
      bastion_user        = var.ssh_bastion_user
    }
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/vault_cluster_node_1_init.sh",
      "export LICENSE=\"${var.license}\" && /tmp/vault_cluster_node_1_init.sh"
    ]
    connection {
      type                = "ssh"
      user                = var.ssh_user
      timeout             = var.ssh_timeout
      private_key         = var.ssh_private_key
      host                = var.control_plane_nodes_public_ips != null ? var.control_plane_nodes_public_ips[keys(var.control_plane_nodes)[0]] : var.control_plane_nodes[keys(var.control_plane_nodes)[0]]
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

  triggers = {
    token_sha1 = sha1(join("", [for f in fileset(".", "*_token") : filesha1(f)]))
  }

  provisioner "local-exec" {
    environment = {
      SOURCE_HOST = var.control_plane_nodes_public_ips != null ? var.control_plane_nodes_public_ips[keys(var.control_plane_nodes)[0]] : var.control_plane_nodes[keys(var.control_plane_nodes)[0]]
    }
    command = "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ${path.module}/.ssh-key ${var.ssh_user}@$SOURCE_HOST 'sudo cat /root/root_token' > .${var.prefix}-root_token"
  }
}

resource "null_resource" "get_encryption_key" {
  depends_on = [
    local_file.ssh-key,
    null_resource.vault_cluster_node_1_init
  ]
  provisioner "local-exec" {
    environment = {
      SOURCE_HOST = var.control_plane_nodes_public_ips != null ? var.control_plane_nodes_public_ips[keys(var.control_plane_nodes)[0]] : var.control_plane_nodes[keys(var.control_plane_nodes)[0]]
    }
    command = "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ${path.module}/.ssh-key ${var.ssh_user}@$SOURCE_HOST 'sudo cat /root/encryption_key' > .${var.prefix}-encryption_key"
  }
  provisioner "local-exec" {
    command = "rm ${path.module}/.ssh-key"
  }
}

data "local_file" "vault_token" {
  depends_on = [null_resource.copy_root_token]
  filename   = ".${var.prefix}-root_token"
}

data "local_file" "encryption_key" {
  depends_on = [null_resource.get_encryption_key]
  filename   = ".${var.prefix}-encryption_key"
}

resource "null_resource" "vault_cluster_node_not_1_init" {
  count = length(var.control_plane_nodes_ids) - 1 < 0 ? 0 : length(var.control_plane_nodes_ids) - 1
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
      host                = var.control_plane_nodes_public_ips != null ? var.control_plane_nodes_public_ips[keys(var.control_plane_nodes)[count.index + 1]] : var.control_plane_nodes[keys(var.control_plane_nodes)[count.index + 1]]
      bastion_host        = var.ssh_bastion_host
      bastion_port        = var.ssh_bastion_port
      bastion_private_key = var.ssh_bastion_private_key
      bastion_user        = var.ssh_bastion_user
    }
  }
}

