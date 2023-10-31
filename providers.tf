provider "volterra" {
  api_p12_file = var.f5xc_api_p12_file
  url          = var.f5xc_api_url
  timeout      = "30s"
}

provider "restapi" {
  uri = var.f5xc_api_url
  create_returns_object = true
  headers = {
    Authorization = format("APIToken %s", var.f5xc_api_token)
    Content-Type  = "application/json"
  }
}

provider "proxmox" {
  pm_api_url          = var.pm_api_url
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  pm_tls_insecure     = true
  #pm_log_enable = true
  #pm_log_file   = "terraform-plugin-proxmox.log"
  #  pm_debug      = false
  #  pm_log_levels = {
  #    _default    = "debug"
  #    _capturelog = ""
  #  }
}
