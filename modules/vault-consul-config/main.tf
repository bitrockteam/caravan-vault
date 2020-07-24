data "vault_generic_secret" "consul_bootstrap_token" {
  path = "secret/consul/bootstrap_token"
}

resource "vault_consul_secret_backend" "consul_backend" {
  path        = "consul"
  description = "Manages the Consul backend"

  address = "127.0.0.1:8500"
  token   = data.vault_generic_secret.consul_bootstrap_token.data["secretid"]
}

resource "vault_consul_secret_backend_role" "agent_node_role" {
  name    = "consul-agent-role"
  backend = vault_consul_secret_backend.consul_backend.path

  policies = [
    "consul-agent-role",
  ]
}

resource "consul_acl_policy" "cluster_node_agent_policy" {
  name        = "consul-agent-role"
  rules       = file("${path.module}/acls/cluster-node-agent.hcl")
}
resource "consul_acl_policy" "nomad_server_policy" {
  name        = "nomad-server"
  rules       = file("${path.module}/acls/nomad-server.hcl")
}
resource "consul_acl_policy" "nomad_client_policy" {
  name        = "nomad-client"
  rules       = file("${path.module}/acls/nomad-client.hcl")
}
resource "consul_acl_policy" "ui_policy" {
  name        = "ui-policy"
  rules       = file("${path.module}/acls/operator-ui.hcl")
}

resource "consul_acl_token_policy_attachment" "cluster_node_agent_token" {
  depends_on = [
    consul_acl_policy.cluster_node_agent_policy,
  ]
  token_id = data.vault_generic_secret.consul_bootstrap_token.data["accessorid"]
  policy = consul_acl_policy.cluster_node_agent_policy.name
}


resource "consul_acl_token" "ui_token" {
  description = "ui policy token"
  policies = ["${consul_acl_policy.ui_policy.name}"]
}
resource "consul_acl_token" "nomad_server_token" {
  description = "nomad server policy token"
  policies = ["${consul_acl_policy.nomad_server_policy.name}"]
}
resource "consul_acl_token" "nomad_client_token" {
  description = "nomad client policy token"
  policies = ["${consul_acl_policy.nomad_client_policy.name}"]
}

data "consul_acl_token_secret_id" "ui_token" {
  accessor_id = consul_acl_token.ui_token.id
}

resource "vault_generic_secret" "ui_token" {
  path = "secret/consul/ui_token"

  data_json = <<EOT
{
  "token": "${data.consul_acl_token_secret_id.ui_token.secret_id}"
}
EOT
}

data "consul_acl_token_secret_id" "nomad_client_token" {
  accessor_id = consul_acl_token.nomad_client_token.id
}

resource "vault_generic_secret" "nomad_client_token" {
  path = "secret/consul/nomad_client_token"

  data_json = <<EOT
{
  "token": "${data.consul_acl_token_secret_id.nomad_client_token.secret_id}"
}
EOT
}

data "consul_acl_token_secret_id" "nomad_server_token" {
  accessor_id = consul_acl_token.nomad_server_token.id
}

resource "vault_generic_secret" "nomad_server_token" {
  path = "secret/consul/nomad_server_token"

  data_json = <<EOT
{
  "token": "${data.consul_acl_token_secret_id.nomad_server_token.secret_id}"
}
EOT
}



resource "consul_service" "consul_servers" {
  count = 3
  name    = "consul-node0${count.index + 1}"
  node    = "clustnode0${count.index + 1}"
  port    = 8300
  tags    = ["consul", "server"]
  check {
    check_id                          = "service:consul-node0${count.index + 1}"
    name                              = "Consul health check"
    status                            = "passing"
    tcp                               = "127.0.0.1:8300"
    tls_skip_verify                   = false
    interval                          = "10s"
    timeout                           = "5s"
  }
}


resource "consul_service" "dnsmasq_clusternode" {
  count = 3
  name    = "dnsmasq_clusternode0${count.index + 1}"
  node    = "clustnode0${count.index + 1}"
  port    = 53
  tags    = ["dnsmasq"]
  check {
    # nslookup soa consul
    check_id                          = "service:dnsmasq0${count.index + 1}"
    name                              = "DNSmasq health check"
    status                            = "passing"
    tcp                               = "127.0.0.1:53"
    tls_skip_verify                   = false
    interval                          = "10s"
    timeout                           = "5s"
    deregister_critical_service_after = "30s"
  }
}

resource "consul_service" "vault" {
  count = 3
  name    = "vault0${count.index + 1}"
  node    = "clustnode0${count.index + 1}"
  port    = 8200
  tags    = ["vault"]
  check {
    check_id                          = "service:vault0${count.index + 1}"
    name                              = "Vault health check"
    status                            = "passing"
    tcp                               = "127.0.0.1:8200"
    tls_skip_verify                   = false
    interval                          = "10s"
    timeout                           = "5s"
  }
}
