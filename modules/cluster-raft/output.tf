output "cluster_node_1_public_ip" {
  value = "${data.null_data_source.values.outputs["cluster_node_1_public_ip"]"
}