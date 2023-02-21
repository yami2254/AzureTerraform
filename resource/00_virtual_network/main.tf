data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

module "network" {
  source              = "../../module/virtual_network"
  vnet_name           = var.vnet_name
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.cidr
  subnet_prefixes     = var.subnet
  subnet_name        = var.subnet_name
  tags                = var.tags
  depends_on          = [data.azurerm_resource_group.rg]
}
