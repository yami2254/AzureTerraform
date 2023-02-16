#location            = data.azurerm_resource_group.rg.location
terraform {
  backend "azurerm" {
    resource_group_name  = var.resource_group_name
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
    key = var.key
  }
}


module "routetable" {
  #source              = "git::https://az34ru33l5zc4gnygsccgoobohdktj6ke7bu4n75uvmqw5wod7lq@dev.azure.com/ski-iac-org/ski-iac-mvp/_git/ski-iac-mvp-module//modules/route"
  source = "../../../SKI_IaC_Module/modules/virtual_machine_windows"
  vnet_name = var.vnet_name
  import_vnet = var.import_vnet
  import_resource_group_name = var.import_resource_group_name
  subnet_count = var.subnet_count
  subnet_name = var.subnet_name
  resource_group_name = var.resource_group_name
  route_table_name       = var.route_table_name
  udr                    = var.udr

  tags = var.tags
}