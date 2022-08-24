resource "vault_azure_secret_backend" "azure" {
  count = var.azure_csi ? 1 : 0

  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
}

resource "vault_azure_secret_backend_role" "contributor" {
  count = var.azure_csi ? 1 : 0

  backend = vault_azure_secret_backend.azure[0].path
  role    = "contributor"
  max_ttl = "0"
  ttl     = "0"

  azure_roles {
    role_name = "Contributor"
    scope     = "/subscriptions/${var.azure_subscription_id}/resourceGroups/${var.azure_resource_group}"
  }
}
