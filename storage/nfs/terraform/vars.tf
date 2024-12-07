variable "proxmox_host" {
  default = "lab"
}

variable "template_name" {
  default = "debian-12-cloud"
}

variable "user_data_snippet_file" {
    default = "mu-nfs-cloud-init.yaml"
}
