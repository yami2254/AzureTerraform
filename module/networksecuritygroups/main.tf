provider "azurerm" {
  features {}
}
data "azurerm_resource_group" "rg_exist" {
    for_each = var.nsg
    name     = each.value.resource_group_name
}

resource "azurerm_network_security_group" "example" {
    for_each             = var.nsg
    name                 = each.value.name
    resource_group_name  = data.azurerm_resource_group.rg_exist[each.key].name
    location             = data.azurerm_resource_group.rg_exist[each.key].location
}

resource "azurerm_network_security_rule" "example" {
    for_each                    = var.nsg_rule
    name                        = each.value.name
    priority                    = each.value.priority
    direction                   = each.value.direction
    access                      = each.value.access
    protocol                    = each.value.protocol
    source_port_range           = each.value.source_port_range
    destination_port_range      = each.value.destination_port_range
    source_address_prefixes       = each.value.source_address_prefixes
    destination_address_prefix  = each.value.destination_address_prefix
    resource_group_name         = each.value.resource_group_name
    network_security_group_name = each.value.network_security_group_name

    depends_on = [
      azurerm_network_security_group.example
    ]
}