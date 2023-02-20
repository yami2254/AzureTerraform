data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location
  address_space       =  length(var.address_spaces) == 0 ? var.address_space : [0]
  tags                = var.tags
}
resource "azurerm_subnet" "subnet" {
  count                                          = length(var.subnet_name)
  name                                           = var.subnet_name[count.index]
  resource_group_name                            = data.azurerm_resource_group.rg.name
  address_prefixes                               = [var.subnet_prefixes[count.index]]
  virtual_network_name                           = var.vnet_name
  depends_on  = [azurerm_virtual_network.vnet]
}