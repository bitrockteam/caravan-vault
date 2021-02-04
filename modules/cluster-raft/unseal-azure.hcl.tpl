seal "azurekeyvault" {
    tenant_id   = "${azure_tenant_id}"
    environment = "${azure_environment}"
    vault_name  = "${azure_vault_name}"
    key_name    = "${azure_key_name}"
}
