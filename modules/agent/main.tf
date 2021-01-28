resource "null_resource" "vault_gcp_agent_config" {
  count = var.gcp_auto_auth ? length(var.nodes) : 0
  triggers = {
    ids = join("-", var.nodes_ids)
  }
  provisioner "file" {
    destination = "/tmp/agent.hcl"
    content = <<-EOT
      ${templatefile("${path.module}/agent.hcl.tpl",
    {
      vault_endpoint   = var.vault_endpoint
      tcp_listener     = var.tcp_listener
      tcp_listener_tls = var.tcp_listener_tls
    }
    )}
      ${templatefile("${path.module}/gcp-auto-auth.tpl",
    {
      gcp_node_role       = var.gcp_node_role
      gcp_service_account = var.gcp_service_account
      gcp_project_id      = var.gcp_project_id
    }
)}
    EOT
connection {
  type                = "ssh"
  user                = var.ssh_user
  private_key         = var.ssh_private_key
  timeout             = var.ssh_timeout
  host                = var.nodes_public_ips != null ? var.nodes_public_ips[keys(var.nodes_public_ips)[count.index]] : var.nodes[keys(var.nodes)[count.index]]
  bastion_host        = var.ssh_bastion_host
  bastion_port        = var.ssh_bastion_port
  bastion_private_key = var.ssh_bastion_private_key
  bastion_user        = var.ssh_bastion_user
}
}

provisioner "remote-exec" {
  inline = ["sudo mv /tmp/agent.hcl /etc/vault.d/agent.hcl && sudo systemctl restart vault-agent"]
  connection {
    type                = "ssh"
    user                = var.ssh_user
    timeout             = var.ssh_timeout
    private_key         = var.ssh_private_key
    host                = var.nodes_public_ips != null ? var.nodes_public_ips[keys(var.nodes_public_ips)[count.index]] : var.nodes[keys(var.nodes)[count.index]]
    bastion_host        = var.ssh_bastion_host
    bastion_port        = var.ssh_bastion_port
    bastion_private_key = var.ssh_bastion_private_key
    bastion_user        = var.ssh_bastion_user
  }
}
}

resource "null_resource" "vault_oci_agent_config" {
  # count = var.oci_auto_auth ? length(var.nodes) : 0
  # disabled because agent does not know to authenticate with oci 🤷
  count = 0
  triggers = {
    ids = join("-", var.nodes_ids)
  }
  provisioner "file" {
    destination = "/tmp/agent.hcl"
    content = <<-EOT
      ${templatefile("${path.module}/agent.hcl.tpl",
    {
      vault_endpoint   = var.vault_endpoint
      tcp_listener     = var.tcp_listener
      tcp_listener_tls = var.tcp_listener_tls
    }
    )}
      ${templatefile("${path.module}/oci-auto-auth.tpl",
    {
      oci_node_role = var.oci_node_role
    }
)}
    EOT
connection {
  type                = "ssh"
  user                = var.ssh_user
  private_key         = var.ssh_private_key
  timeout             = var.ssh_timeout
  host                = var.nodes_public_ips != null ? var.nodes_public_ips[keys(var.nodes_public_ips)[count.index]] : var.nodes[keys(var.nodes)[count.index]]
  bastion_host        = var.ssh_bastion_host
  bastion_port        = var.ssh_bastion_port
  bastion_private_key = var.ssh_bastion_private_key
  bastion_user        = var.ssh_bastion_user
}
}

provisioner "remote-exec" {
  inline = ["sudo mv /tmp/agent.hcl /etc/vault.d/agent.hcl && sudo systemctl restart vault-agent"]
  connection {
    type                = "ssh"
    user                = var.ssh_user
    timeout             = var.ssh_timeout
    private_key         = var.ssh_private_key
    host                = var.nodes_public_ips != null ? var.nodes_public_ips[keys(var.nodes_public_ips)[count.index]] : var.nodes[keys(var.nodes)[count.index]]
    bastion_host        = var.ssh_bastion_host
    bastion_port        = var.ssh_bastion_port
    bastion_private_key = var.ssh_bastion_private_key
    bastion_user        = var.ssh_bastion_user
  }
}
}
resource "null_resource" "vault_oci_agent_hook" {
  count = var.oci_auto_auth ? length(var.nodes) : 0
  # this is an ugly workaround to make the agent work with OCI IAM
  triggers = {
    ids = join("-", var.nodes_ids)
  }
  provisioner "file" {
    destination = "/tmp/vault-agent.env"
    content     = <<-EOT
    VAULT_ADDR=http://127.0.0.1:8200
    OCI_AUTHENTICATE_APPROLE=pocnode
    EOT
    connection {
      type                = "ssh"
      user                = var.ssh_user
      private_key         = var.ssh_private_key
      timeout             = var.ssh_timeout
      host                = var.nodes_public_ips != null ? var.nodes_public_ips[keys(var.nodes_public_ips)[count.index]] : var.nodes[keys(var.nodes)[count.index]]
      bastion_host        = var.ssh_bastion_host
      bastion_port        = var.ssh_bastion_port
      bastion_private_key = var.ssh_bastion_private_key
      bastion_user        = var.ssh_bastion_user
    }
  }
  provisioner "remote-exec" {
    inline = ["sudo mv /tmp/vault-agent.env /etc/vault.d/agent.env"]
    connection {
      type                = "ssh"
      user                = var.ssh_user
      private_key         = var.ssh_private_key
      timeout             = var.ssh_timeout
      host                = var.nodes_public_ips != null ? var.nodes_public_ips[keys(var.nodes_public_ips)[count.index]] : var.nodes[keys(var.nodes)[count.index]]
      bastion_host        = var.ssh_bastion_host
      bastion_port        = var.ssh_bastion_port
      bastion_private_key = var.ssh_bastion_private_key
      bastion_user        = var.ssh_bastion_user
    }
  }
}

