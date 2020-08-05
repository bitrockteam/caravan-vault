seal "transit" {
    token = "${unseal_transit_vault_token}"
    address = "${unseal_transit_vault_address}"
    disable_renewal = "false"
    key_name = "${unseal_key}"
    mount_path = "${unseal_transit_mount_path}"
    tls_skip_verify = "true"
}