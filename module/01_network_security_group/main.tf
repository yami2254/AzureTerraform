data "azurerm_resource_group" "rg" {
  name = var.resource_group_name    
}
data "azurerm_virtual_network" "vnet" {
  #count = length(var.subnet_name) == 0 ? 0 : 1
  name = var.vnet_name
  resource_group_name = var.vnet_resource_group_name
}
data "azurerm_subnet" "subnet"{
  count = length(var.subnet_name) == 0 ? 0 : length(var.subnet_name)
  name = var.subnet_name[count.index]
  resource_group_name = var.vnet_resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}

resource "azurerm_network_security_group" "nsg" {
  count             = length(var.security_group_name)
  name                = var.security_group_name[count.index]
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  tags                = var.tags
}

# resource "azurerm_network_security_rule" "inbound" {
#   for_each                    = { for rule in var.inbound_rules : rule.division => rule }
#   resource_group_name         = var.resource_group_name
#   network_security_group_name = each.value.security_group_name
#   direction                   = "Inbound"
#   name                        = each.value.name
#   priority                    = each.value.priority
#   access                      = each.value.access
#   protocol                    = each.value.protocol
#   source_address_prefixes     = lookup(each.value, "source_address_prefixes", "*")
#   source_port_ranges           = lookup(each.value, "source_port_ranges", "*")
#   destination_address_prefixes  = lookup(each.value, "destination_address_prefixes", "*")
#   destination_port_ranges      = lookup(each.value, "destination_port_ranges", "*")
#   description                 = lookup(each.value, "description", null)

#   depends_on                  = [azurerm_network_security_group.nsg]
# }

# resource "azurerm_network_security_rule" "outbound" {
#   for_each                    = { for rule in var.outbound_rules : rule.division => rule } 
#   resource_group_name         = var.resource_group_name
#   network_security_group_name = each.value.security_group_name
#   direction                   = "Outbound"
#   name                        = each.value.name
#   priority                    = each.value.priority
#   access                      = each.value.access
#   protocol                    = each.value.protocol
#   source_address_prefixes     = lookup(each.value, "source_address_prefixes", "*")
#   source_port_ranges           = lookup(each.value, "source_port_ranges", "*") 
#   destination_address_prefixes  = lookup(each.value, "destination_address_prefixes", "*") 
#   destination_port_ranges      = lookup(each.value, "destination_port_ranges", "*") 
#   description                 = lookup(each.value, "description", null)

#   depends_on                  = [azurerm_network_security_group.nsg]
# }

resource "azurerm_subnet_network_security_group_association" "assocation" {
  count         = length(var.subnet_name) == 0 ? 0 : length(var.subnet_name)
  subnet_id     = data.azurerm_subnet.subnet[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg[count.index].id
}

