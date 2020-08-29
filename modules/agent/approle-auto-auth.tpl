auto_auth {
  method "approle" {
    config = {
       role_id_file_path="/etc/vault.d/role-id"
       secret_id_file_path="/etc/vault.d/secret-id"
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
