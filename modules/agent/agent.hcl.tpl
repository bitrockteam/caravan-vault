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
  source      = "/etc/consul.d/keyfile.tmpl"
  destination = "/etc/consul.d/keyfile"
}

template {
  source      = "/etc/consul.d/ca.tmpl"
  destination = "/etc/consul.d/ca"
}

template {
  source      = "/etc/consul.d/cert.tmpl"
  destination = "/etc/consul.d/cert"
  #command     = "sh -c 'sudo systemctl start consul && sudo systemctl reload consul'"
}

template {
  source      = "/etc/consul.d/consul.hcl.tmpl"
  destination = "/etc/consul.d/consul.hcl"
}
%{ if enable_nomad ~}
template {
  source      = "/etc/nomad.d/nomad_keyfile.tmpl"
  destination = "/etc/nomad.d/nomad_keyfile"
}

template {
  source      = "/etc/nomad.d/nomad_ca.tmpl"
  destination = "/etc/nomad.d/nomad_ca"
}

template {
  source      = "/etc/nomad.d/nomad_cert.tmpl"
  destination = "/etc/nomad.d/nomad_cert"
  #command     = "sh -c 'sudo systemctl start nomad && sudo systemctl reload nomad'"
}

template {
  source      = "/etc/nomad.d/nomad.hcl.tmpl"
  destination = "/etc/nomad.d/nomad.hcl"
}
%{ endif ~}
