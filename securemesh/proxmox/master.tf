resource "proxmox_vm_qemu" "master" {
  count             = var.master_nodes_count
  name              = format("%s-m%d", var.f5xc_cluster_name, count.index)
  target_node       = var.pm_node
  clone             = var.pm_clone
  full_clone        = true
  cpu               = "host"
  cores             = var.master_node_cpus
  sockets           = 1
  memory            = var.master_node_memory
  network {
    bridge            = var.pm_network_slo
    model             = "virtio"
  }
  network {
    bridge            = var.pm_network_sli
    model             = "virtio"
  }
  os_type           = "cloud-init"
  cicustom          = "user=local:snippets/user_data_${var.f5xc_cluster_name}_m${count.index}.yml"
  cloudinit_cdrom_storage = var.pm_storage
  scsihw           = "virtio-scsi-single"
  disk {
    storage           = var.pm_storage
    size              = var.pm_disk_size
    type              = "scsi"
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

output "master" {
  value = proxmox_vm_qemu.master
}
