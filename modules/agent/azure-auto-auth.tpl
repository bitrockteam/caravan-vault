auto_auth {
  method "azure" {
    config = {
      role="${azure_node_role}"
      resource="${azure_resource}"
    }
  }
  sink {
    type = "file"
    config = {
      path = "/etc/consul.d/vault_token"
    }
  }
  sink {
    type = "file"
    config = {
      path = "/etc/nomad.d/vault_token"
    }
  }
}
