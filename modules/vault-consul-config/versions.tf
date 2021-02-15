terraform {
  required_providers {
    consul = {
      source  = "hashicorp/consul"
      version = "~> 2.11.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 2.18.0"
    }
  }
  required_version = "~> 0.13.6"
}
