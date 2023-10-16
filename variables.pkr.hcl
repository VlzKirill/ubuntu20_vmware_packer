variable "vsphere_server" {
  type    = string
  default = ""
}

variable "vsphere_user" {
  type    = string
  default = ""
}

variable "vsphere_password" {
  type    = string
  default = ""
}

variable "ssh_user" {
  type    = string
  default = ""
}

variable "ssh_password" {
  type    = string
  default = ""
}

variable "datacenter" {
  type    = string
  default = ""
}

variable "cluster" {
  type    = string
  default = ""
}

variable "datastore" {
  type    = string
  default = ""
}

variable "network_name" {
  type    = string
  default = ""
}

variable "host" {
  type    = string
  default = ""
}

variable "resource_pool" {
  type    = string
  default = ""
}

variable "vm_name" {
  type    = string
  default = ""
}

variable "guest_os_type" {
  type    = string
  default = ""
}

variable "iso_url" {
  type    = string
  default = ""
}

variable "iso_checksum" {
  type    = string
  default = ""
}

variable "cpu_cores" {
  type    = number
}

variable "cpu_num" {
  type    = number
}

variable "ram" {
  type    = number
}

variable "video_ram" {
  type    = number
}

variable "disk_size" {
  type    = number
}

variable "folder" {
  type    = string
  default = ""
}

locals {
  buildtime = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
}