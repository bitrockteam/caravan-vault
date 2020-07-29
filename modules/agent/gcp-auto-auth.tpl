auto_auth {
  method "gcp" {
    config = {
       type="iam"
       role="${gcp_node_role}"
       service_account="${gcp_service_account}"
       project="${gcp_project_id}"
    }
  }
  sink {
    type = "file"
    config = {
      path = "/etc/consul.d/vault_token"
    }
  }
}

template {
  source      = "/etc/consul.d/cert.tmpl"
  destination = "/etc/consul.d/cert"
  command     = "sh -c 'systemctl reload consul && systemctl reload nomad'"
}
template {
  source      = "/etc/consul.d/keyfile.tmpl"
  destination = "/etc/consul.d/keyfile"
  command     = "sh -c 'systemctl reload consul && systemctl reload nomad'"
}
template {
  source      = "/etc/consul.d/ca.tmpl"
  destination = "/etc/consul.d/ca"
  command     = "sh -c 'systemctl reload consul && systemctl reload nomad'"
}

template {
  source      = "/etc/consul.d/consul.hcl.tmpl"
  destination = "/etc/consul.d/consul.hcl"
}

template {
  source      = "/etc/nomad.d/nomad_cert.tmpl"
  destination = "/etc/nomad.d/nomad_cert"
  command     = "systemctl reload nomad"
}
template {
  source      = "/etc/nomad.d/nomad_keyfile.tmpl"
  destination = "/etc/nomad.d/nomad_keyfile"
  command     = "systemctl reload nomad"
}
template {
  source      = "/etc/nomad.d/nomad_ca.tmpl"
  destination = "/etc/nomad.d/nomad_ca"
  command     = "systemctl reload nomad"
}

template {
  source      = "/etc/nomad.d/nomad.hcl.tmpl"
  destination = "/etc/nomad.d/nomad.hcl"
}