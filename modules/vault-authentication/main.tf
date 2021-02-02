terraform {
  required_version = "~> 0.13.1"
}

resource "vault_audit" "syslog" {
  type    = "syslog"
  options = {}
}
