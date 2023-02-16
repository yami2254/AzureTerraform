variable "nsg" {
    type = map(object({
        name = string
        resource_group_name = string
    }))
}

variable "nsg_rule" {
    type = map(object({
        name                        = string
        priority                    = string
        direction                   = string
        access                      = string
        protocol                    = string
        source_port_range           = string
        destination_port_range      = string
        source_address_prefixes       = list(string)
        destination_address_prefix  = string
        resource_group_name         = string
        network_security_group_name = string
    }))

  
}