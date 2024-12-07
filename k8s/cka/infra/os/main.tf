# Setup the provider
terraform {
  required_version = ">= 0.14.0"

  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.52.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
  }
}

# Provider auth using tf variables
provider "openstack" {
  cloud = "openstack"
}

resource "openstack_compute_keypair_v2" "adk-ssh" {
  # (resource arguments)
  name       = "adk-ssh"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDuLsCnBN/+ZNCnukySvEatpOPNL2b5EbkJm3+NDgG3fwPfexwdr/cfGEag3yY4hnqpnrZhQeGWi8aV1IxEyS9E3r4wAUuWv5xx2qXWyUYL/dE/1CKEGUlriEXt6uGreUASjMDP6Tm4koA8Oe78MBmk8lgpFeLtQb3g1Ta0RF/6UKXuwVW+5iPdNO+n+PijhobuSE+6m3h3p5nROWsvgRVHKfP+GDlcZicfZtMiU8Uxqd6QKQBophVGAE2AAECIDZ7UoPCEyxSh7ffoTPwwv8nq/dd0h0hX4i/gO0X0KWjjJfcgZ3Ryq7MHNvCCYFulOW4QMzbpYWTJuUWqcwHuGdVn Generated-by-Nova"
}


# create master node
# use a1.highcpu.2 flavor
resource "openstack_compute_instance_v2" "adk-master" {
  count       = 1
  name        = "adk-master"
  flavor_name = var.flavor_a1_highcpu_2
  image_id    = var.ubuntu_jammy_image
  key_pair    = "adk-ssh"

  security_groups = ["adk-group"]

  network {
    uuid = var.network_uuid
  }

}

# create other control plane nodes
# Use a1.highcpu.2 flavor

# create worker nodes
# Use a1.highmem.8 flavor
