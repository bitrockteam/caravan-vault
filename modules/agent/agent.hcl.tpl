exit_after_auth = false
pid_file = "/var/lib/vault/agent.pid"

cache {
  use_auto_auth_token = true
}

listener "tcp" {
  address = "${tcp_listener}"
  tls_disable = ${!tcp_listener_tls}
}

vault {
  tls_disable = true
  address     = "${vault_endpoint}"
}

template {
  source      = "/etc/consul.d/consul.hcl.tmpl"
  destination = "/etc/consul.d/consul.hcl"
}