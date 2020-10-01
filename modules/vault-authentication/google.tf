resource "vault_auth_backend" "gcp" {
  depends_on = [var.pre13_depends_on]
  count      = var.gcp_authenticate ? 1 : 0
  type       = "gcp"
  path       = "gcp"
}

resource "vault_gcp_auth_backend_role" "gcp-cluster-node" {
  depends_on             = [vault_auth_backend.gcp]
  count                  = var.gcp_authenticate ? 1 : 0
  backend                = vault_auth_backend.gcp[0].path
  bound_projects         = [var.gcp_project_id]
  bound_service_accounts = ["${var.gcp_cluster_node_service_account}@${var.gcp_project_id}.iam.gserviceaccount.com"]
  token_policies         = ["consul-agent-role"]
  role                   = "cluster-node"
  type                   = "iam"
  allow_gce_inference    = true
}

resource "vault_gcp_auth_backend_role" "gcp-worker-node" {
  count                  = var.gcp_authenticate ? 1 : 0
  depends_on             = [vault_auth_backend.gcp]
  backend                = vault_auth_backend.gcp[0].path
  bound_projects         = [var.gcp_project_id]
  bound_service_accounts = var.gcp_worker_node_service_accounts
  token_policies         = ["consul-agent-role"]
  role                   = "worker-node"
  type                   = "iam"
  allow_gce_inference    = true
}

resource "vault_jwt_auth_backend" "gsuite" {
  description        = "Google G Suite"
  count              = var.gsuite_authenticate ? 1 : 0
  path               = "gsuite"
  type               = "oidc"
  oidc_discovery_url = "https://accounts.google.com"
  oidc_client_id     = var.gsuite_client_id
  oidc_client_secret = var.gsuite_client_secret
  default_role       = var.gsuite_default_role
  tune {
    listing_visibility = "unauth"
  }
}

resource "vault_jwt_auth_backend_role" "gsuite_default_role" {
  count           = var.gsuite_authenticate ? 1 : 0
  backend         = var.gsuite_authenticate ? vault_jwt_auth_backend.gsuite[0].path : null
  role_name       = var.gsuite_authenticate ? var.gsuite_default_role : ""
  token_policies  = var.gsuite_default_role_policies
  bound_audiences = var.gsuite_authenticate ? [var.gsuite_client_id] : []

  user_claim = "sub"
  role_type  = "oidc"
  oidc_scopes = [
    "openid",
    "email",
    "profile"
  ]
  bound_claims = {
    "hd" = var.gsuite_domain
  }
  claim_mappings = {
    "email" = "name"
    "name"  = "display_name"
    "hd"    = "domain"
  }
  verbose_oidc_logging  = true
  allowed_redirect_uris = var.gsuite_allowed_redirect_uris
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
