provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg_exist" {
    for_each = var.publicipaddress
    name     = each.value.resource_group_name
}

resource "azurerm_public_ip" "example" {
    for_each             = var.publicipaddress
    name                 = each.value.name
    resource_group_name  = data.azurerm_resource_group.rg_exist[each.key].name
    location             = data.azurerm_resource_group.rg_exist[each.key].location
    sku                  = each.value.sku
    allocation_method    = "Static"
    

}