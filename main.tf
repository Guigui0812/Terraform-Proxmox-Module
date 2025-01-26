resource "proxmox_virtual_environment_file" "test-vm-ubuntu-24-04-cloud-config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "proxmox"

  source_raw {
    data = var.vm_cloud_config
    
    file_name = "test-vm-ubuntu-24-04-cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "test-vm-ubuntu-24-04" {
  name      = var.vm_name
  node_name = "proxmox"

  cpu {
    cores = var.vm_nb_cpu_cores
  }

  memory {
    dedicated = var.vm_memory
  }

  initialization {
    user_account {
      username = var.vm_username
      password = var.vm_password
    }

    ip_config {
      ipv4 {
        address = var.vm_ip_address
        gateway = var.vm_gateway
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.test-vm-ubuntu-24-04-cloud-config.id
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = "local:iso/" + var.vm_iso_file
    interface    = "virtio0"
    iothread     = "true"
    discard      = "on"
    size         = var.vm_disk_size
  }

  network_device {
    bridge = "vmbr0"
  }
}