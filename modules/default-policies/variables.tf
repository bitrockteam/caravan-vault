variable "control_plane_role_name" {
  default     = null
  type        = string
  description = "(optional) The control plane role name"
}

variable "enable_nomad" {
  default = true
  type    = string
}
