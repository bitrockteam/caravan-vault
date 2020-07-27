# path to consul backend
path "consul/creds/consul-agent-role" {
  capabilities = ["read"]
}

path "secret/data/consul/nomad_server_token" {
  capabilities = ["read"]
}

path "secret/data/consul/nomad_client_token" {
  capabilities = ["read"]
}

path "sys/mounts/*" {
  capabilities = [ "sudo", "create", "read", "update", "delete", "list" ]
}

path "sys/mounts" {
  capabilities = [ "read", "list" ]
}

path "pki*" {
  capabilities = [ "create", "read", "update", "delete", "list", "sudo" ]
}
