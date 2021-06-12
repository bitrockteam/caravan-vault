# path to consul backend
path "consul/creds/consul-agent-role" {
  capabilities = ["read"]
}
path "consul/creds/consul-esm-role" {
  capabilities = ["read"]
}
path "secret/data/consul/encryption" {
  capabilities = ["read"]
}
path "secret/data/consul/nomad_server_token" {
  capabilities = ["read"]
}

path "secret/data/consul/nomad_client_token" {
  capabilities = ["read"]
}

path "secret/data/gcp/pd_csi_sa_credentials" {
  capabilities = ["read"]
}

path "azure/creds/contributor" {
  capabilities = ["read"]
}

path "sys/mounts/*" {
  capabilities = ["sudo", "create", "read", "update", "delete", "list"]
}

path "sys/mounts" {
  capabilities = ["read", "list"]
}

path "connect_pki*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "tls_pki*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
