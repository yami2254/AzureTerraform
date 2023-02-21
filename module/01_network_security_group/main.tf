data "azurerm_resource_group" "rg" {
  name = var.resource_group_name    
}


data "azurerm_resource_group" "import-rg" {
  count = var.is_portal_vnet == false ? 0 : 1
  name = var.import_resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name = var.is_portal_vnet == false ? var.vnet_name : var.import_vnet
  resource_group_name = var.is_portal_vnet == false ? var.resource_group_name : var.import_resource_group_name
}

data "azurerm_subnet" "subnet"{
  count = var.is_portal_subnet == false ? var.subnet_count : 0
  name = var.subnet_name[count.index]
  resource_group_name = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}

data "azurerm_subnet" "subnet-exist"{
  count = var.is_portal_subnet == false ? 0 : var.subnet_count
  name = var.subnet_name[count.index]
  resource_group_name = var.is_portal_vnet == false ? var.resource_group_name : var.import_resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}
 


resource "azurerm_network_security_group" "nsg" {
  count             = length(var.security_group_name)
  name                = var.security_group_name[count.index]
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "inbound" {
  for_each                    = { for rule in var.inbound_rules : rule.division => rule }
  resource_group_name         = var.resource_group_name
  network_security_group_name = each.value.security_group_name
  direction                   = "Inbound"
  name                        = each.value.name
  priority                    = each.value.priority
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_address_prefixes     = lookup(each.value, "source_address_prefixes", "*")
  source_port_ranges           = lookup(each.value, "source_port_ranges", "*")
  destination_address_prefixes  = lookup(each.value, "destination_address_prefixes", "*")
  destination_port_ranges      = lookup(each.value, "destination_port_ranges", "*")
  description                 = lookup(each.value, "description", null)

  depends_on                  = [azurerm_network_security_group.nsg]
}

resource "azurerm_network_security_rule" "outbound" {
  for_each                    = { for rule in var.outbound_rules : rule.division => rule } 
  resource_group_name         = var.resource_group_name
  network_security_group_name = each.value.security_group_name
  direction                   = "Outbound"
  name                        = each.value.name
  priority                    = each.value.priority
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_address_prefixes     = lookup(each.value, "source_address_prefixes", "*")
  source_port_ranges           = lookup(each.value, "source_port_ranges", "*") 
  destination_address_prefixes  = lookup(each.value, "destination_address_prefixes", "*") 
  destination_port_ranges      = lookup(each.value, "destination_port_ranges", "*") 
  description                 = lookup(each.value, "description", null)

  depends_on                  = [azurerm_network_security_group.nsg]
}

resource "azurerm_subnet_network_security_group_association" "assocation" {
  count         = var.subnet_count
  subnet_id     = length(data.azurerm_subnet.subnet) > 0 ? data.azurerm_subnet.subnet[count.index].id : data.azurerm_subnet.subnet-exist[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg[count.index].id
}

