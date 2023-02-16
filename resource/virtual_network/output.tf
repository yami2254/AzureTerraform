
/*# output about EXIST vnet
output "virtual_network_id"{
 value = data.azurerm_virtual_network.import-vnet.id
}

output "resource_group_name" {
 value = data.azurerm_resource_group.import-rg.id
}
*/
/*
# output about NEW virtual network
output "resource_group_name" {
  description = "The name of the newly created resource group"
  value       = data.azurerm_resource_group.network
}


output "vnet_name" {
  description = "The name of the newly created vNet"
  value       = module.network.vnet_name
}

output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = module.network.vnet_address_space
}
*/
// OUTPUT 파일 현재 코드에서 불필요


