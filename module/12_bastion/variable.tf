variable "resource_group_name" {
  type = string
  default = "example-resources"
}

variable "virtual_network_name" {
  type = string
  default = "example-network"
}

variable "public_ip" {
  type = object({
    name = string
    allocation_method = string
    sku = string
  })

  default = {
    name = "bastion-pip"
    allocation_method = "Static"
    sku = "Standard"
  }
}

variable "isZones" {
  type = bool
  default = true
}

variable "bastion" {
  type = object({
    name = string
    ip_configuration = object({
        name = string
    })
  })
  default = {
    name = "bastion-koo"
    ip_configuration = {
      name = "configuration"
    }

  }
}