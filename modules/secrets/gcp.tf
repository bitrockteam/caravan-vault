
resource "vault_generic_secret" "pd_csi_sa_credentials" {
  count = var.gcp_csi ? 1 : 0
  path  = "secret/gcp/pd_csi_sa_credentials"
  data_json = jsonencode({
    "credentials_json" : "${base64decode(var.gcp_pd_csi_sa_key)}"
  })
}
