resource "proxmox_vm_qemu" "worker" {
  depends_on        = [ local_file.cloud_init_user_data_worker ]
  count             = var.worker_nodes_count
  name              = format("%s-w%d", var.f5xc_cluster_name, count.index)
  target_node       = var.pm_node
  clone             = var.pm_clone
  full_clone        = true
  cpu               = "host"
  cores             = var.worker_node_cpus
  sockets           = 1
  memory            = var.worker_node_memory
  os_type           = "cloud-init"
  network {
    bridge            = var.pm_network_slo
    model             = "virtio"
  }
  network {
    bridge            = var.pm_network_sli
    model             = "virtio"
  }
  cicustom          = "user=local:snippets/user_data_${var.f5xc_cluster_name}_w${count.index}.yml"
  cloudinit_cdrom_storage = var.pm_storage
  scsihw           = "virtio-scsi-single"
  disk {
    storage           = var.pm_storage
    size              = "50G"
    type              = "virtio"
    iothread          = 0
  }

  lifecycle {
    ignore_changes = [
      network,
      qemu_os,
      disk
    ]
  }

}

output "worker" {
  value = proxmox_vm_qemu.worker
}
