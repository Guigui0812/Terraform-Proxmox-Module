##############################
# Proxmox provider variables #
##############################

variable "proxmox_endpoint" {
  type        = string
  description = "Proxmox API endpoint"
}

variable "proxmox_username" {
  type        = string
  description = "Proxmox username"
}

variable "proxmox_password" {
  type        = string
  description = "Proxmox password"
}

variable "proxmox_node_name" {
  type        = string
  description = "Proxmox node name"
}

####################
# Module variables #
####################

variable "vm_name" {
  type        = string
  description = "Name for the VM"
}

variable "vm_nb_cpu_cores" {
  type        = number
  description = "Number of CPU cores for the VM"
}

variable "vm_memory" {
  type        = number
  description = "Amount of memory for the VM"
}

variable "vm_username" {
  type        = string
  description = "Username for the VM"
}

variable "vm_password" {
  type        = string
  description = "Password for the VM"
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
  type        = string
  description = "Disk size for the VM"
}

variable "vm_cloud_config" {
  type        = string
  description = "Cloud-init configuration for the VM"
}

variable "vm_admin_username" {
  type        = string
  description = "Admin username for the VM"
}

variable "vm_admin_password" {
  type        = string
  description = "Admin password for the VM"
}

variable "vm_root_password" {
  type        = string
  description = "Root password for the VM"
}

variable "vm_admin_ssh_public_key" {
  type        = string
  description = "Admin SSH public key for the VM"
}