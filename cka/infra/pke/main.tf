terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.11"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://192.168.0.249:8006/api2/json"
  pm_tls_insecure = true
}


resource "proxmox_vm_qemu" "adk-master" {
  count       = 1
  name        = "adk-master"
  target_node = var.proxmox_host
  vmid        = "20${count.index + 5}"

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
    slot     = 0
    size     = "15G"
    type     = "scsi"
    storage  = "local-lvm"
    iothread = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr2"
  }

  network {
    model  = "virtio"
    bridge = "vmbr5"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=192.168.1.21/24,gw=192.168.1.1"
  ipconfig1 = "ip=192.168.1.20/24"

  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}

resource "proxmox_vm_qemu" "adk-cp" {
  count       = 1
  name        = "adk-cp0${count.index + 1}"
  target_node = var.proxmox_host
  vmid        = "21${count.index + 5}"

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
    slot     = 0
    size     = "15G"
    type     = "scsi"
    storage  = "local-lvm"
    iothread = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr2"
  }

  network {
    model  = "virtio"
    bridge = "vmbr5"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=192.168.1.2${count.index + 2}/24,gw=192.168.1.1"

  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}


resource "proxmox_vm_qemu" "adk-node" {
  count       = 1
  name        = "adk-node0${count.index + 1}"
  target_node = var.proxmox_host
  vmid        = "23${count.index + 5}"

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
    slot     = 0
    size     = "15G"
    type     = "scsi"
    storage  = "local-lvm"
    iothread = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr2"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=192.168.1.3${count.index + 1}/24,gw=192.168.1.1"

  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}
