auto_auth {
  method "aws" {
    config = {
       type="iam"
       role="${aws_node_role}"
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
