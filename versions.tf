terraform {
  required_providers {
    restapi = {
      source = "Mastercard/restapi"
      version = "1.18.2"
    }
    volterra = {
      source  = "volterraedge/volterra"
      version = ">= 0.11.21"
    }
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.9.14"
    }
  }
}

