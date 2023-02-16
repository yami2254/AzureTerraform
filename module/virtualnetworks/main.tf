provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "example" {
  for_each = var.set
  name                 = each.value.resource_group_name
  
}

resource "azurerm_virtual_network" "example" {
  for_each             = var.set
  name                 = each.value.virtualnetwork.name
  location             = data.azurerm_resource_group.example[each.key].location
  resource_group_name  = data.azurerm_resource_group.example[each.key].name
  address_space        = each.value.virtualnetwork.address_space

  dynamic "subnet" {
    for_each = each.value.subnet
    content {
      name = subnet.value["name"]
      address_prefix = subnet.value["address_prefixes"]
    }
  }
}