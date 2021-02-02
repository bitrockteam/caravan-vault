seal "transit" {
    token = "${transit_vault_token}"
    address = "${transit_vault_address}"
    disable_renewal = "false"
    key_name = "${transit_key}"
    mount_path = "${transit_mount_path}"
    tls_skip_verify = "true"
}