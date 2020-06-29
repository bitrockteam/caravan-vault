provider "vault" {
  address = "http://${var.vault_endpoint}:8200"
  skip_tls_verify = true
}
#cluster-node@${var.project_id}.iam.gserviceaccount.com

resource "vault_gcp_auth_backend_role" "gcp" {
    backend                = vault_auth_backend.gcp[0].path
    bound_projects         = ["${var.project_id}"]
    bound_service_accounts = ["cluster-node@${var.project_id}.iam.gserviceaccount.com"]
    token_policies         = ["agent_policy_node_0"]
    role                   = "cluster-node"
    type                    = "iam"
}