resource "vault_auth_backend" "aws" {
  depends_on = [var.pre13_depends_on]
  count      = var.aws_authenticate ? 1 : 0
  type       = "aws"
  path       = "aws"
}

resource "vault_aws_auth_backend_role" "aws_cluster_node" {
  depends_on           = [vault_auth_backend.aws]
  count                = var.aws_authenticate ? 1 : 0
  backend              = vault_auth_backend.aws[0].path
  inferred_entity_type = "ec2_instance"
  inferred_aws_region  = var.aws_region
  bound_vpc_ids        = [var.aws_vpc_id]
  bound_iam_role_arns  = var.aws_cluster_node_iam_role_arns
  token_policies = [
    "consul-agent-role",
    "nomad-server"
  ]
  role      = "control_plane"
  auth_type = "iam"
}

resource "vault_aws_auth_backend_role" "aws_worker_node" {
  depends_on           = [vault_auth_backend.aws]
  count                = var.aws_authenticate ? 1 : 0
  backend              = vault_auth_backend.aws[0].path
  inferred_entity_type = "ec2_instance"
  inferred_aws_region  = var.aws_region
  bound_vpc_ids        = [var.aws_vpc_id]
  bound_iam_role_arns  = var.aws_worker_node_iam_role_arns
  token_policies = [
    "consul-agent-role",
    "nomad-app-devs-volumes"
  ]
  role      = "worker_plane"
  auth_type = "iam"
}
