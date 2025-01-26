# Proxmox provisioning with Terraform

This Terraform module provides a way to provision a VM on a Proxmox server using `bpg/proxmox` provider.

## Requirements

- [Terraform](https://www.terraform.io/downloads.html)
- [Proxmox](https://www.proxmox.com/en/downloads) installed on a server
- [Proxmox provider](https://registry.terraform.io/providers/bpg/proxmox/latest/docs)

## Variables

| Name | Description | Type |
|------|-------------|------|
| `proxmox_endpoint` | Proxmox API endpoint | `string` |
| `proxmox_username` | Proxmox username | `string` |
| `proxmox_password` | Proxmox password | `string` |
| `vm_name` | VM name | `string` |
| `vm_nb_cpu_cores` | Number of CPU cores for the VM | `string` |
| `vm_memory` | Amount of memory for the VM | `string` |
| `vm_username` | Username for the VM | `string` |
| `vm_password` | Password for the VM | `string` |
| `vm_ip_address` | IP address for the VM | `string` |
| `vm_gateway` | Gateway for the VM | `string` |
| `vm_iso_file` | ISO file for the VM | `string` |
| `vm_disk_size` | VM disk size | `number` |
| `vm_cloud_config` | Cloud-init configuration for the VM | `string` |

## Usage

Code sample to create a VM on a Proxmox server:

```hcl
module "proxmox" {
    source = "github.com/guillaumegarcia/sloth//terraform/proxmox"

    proxmox_endpoint = "https://<PROXMOX_IP>:8006/api2/json"
    proxmox_username = "root@pam"
    proxmox_password = <PASSWORD>

    vm_name = "my-vm"
    vm_nb_cpu_cores = 2
    vm_memory = 2048
    vm_username = <USERNAME>
    vm_password = <PASSWORD>
    vm_ip_address = <IP_ADDRESS>
    vm_gateway = <GATEWAY_IP>
    vm_iso_file = "ubuntu-20.04.3-live-server-amd64.iso"
    vm_disk_size = 8
    vm_cloud_config = <<EOF

# cloud-config

hostname: <HOSTNAME>
users:
  - default
  - name: <USERNAME>
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
  - name: <USERNAME>
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    lock_passwd: false
    plain_text_passwd: '<PASSWORD>'

chpasswd:
  list: |
    <USERNAME>:<PASSWORD>
    <USERNAME>:<PASSWORD>
  expire: False
ssh_pwauth: true
runcmd:
  - echo "Some message for MOTD" > /etc/motd
EOF
}
```

## License

BSD