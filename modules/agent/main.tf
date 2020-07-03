
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
  type        = "ssh"
  user        = var.ssh_user
  private_key = var.ssh_private_key
  timeout     = var.ssh_timeout
  host        = var.nodes_public_ips != null ? var.nodes_public_ips[keys(var.nodes_public_ips)[count.index]] : var.nodes[keys(var.nodes)[count.index]]
}
}

provisioner "remote-exec" {
  inline = ["sudo mv /tmp/agent.hcl /etc/vault.d/agent.hcl && sudo systemctl restart vault-agent"]
  connection {
    type        = "ssh"
    user        = var.ssh_user
    timeout     = var.ssh_timeout
    private_key = var.ssh_private_key
    host        = var.nodes_public_ips != null ? var.nodes_public_ips[keys(var.nodes_public_ips)[count.index]] : var.nodes[keys(var.nodes)[count.index]]
  }
}
}
