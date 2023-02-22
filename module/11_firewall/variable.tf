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
    name = "fw-pip"
    allocation_method = "Static"
    sku = "Standard"
  }
}

variable "firewall-policy" {
  type = string
  default = "example-policy"
}

variable "isZones" {
  type = bool
  default = true
}

variable "firewall" {
  type = object({
    name = string
    sku_name = string
    sku_tier = string
    zones = list(string)
    ip_configuration = object({
        name = string
    })
  })
  default = {
    name = "fw-koo"
    sku_name = "AZFW_VNet"
    sku_tier = "Standard"
    zones = ["1","2","3"]
    ip_configuration = {
      name = "configuration"
    }

  }
}