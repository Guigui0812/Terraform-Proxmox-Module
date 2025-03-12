resource "proxmox_virtual_environment_file" "cloud-config-file" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.proxmox_node_name

  source_raw {
    data = <<-EOF
#cloud-config
hostname: ${var.vm_name}
users:
  - default
  - name: ${var.vm_admin_username}
    groups: 
      - sudo
    shell: /bin/bash
    sudo: ALL=(ALL) NOPASSWD:ALL
%{ if var.vm_admin_ssh_public_key != "" }
    ssh_authorized_keys:
      - ${var.vm_admin_ssh_public_key}
%{ endif }
chpasswd:
  list: |
    ${var.vm_admin_username}:${var.vm_admin_password}
    root:${var.vm_root_password}
  expire: False
ssh_pwauth: True
runcmd:
  - apt update
  - apt install -y python3 python3-pip net-tools qemu-guest-agent
  - systemctl enable qemu-guest-agent
  - systemctl start qemu-guest-agent
EOF

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
    cores = var.vm_nb_cpu_cores
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

    interface = "scsi1"

    user_data_file_id = proxmox_virtual_environment_file.cloud-config-file.id
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = "local:iso/${var.vm_iso_file}"
    interface    = "virtio0"
    iothread     = "true"
    discard      = "on"
    size         = var.vm_disk_size
  }

   

  network_device {
    bridge = "vmbr0"
  }

  depends_on = [proxmox_virtual_environment_file.cloud-config-file]
}