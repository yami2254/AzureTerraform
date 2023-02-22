data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}
module "network_security_rule"{
  source = "../../module/01_network_security_group"
  
  resource_group_name       = data.azurerm_resource_group.rg.name
  security_group_name       = var.security_group_name
  # inbound_rules             = var.inbound_rules
  # outbound_rules            = var.outbound_rules
  tags                      = var.tags
  #NSG가 만일 Subnet에 할당되고, Vnet이 다른 RG에 있는경우 필요한 값들
  subnet_name              = var.subnet_name
  vnet_name = var.vnet_name
  vnet_resource_group_name = var.vnet_resource_group_name

  depends_on                = [data.azurerm_resource_group.rg]
}