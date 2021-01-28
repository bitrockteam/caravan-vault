resource "vault_auth_backend" "gcp" {
  count = contains(var.auth_providers, "gcp") ? 1 : 0
  type  = "gcp"
  path  = "gcp"
}

resource "vault_gcp_auth_backend_role" "gcp-cluster-node" {
  count                  = contains(var.auth_providers, "gcp") ? 1 : 0
  backend                = vault_auth_backend.gcp[0].path
  bound_projects         = [var.gcp_project_id]
  bound_service_accounts = var.gcp_control_plane_service_accounts
  token_policies         = var.control_plane_token_policies_name
  role                   = var.control_plane_role_name
  type                   = "iam"
  allow_gce_inference    = true
}

resource "vault_gcp_auth_backend_role" "gcp-worker-node" {
  count                  = contains(var.auth_providers, "gcp") ? 1 : 0
  backend                = vault_auth_backend.gcp[0].path
  bound_projects         = [var.gcp_project_id]
  bound_service_accounts = var.gcp_worker_plane_service_accounts
  token_policies         = var.worker_plane_token_policies_name
  role                   = var.worker_plane_role_name
  type                   = "iam"
  allow_gce_inference    = true
}
