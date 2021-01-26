auto_auth {
  method "aws" {
    config = {
       type="iam"
       role="${aws_node_role}"
       region="${aws_region}"
       %{ if aws_access_key != null ~}access_key="${aws_access_key}"%{~ endif }
       %{ if aws_secret_key != null ~}secret_key="${aws_secret_key}"%{~ endif }
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
