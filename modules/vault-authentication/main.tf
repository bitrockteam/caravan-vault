resource "vault_policy" "allow_agent" {
  name = "agent-role"

  policy = <<EOT
path "consul/creds/agent-role" {
  capabilities = ["read"]
}
EOT
}


