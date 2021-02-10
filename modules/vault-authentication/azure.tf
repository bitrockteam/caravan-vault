resource "vault_auth_backend" "azure" {
  count = contains(var.auth_providers, "azure") ? 1 : 0
  type  = "azure"
  path  = "azure"
}

resource "vault_azure_auth_backend_config" "config" {
  count     = contains(var.auth_providers, "azure") ? 1 : 0
  backend   = vault_auth_backend.azure[0].path
  tenant_id = var.azure_tenant_id
  resource  = var.azure_resource
}

resource "vault_azure_auth_backend_role" "control_plane" {
  count                       = contains(var.auth_providers, "azure") ? 1 : 0
  backend                     = vault_auth_backend.azure[0].path
  role                        = var.control_plane_role_name
  bound_service_principal_ids = var.azure_control_plane_service_principal_ids
  bound_resource_groups       = var.azure_resource_groups
  bound_subscription_ids      = var.azure_subscription_ids
  token_policies              = var.control_plane_token_policies_name
}

resource "vault_azure_auth_backend_role" "worker_plane" {
  count                       = contains(var.auth_providers, "azure") ? 1 : 0
  backend                     = vault_auth_backend.azure[0].path
  role                        = var.worker_plane_role_name
  bound_service_principal_ids = var.azure_worker_plane_service_principal_ids
  bound_resource_groups       = var.azure_resource_groups
  bound_subscription_ids      = var.azure_subscription_ids
  token_policies              = var.worker_plane_token_policies_name

}
