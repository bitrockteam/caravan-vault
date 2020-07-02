exit_after_auth = false
pid_file = "/var/lib/vault/agent.pid"

auto_auth {
  method "gcp" {
    config = {
       type="iam"
       role="cluster-node"
       service_account="${service_account}"
       project="${project_id}"
    }
  }
}

cache {
  use_auto_auth_token = true
}

listener "tcp" {
  address = "127.0.0.1:9200"
  tls_disable = true
}

vault {
  tls_disable = true
  address     = "http://127.0.0.1:8200"
}
