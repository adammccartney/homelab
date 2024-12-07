terraform {
    required_version = ">= 1.6.6"

    required_providers {
        proxmox = {
            source = "Telmate/proxmox"
            version = "3.0.1-rc4"
        }
    }
}

provider "proxmox" {
  pm_api_url      = "https://192.168.0.249:8006/api2/json"
  pm_tls_insecure = true
}


resource "proxmox_vm_qemu" "mu-nfs" {
    count = 1
    name = "mu-nfs"
    target_node = var.proxmox_host
    vmid = "30${count.index + 1}"
    cicustom = "user=local:snippets/${var.user_data_snippet_file}"
    clone = var.template_name
    
    agent    = 1
    os_type  = "cloud_init"
    cores    = 2
    sockets  = 1
    cpu      = "host"
    memory   = 2048
    scsihw   = "virtio-scsi-pci"
    bootdisk = "scsi0"

    disk {
        slot     = "scsi0"
        size     = "15G"
        storage  = "local-lvm"
        iothread = true
    }
}

