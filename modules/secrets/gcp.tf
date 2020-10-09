data "google_service_account" "pd_csi_sa" {
  count      = var.gcp_csi ? 1 : 0
  account_id   = "pd-csi-sa-${replace(var.gcp_project_id, "/(-[0-9]+)/", "")}"
}

resource "google_service_account_key" "pd_csi_sa_key" {
  count              = var.gcp_csi ? 1 : 0
  service_account_id = data.google_service_account.pd_csi_sa[0].name
}

resource "vault_generic_secret" "pd_csi_sa_credentials" {
  count      = var.gcp_csi ? 1 : 0
  path       = "secret/gcp/pd_csi_sa_credentials"
  depends_on = [google_service_account_key.pd_csi_sa_key]
  data_json = jsonencode({
    "credentials_json": "${base64decode(google_service_account_key.pd_csi_sa_key[0].private_key)}"
  })
}
