output "control_plane_policies" {
  value = concat(vault_policy.consul_agent.name, vault_policy.nomad_server.*.name)
}

output "worker_plane_policies" {
  value = concat(vault_policy.consul_agent.name, vault_policy.nomad_app_devs_volumes.*.name)
}
