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

resource "proxmox_vm_qemu" "kube-server" {
  count       = 1
  name        = "kube-server-${count.index + 1}"
  target_node = var.proxmox_host
  vmid        = "40${count.index + 1}"

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
    bridge = "vmbr3"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=192.168.1.4${count.index + 1}/24,gw=192.168.1.1"
  ipconfig1 = "ip=10.17.0.4${count.index + 1}/24"

  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}

resource "proxmox_vm_qemu" "kube-agent" {
  count       = 2
  name        = "kube-agent-0${count.index + 1}"
  target_node = var.proxmox_host
  vmid        = "50${count.index + 1}"

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
    bridge = "vmbr3"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=192.168.1.5${count.index + 1}/24,gw=192.168.1.1"
  ipconfig1 = "ip=10.17.0.5${count.index + 1}/24"

  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}

resource "proxmox_vm_qemu" "kube-storage" {
  count       = 1
  name        = "kube-storage-0${count.index + 1}"
  target_node = var.proxmox_host
  vmid        = "60${count.index + 1}"

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
    bridge = "vmbr3"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=192.168.1.6${count.index + 1}/24,gw=192.168.1.1"
  ipconfig1 = "ip=10.17.0.6${count.index + 1}/24"

  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}