resource "null_resource" "vault_approle_agent_config" {
  count = var.approle_auto_auth ? length(var.nodes) : 0
  triggers = {
    ids = join("-", var.nodes_ids)
  }
  provisioner "file" {
    destination = "/tmp/agent.hcl"
    content = <<-EOT
      ${templatefile("${path.module}/agent.hcl.tpl",
    {
      vault_endpoint   = var.vault_endpoint
      tcp_listener     = var.tcp_listener
      tcp_listener_tls = var.tcp_listener_tls
    }
    )}
      ${templatefile("${path.module}/approle-auto-auth.tpl",
    {}
)}
    EOT
connection {
  type                = "ssh"
  user                = var.ssh_user
  private_key         = var.ssh_private_key
  timeout             = var.ssh_timeout
  host                = var.nodes_public_ips != null ? var.nodes_public_ips[keys(var.nodes_public_ips)[count.index]] : var.nodes[keys(var.nodes)[count.index]]
  bastion_host        = var.ssh_bastion_host
  bastion_port        = var.ssh_bastion_port
  bastion_private_key = var.ssh_bastion_private_key
  bastion_user        = var.ssh_bastion_user
}
}

provisioner "remote-exec" {
  inline = ["sudo mv /tmp/agent.hcl /etc/vault.d/agent.hcl && sudo systemctl restart vault-agent"]
  connection {
    type                = "ssh"
    user                = var.ssh_user
    timeout             = var.ssh_timeout
    private_key         = var.ssh_private_key
    host                = var.nodes_public_ips != null ? var.nodes_public_ips[keys(var.nodes_public_ips)[count.index]] : var.nodes[keys(var.nodes)[count.index]]
    bastion_host        = var.ssh_bastion_host
    bastion_port        = var.ssh_bastion_port
    bastion_private_key = var.ssh_bastion_private_key
    bastion_user        = var.ssh_bastion_user
  }
}
}

resource "null_resource" "vault_aws_agent_config" {
  count = var.aws_auto_auth ? length(var.nodes) : 0
  triggers = {
    ids = join("-", var.nodes_ids)
  }
  provisioner "file" {
    destination = "/tmp/agent.hcl"
    content = <<-EOT
      ${templatefile("${path.module}/agent.hcl.tpl",
    {
      vault_endpoint   = var.vault_endpoint
      tcp_listener     = var.tcp_listener
      tcp_listener_tls = var.tcp_listener_tls
    }
    )}
      ${templatefile("${path.module}/aws-auto-auth.tpl",
    {
      aws_node_role  = var.aws_node_role
      aws_access_key = var.aws_access_key
      aws_secret_key = var.aws_secret_key
    }
)}
    EOT
connection {
  type                = "ssh"
  user                = var.ssh_user
  private_key         = var.ssh_private_key
  timeout             = var.ssh_timeout
  host                = var.nodes_public_ips != null ? var.nodes_public_ips[keys(var.nodes_public_ips)[count.index]] : var.nodes[keys(var.nodes)[count.index]]
  bastion_host        = var.ssh_bastion_host
  bastion_port        = var.ssh_bastion_port
  bastion_private_key = var.ssh_bastion_private_key
  bastion_user        = var.ssh_bastion_user
}
}

provisioner "remote-exec" {
  inline = ["sudo mv /tmp/agent.hcl /etc/vault.d/agent.hcl && sudo systemctl restart vault-agent"]
  connection {
    type                = "ssh"
    user                = var.ssh_user
    timeout             = var.ssh_timeout
    private_key         = var.ssh_private_key
    host                = var.nodes_public_ips != null ? var.nodes_public_ips[keys(var.nodes_public_ips)[count.index]] : var.nodes[keys(var.nodes)[count.index]]
    bastion_host        = var.ssh_bastion_host
    bastion_port        = var.ssh_bastion_port
    bastion_private_key = var.ssh_bastion_private_key
    bastion_user        = var.ssh_bastion_user
  }
}
}
