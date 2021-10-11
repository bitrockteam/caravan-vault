output "control_plane_policies" {
  value = var.enable_nomad ? [vault_policy.consul_agent.name, vault_policy.nomad_server.*.name] : [vault_policy.consul_agent.name]
}

output "worker_plane_policies" {
  value = var.enable_nomad ? [vault_policy.consul_agent.name, vault_policy.nomad_app_devs_volumes.*.name] : [vault_policy.consul_agent.name]
}
