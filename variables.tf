variable "project_prefix" {
  type        = string
  default     = "f5xc"
}

variable "f5xc_api_p12_file" {
  type = string
}

variable "f5xc_api_url" {
  type = string
}

variable "f5xc_api_token" {
  type = string
}

variable "f5xc_api_ca_cert" {
  type = string
  default = ""
}

variable "f5xc_tenant" {
  type = string
}

variable "f5xc_namespace" {
  type    = string
  default = "system"
}

variable "owner" {}

variable "ssh_public_key_file" {
  type = string
}

variable "f5xc_vm_template" {
  type = string
  default = ""
}

variable "master_nodes_count" {
  type = number
  default = 3		# currently only 3 nodes are supported by this repo
}

variable "worker_nodes_count" {
  type = number
  default = 0
}

variable "f5xc_registration_wait_time" {
    type    = number
    default = 60
}

variable "f5xc_registration_retry" {
    type    = number
    default = 20
}

variable "pm_api_url" {}
variable "pm_api_token_id" {}
variable "pm_api_token_secret" {}
variable "pve_host" {}
variable "pve_user" {}
variable "pve_password" {
  type = string
  default = ""
}

variable "admin_password" {
  type = string
  default = ""
}
