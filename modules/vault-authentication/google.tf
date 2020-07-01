resource "vault_auth_backend" "gcp" {
  count = var.gcp_authenticate ? 1 : 0
  type  = "gcp"
  path  = "gcp"
}

resource "vault_gcp_auth_backend_role" "gcp" {
  count                  = var.gcp_authenticate ? 1 : 0
  backend                = vault_auth_backend.gcp[0].path
  bound_projects         = [var.gcp_project_id]
  bound_service_accounts = ["cluster-node@${var.gcp_project_id}.iam.gserviceaccount.com"]
  token_policies         = ["agent-role"]
  role                   = "cluster-node"
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
  backend         = vault_jwt_auth_backend.gsuite[0].path
  role_name       = var.gsuite_default_role
  token_policies  = var.gsuite_default_role_policies
  bound_audiences = [var.gsuite_client_id]

  user_claim = "sub"
  role_type  = "oidc"
  bound_claims = {
    hd = var.gsuite_domain
  }
  allowed_redirect_uris = var.gsuite_allowed_redirect_uris
}
