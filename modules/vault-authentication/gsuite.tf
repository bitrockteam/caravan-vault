
resource "vault_jwt_auth_backend" "gsuite" {
  description        = "Google G Suite"
  count              = contains(var.auth_providers, "gsuite")
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
  count           = contains(var.auth_providers, "gsuite")
  backend         = vault_jwt_auth_backend.gsuite[0].path
  role_name       = var.gsuite_default_role
  token_policies  = var.gsuite_default_role_policies
  bound_audiences = [var.gsuite_client_id]

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
