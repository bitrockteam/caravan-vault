auto_auth {
  method "gcp" {
    config = {
       type="iam"
       role="${gcp_node_role}"
       service_account="${gcp_service_account}"
       project="${gcp_project_id}"
    }
  }
  sink {
    type = "file"
    config = {
      path = "/root/vault_token"
    }
  }
}