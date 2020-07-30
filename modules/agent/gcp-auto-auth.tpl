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
  command     = "sh -c 'sudo systemctl start consul && sudo systemctl reload consul'"
}

template {
  source      = "/etc/consul.d/consul.hcl.tmpl"
  destination = "/etc/consul.d/consul.hcl"
}

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
  command     = "sh -c 'sudo systemctl start nomad && sudo systemctl reload nomad'"
}

template {
  source      = "/etc/nomad.d/nomad.hcl.tmpl"
  destination = "/etc/nomad.d/nomad.hcl"
}