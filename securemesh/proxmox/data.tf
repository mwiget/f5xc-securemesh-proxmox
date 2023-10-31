resource "local_file" "cloud_init_user_data_master" {
  count   = var.master_nodes_count
  content  = templatefile("${path.module}/templates/user_data.tpl", {
    cluster-name = var.f5xc_cluster_name
    host-name = format("m%d", count.index)
    latitude = var.f5xc_cluster_latitude
    longitude = var.f5xc_cluster_longitude
    maurice-private-endpoint = module.maurice.endpoints.maurice_mtls
    maurice-endpoint = module.maurice.endpoints.maurice
    site-registration-token = volterra_token.site.id
    certifiedhardware = "kvm-regular-nic-voltmesh"
  })
  filename = "${path.module}/files/user_data_${var.f5xc_cluster_name}_m${count.index}.cfg"
}

resource "local_file" "cloud_init_user_data_worker" {
  count   = var.worker_nodes_count
  content  = templatefile("${path.module}/templates/user_data.tpl", {
    cluster-name = var.f5xc_cluster_name
    host-name = format("w%d", count.index)
    latitude = var.f5xc_cluster_latitude
    longitude = var.f5xc_cluster_longitude
    maurice-private-endpoint = module.maurice.endpoints.maurice_mtls
    maurice-endpoint = module.maurice.endpoints.maurice
    site-registration-token = volterra_token.site.id
    certifiedhardware = "kvm-regular-nic-voltmesh"
  })
  filename = "${path.module}/files/user_data_${var.f5xc_cluster_name}_w${count.index}.cfg"
}

resource "null_resource" "cloud_init_master" {
  count   = var.master_nodes_count
  triggers = {
    always_run = timestamp()
  }
  connection {
    type     = "ssh"
    user     = var.pve_user
    #password = var.pve_password
    private_key = var.pve_private_key
    host     = var.pve_host
  }

  provisioner "file" {
    source      = local_file.cloud_init_user_data_master[count.index].filename
    destination = "/var/lib/vz/snippets/user_data_${var.f5xc_cluster_name}_m${count.index}.yml"
  }
  #  depends_on = [ local_file.cloud_init_user_data_file ]
}

resource "null_resource" "cloud_init_worker" {
  count   = var.worker_nodes_count
  triggers = {
    always_run = timestamp()
  }
  connection {
    type     = "ssh"
    user     = var.pve_user
    #    password = var.pve_password
    private_key = var.pve_private_key
    host     = var.pve_host
  }

  provisioner "file" {
    source      = local_file.cloud_init_user_data_worker[count.index].filename
    destination = "/var/lib/vz/snippets/user_data_${var.f5xc_cluster_name}_w${count.index}.yml"
  }
  #  depends_on = [ local_file.cloud_init_user_data_file ]
}

