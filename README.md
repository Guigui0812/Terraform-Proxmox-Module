# Proxmox provisioning with Terraform

This Terraform module provides a way to provision a VM on a Proxmox server using `bpg/proxmox` provider.

## Requirements

- [Terraform](https://www.terraform.io/downloads.html)
- [Proxmox](https://www.proxmox.com/en/downloads) server with **snippets** enabled (**Datacenter** > **Storage** > **Edit** > **Content** > **Snippets**)
- [bpg/proxmox provider - 0.72.0](https://registry.terraform.io/providers/bpg/proxmox/latest/docs)
- A Cloud Image ISO file to deploy the VM with an OS of your choice, like [Ubuntu](https://cloud-images.ubuntu.com/)

To use `bpg/proxmox` provider, you need to declare it in your `main.tf` file. The provider block should look like this:

```hcl
terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.72.0"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://<PROXMOX_IP>:8006"
  pm_user         = "<PROXMOX_USERNAME>"
  pm_password     = "<PROXMOX_PASSWORD>"
  pm_tls_insecure = true
}
```

Then, use `terraform init` to initialize the provider.

## Variables

| Name | Description | Type |
|------|-------------|------|
| `proxmox_node_name` | Proxmox node name | `string` |
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
| `changes_to_ignore` | List of VM attributes to ignore changes for | `list(string)` |

## Usage

As the **module** contains the `bpg/proxmox` provider and the code to create the VM, it is not necessary to create a `provider` block in the `main.tf` file. It only requires to call the module and provide the necessary variables.

To create a VM on a Proxmox server through this module, create a directory for the **Terraform** project and create a `main.tf` file with the following content:

```hcl
module "proxmox" {
  source = "git::https://github.com/Guigui0812/Terraform-Proxmox-Module.git"
  proxmox_node_name = "<PROXMOX_NODE_NAME>"
  vm_name           = "test-vm"
  vm_nb_cpu_cores   = "2" # Number of CPU cores
  vm_memory         = "2048" # Amount of memory in MB
  vm_username       = "username" 
  vm_password       = "password" 
  vm_ip_address     = "<VM_IP>/<CIDR>"
  vm_gateway        = "<GATEWAY_IP>"
  vm_iso_file       = "ubuntu-24-04-server.img" # name of the ISO file
  vm_disk_size      = "20" # Disk size in GB
  vm_cloud_config   = <<EOF

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

**Note :** Replace the placeholders with your own values.

**Note 2 :** The `vm_cloud_config` variable is a cloud-init configuration that will be used to configure the VM (more informations in **cloud-init** [documentation](https://cloudinit.readthedocs.io/en/latest/)).

To deploy the VM, run the following commands:

```bash
terraform init
terraform plan -out plan.tfplan
terraform apply plan.tfplan
```

To upgrade the module to the latest version, run `terraform init -upgrade`.

## License

BSD