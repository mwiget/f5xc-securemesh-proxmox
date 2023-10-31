module "proxmox" {
  source                = "./securemesh/proxmox"
  f5xc_cluster_name     = format("%s-zug1", var.project_prefix)
  f5xc_tenant           = var.f5xc_tenant
  f5xc_api_url          = var.f5xc_api_url
  f5xc_namespace        = var.f5xc_namespace
  f5xc_api_token        = var.f5xc_api_token
  f5xc_api_ca_cert      = var.f5xc_api_ca_cert
  owner_tag             = var.owner
  pm_api_url            = var.pm_api_url
  pm_api_token_id       = var.pm_api_token_id
  pm_api_token_secret   = var.pm_api_token_secret
  pve_host              = var.pve_host
  pve_user              = var.pve_user
  pve_private_key       = file("/Users/mwiget/.ssh/id_ed25519")
  #  pm_pool               = "f5xc"
  pm_clone              = "ver9-template"
  admin_password        = var.admin_password
  f5xc_cluster_labels   = { "site-mesh" : format("%s", var.project_prefix) }
  global_virtual_networks = [ "volterra-global-lab" ]
  master_node_cpus      = 4
  worker_node_cpus      = 4
  master_node_memory    = 14336
  worker_node_memory    = 16384
  pm_network_slo        = "vmbr0"
  pm_network_sli        = "vmbr2"
  is_sensitive          = false
  pm_storage            = "local-lvm"
  pm_disk_size          = "50G"
  pm_node               = "green1"
  f5xc_cluster_latitude = 47.1724
  f5xc_cluster_longitude = 8.5178
  master_nodes_count    = 1
  worker_nodes_count    = 0
  ssh_public_key        = file(var.ssh_public_key_file)
}

output "proxmox" {
  value = module.proxmox
  sensitive = true
}
