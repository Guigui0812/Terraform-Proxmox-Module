####################
# Module variables #
####################

variable "proxmox_node_name" {
  type        = string
  description = "Proxmox node name"
}

variable "vm_name" {
  type        = string
  description = "Name for the VM"
}

variable "vm_nb_cpu_sockets" {
  type        = number
  description = "Identifier of the CPU socket used by the VM"
  default     = 1
}

variable "vm_nb_cpu_cores" {
  type        = number
  description = "Number of CPU cores for the VM"
}

variable "vm_memory" {
  type        = number
  description = "Amount of memory for the VM"
}

variable "vm_ip_address" {
  type        = string
  description = "IP address for the VM"
}

variable "vm_gateway" {
  type        = string
  description = "Gateway for the VM"
}

variable "vm_iso_file" {
  type        = string
  description = "ISO file for the VM"
}

variable "vm_disk_size" {
  type        = number
  description = "Disk size for the VM"
}

variable "vm_datastore_id" {
  type        = string
  description = "Datastore to use for VM disks"
  default     = "local-lvm"
}

variable "vm_cloud_config" {
  type        = string
  description = "Cloud-init configuration for the VM"
}