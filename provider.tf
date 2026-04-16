terraform {
  required_providers {
    anypoint = {
      source  = "mulesoft-anypoint/anypoint"
      version = "1.8.2"
    }
  }
}

provider "anypoint" {
  client_id     = var.client_id
  client_secret = var.client_secret
  cplane        = var.cplane
}
