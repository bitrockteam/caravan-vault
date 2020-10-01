provider "google" {
  region      = var.gcp_region
  project     = var.gcp_project_id
  credentials = var.google_account_file != null ? file(var.google_account_file) : null
}

data "google_service_account" "pd_csi_sa" {
  count      = var.gcp_csi ? 1 : 0
  account_id = "pd-csi-sa"
}

resource "google_service_account_key" "pd_csi_sa_key" {
  count              = var.gcp_csi ? 1 : 0
  service_account_id = data.google_service_account.pd_csi_sa[0].name
}

resource "vault_generic_secret" "pd_csi_sa_credential" {
  count      = var.gcp_csi ? 1 : 0
  path       = "/secret/gcp/pd_csi_sa_credential"
  depends_on = [google_service_account_key.pd_csi_sa_key]
  data_json = jsonencode({
    "credential_json": "${base64decode(google_service_account_key.pd_csi_sa_key[0].private_key)}"
  })
}
