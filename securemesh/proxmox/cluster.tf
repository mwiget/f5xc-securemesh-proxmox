resource "volterra_token" "site" {
  name      = var.f5xc_cluster_name
  namespace = var.f5xc_namespace
}

module "maurice" {
  source        = "../../modules/utils/maurice"
  f5xc_api_url = var.f5xc_api_url
}

#resource "volterra_voltstack_site" "cluster" {
#  depends_on  = [ proxmox_vm_qemu.master, proxmox_vm_qemu.worker ]
#  name        = var.f5xc_cluster_name
#  namespace   = "system"


resource "volterra_registration_approval" "master" {
  depends_on   = [ restapi_object.securemesh_site ]
  count        = var.master_nodes_count
  cluster_name = var.f5xc_cluster_name
  cluster_size = var.master_nodes_count
  hostname     = format("m%d", count.index)
  #  private_network_name = "default"
  wait_time    = var.f5xc_registration_wait_time
  retry        = var.f5xc_registration_retry
}

module "site_wait_for_online" {
  depends_on     = [ restapi_object.securemesh_site ]
  source         = "../../modules/f5xc/status/site"
  f5xc_api_token = var.f5xc_api_token
  f5xc_api_url   = var.f5xc_api_url
  f5xc_namespace = var.f5xc_namespace
  f5xc_site_name = var.f5xc_cluster_name
  f5xc_tenant    = var.f5xc_tenant
  is_sensitive   = var.is_sensitive
}

resource "volterra_registration_approval" "worker" {
  depends_on   = [module.site_wait_for_online]
  count        = var.worker_nodes_count
  cluster_name = var.f5xc_cluster_name
  cluster_size = var.master_nodes_count
  hostname     = format("w%d", count.index)
  wait_time    = var.f5xc_registration_wait_time
  retry        = var.f5xc_registration_retry
}

resource "time_offset" "exp_time" {
  offset_days = 30
}

