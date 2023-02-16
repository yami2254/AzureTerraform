terraform {
  backend "azurerm" {
    resource_group_name  = var.resource_group_name
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
    key = var.key
  }
}
# Create resource group
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_resource_group" "import-rg" {
  count = var.is_portal_vnet == false ? 0 : 1
  name = var.import_resource_group_name
}


data "azurerm_virtual_network" "import-vnet" {
  count = var.is_portal_vnet == false ? 0 : 1
  name = var.import_vnet
  resource_group_name = var.import_resource_group_name
}


module "network" {
  is_portal_vnet = var.is_portal_vnet
  is_portal_subnet = var.is_portal_subnet

  source              = "git::https://az34ru33l5zc4gnygsccgoobohdktj6ke7bu4n75uvmqw5wod7lq@dev.azure.com/ski-iac-org/ski-iac-mvp/_git/ski-iac-mvp-module//modules/vnet"
  vnet_name           = var.vnet_name
  import_vnet         = var.import_vnet
  import_resource_group_name = var.import_resource_group_name
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.cidr
  subnet_prefixes     = var.subnet
  subnet_name        = var.subnet_name
  tags                = var.tags

  depends_on          = [data.azurerm_resource_group.rg]

}
