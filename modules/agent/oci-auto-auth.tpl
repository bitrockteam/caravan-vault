auto_auth {
  method "oci" {
    config = {
       auth_type="instance_principal"
       role="${oci_node_role}"
    }
  }
  sink {
    type = "file"
    config = {
      path = "/etc/consul.d/vault_token"
    }
  }
}

