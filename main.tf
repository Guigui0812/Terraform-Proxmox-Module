resource "proxmox_virtual_environment_file" "cloud-config-file" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.proxmox_node_name

  source_raw {
    data      = var.vm_cloud_config
    file_name = "${var.vm_name}-cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  name      = var.vm_name
  node_name = var.proxmox_node_name

  agent {
    enabled = true
  }

  cpu {
    sockets = var.vm_nb_cpu_sockets
    cores   = var.vm_nb_cpu_cores
  }

  memory {
    dedicated = var.vm_memory
  }

  initialization {

    ip_config {
      ipv4 {
        address = var.vm_ip_address
        gateway = var.vm_gateway
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud-config-file.id
  }

  disk {
    datastore_id = var.vm_datastore_id
    file_id      = "local:iso/${var.vm_iso_file}"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.vm_disk_size
  }

  network_device {
    bridge = "vmbr0"
  }

  serial_device {
    device = "socket"
  }

  lifecycle{
    ignore_changes = var.changes_to_ignore
  }

  depends_on = [proxmox_virtual_environment_file.cloud-config-file]
}