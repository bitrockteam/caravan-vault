variable "cluster_nodes" {
  type = map(any)
}
variable "cluster_nodes_public_ips" {
  type = map(any)
}
variable "vault_home" {
  type    = string
  default = "/var/lib/vault"
}
variable "ssh_private_key" {
  type = string
}
variable "ssh_user" {
  type    = string
  default = "centos"
}
variable "ssh_timeout" {
  type    = string
  default = "15s"
}
variable "unseal_type" {
  type    = string
  default = "gcp"
}
variable "unseal_region" {
  type    = string
  default = "global"
}
variable "unseal_keyring" {
  type    = string
  default = "vault_unseal_keyring"
}
variable "unseal_key" {
  type    = string
  default = "vault_unseal_keyring"
}