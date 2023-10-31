variable "ssh_public_key" {
  type = string
}

variable "f5xc_cluster_latitude" {
  type = number
  default = 37
}

variable "f5xc_cluster_longitude" {
  type = number
  default = -121
}

variable "f5xc_api_url" {
  type = string
}

variable "f5xc_api_ca_cert" {
  type    = string
  default = ""
}

variable "f5xc_api_token" {
  type = string
}

variable "f5xc_tenant" {
  type = string
}

variable "f5xc_namespace" {
  type = string
}

variable "f5xc_registration_wait_time" {
  type    = number
  default = 60
}

variable "f5xc_registration_retry" {
  type    = number
  default = 20
}

variable "f5xc_cluster_name" {
  type = string
}

variable "master_nodes_count" {
  type = number
  default = 1
}

variable "worker_nodes_count" {
  type = number
  default = 0
}

variable "pm_storage" {}
variable "pm_disk_size" {
  type = string
  default = "50G"
}
variable "pm_node" {}
variable "pm_api_url" {}
variable "pm_api_token_id" {}
variable "pm_api_token_secret" {}
variable "pve_host" {}
variable "pve_user" {}
variable "pve_private_key" {}
#variable "pm_pool" {}
variable "pm_clone" {}
variable "master_node_cpus" {
  type    = number
  default = 4
}
variable "worker_node_cpus" {
  type    = number
  default = 4
}
variable "master_node_memory" {
  type    = number
  default = 16384
}
variable "worker_node_memory" {
  type    = number
  default = 16384
}
variable "pm_network_slo" {
  type = string
  default = "vmbr0"
}
variable "pm_network_sli" {
  type = string
  default = "vmbr1"
}
variable "admin_password" {}

variable "f5xc_cluster_labels" {
  type = map(string)
}

variable "global_virtual_networks" {
  type = list(string)
}

variable "owner_tag" {}
variable "is_sensitive" {}
