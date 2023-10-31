terraform {
  required_version = ">= 1.3.0"

  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = "= 0.11.25"
    }

    restapi = {
      source = "Mastercard/restapi"
      version = "1.18.2"
    }

    proxmox = {
      source = "Telmate/proxmox"
      version = "2.9.14"
    }

    local = ">= 2.2.3"
    null  = ">= 3.1.1"
  }
}
