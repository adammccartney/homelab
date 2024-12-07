variable "external_network" {
  description = "Id of the external (public) network"
  type        = string
  default     = "8daaa090-6780-4ef6-a50a-8c113a8ef7fb"
}

variable "adk_internal_network" {
  description = "Id of the internal (private) network"
  type        = string
  default     = "eee9fee6-19b4-4dbf-ba3f-25769937b20a"
}

variable "rocky_image" {
  description = "Id of the rocky-9.1-generic-cloud image"
  type        = string
  default     = "164f9b8b-6d80-4b66-a144-fc7beb974b4f"
}

variable "ubuntu_jammy_image" {
  description = "Id of ubuntu jammy image"
  type        = string
  default     = "164f9b8b-6d80-4b66-a144-fc7beb974b4f"
}

variable "flavor_a1_highcpu_2" {
  description = "Name of the a1.highcpu.2 flavor"
  type        = string
  default     = "a1.highcpu.2"
}

variable "flavor_a1_highmem_2" {
  description = "Name of the a1.highmem.2 flavor"
  type        = string
  default     = "a1.highmem.2"
}

variable "flavor_a1_a40_1" {
  description = "Name of the gpu image"
  type        = string
  default     = "a1.a40.1"
}

# Variables set through the env for openstack credentials
variable "floating_ip" {
  description = "The floating IP to use"
  type        = string
  default     = "128.130.202.117"
}

variable "network_uuid" {
  description = "ID of the network"
  type        = string
  default     = "eee9fee6-19b4-4dbf-ba3f-25769937b20a"
}
