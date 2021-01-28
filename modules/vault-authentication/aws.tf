resource "vault_auth_backend" "aws" {
  count = contains(var.auth_providers, "aws")
  type  = "aws"
  path  = "aws"
}

resource "vault_aws_auth_backend_role" "aws_cluster_node" {
  count                = contains(var.auth_providers, "aws")
  backend              = vault_auth_backend.aws[0].path
  inferred_entity_type = "ec2_instance"
  inferred_aws_region  = var.aws_region
  bound_vpc_ids        = [var.aws_vpc_id]
  bound_iam_role_arns  = var.aws_cluster_node_iam_role_arns
  token_policies       = var.control_plane_token_policies_name
  role                 = var.control_plane_role_name
  auth_type            = "iam"
}

resource "vault_aws_auth_backend_role" "aws_worker_node" {
  count                = contains(var.auth_providers, "aws")
  backend              = vault_auth_backend.aws[0].path
  inferred_entity_type = "ec2_instance"
  inferred_aws_region  = var.aws_region
  bound_vpc_ids        = [var.aws_vpc_id]
  bound_iam_role_arns  = var.aws_worker_node_iam_role_arns
  token_policies       = var.worker_plane_token_policies_name
  role                 = var.worker_plane_role_name
  auth_type            = "iam"
}
