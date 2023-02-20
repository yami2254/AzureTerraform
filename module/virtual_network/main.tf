data "azurerm_resource_group" "import-rg" {
  count = var.is_portal_vnet == false ? 0 : 1
  name = var.import_resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  count = var.is_portal_vnet == false ? 0 : 1
  name = var.import_vnet
  resource_group_name = data.azurerm_resource_group.import-rg[count.index].name
}


data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}


resource "azurerm_virtual_network" "vnet" {
  count = var.is_portal_vnet == false ? 1 : 0
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       =  length(var.address_spaces) == 0 ? var.address_space : [0]
  tags                = var.tags
}


resource "azurerm_subnet" "subnet" {
  count                                          = var.is_portal_subnet == false ? length(var.subnet_name) : 0 
  name                                           = var.subnet_name[count.index]
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = [var.subnet_prefixes[count.index]]
  virtual_network_name                           = var.vnet_name

  depends_on  = [azurerm_virtual_network.vnet]
}