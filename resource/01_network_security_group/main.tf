terraform {
  backend "azurerm" {
    resource_group_name  = var.resource_group_name
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
    key = var.key
  }
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}


module "network_security_rule"{
  source = "git::https://az34ru33l5zc4gnygsccgoobohdktj6ke7bu4n75uvmqw5wod7lq@dev.azure.com/ski-iac-org/ski-iac-mvp/_git/ski-iac-mvp-module//modules/network_security_group"
  #is_portal_vnet = var.is_portal_vnet
  is_portal_subnet = var.is_portal_subnet

  import_resource_group_name = var.import_resource_group_name
  import_vnet = var.import_vnet
  vnet_name = var.vnet_name
  
  subnet_count          = var.subnet_count
  resource_group_name       = data.azurerm_resource_group.rg.name
  security_group_name       = var.security_group_name
  inbound_rules             = var.inbound_rules
  outbound_rules            = var.outbound_rules

  tags                      = var.tags
  subnet_name              = var.subnet_name

  depends_on                = [data.azurerm_resource_group.rg]
}

