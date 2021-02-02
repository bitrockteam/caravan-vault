path "auth/token/create/${control_plane_role_name}" {
  capabilities = ["update"]
}

path "auth/token/roles/${control_plane_role_name}" {
  capabilities = ["read"]
}

path "auth/token/lookup-self" {
  capabilities = ["read"]
}

path "auth/token/lookup" {
  capabilities = ["update"]
}

path "auth/token/revoke-accessor" {
  capabilities = ["update"]
}

path "sys/capabilities-self" {
  capabilities = ["update"]
}

path "auth/token/renew-self" {
  capabilities = ["update"]
}

path "secret/data/nomad/nomad_server_token" {
  capabilities = ["read"]
}
