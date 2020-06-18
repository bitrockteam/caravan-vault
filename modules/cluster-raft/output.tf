output "vault_endpoint" {
  value = google_compute_instance.hcpoc_cluster_nodes[0].network_interface.0.access_config.0.nat_ip
}