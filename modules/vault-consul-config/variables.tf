variable "consul_address" {
  type        = string
  default     = "127.0.0.1:8500"
  description = "Consul Address"
}
variable "enable_nomad" {
  default = true
  type    = string
}
variable "ca_cert" {
  type        = string
  description = "CA Pem Content"
  default     = null
}
