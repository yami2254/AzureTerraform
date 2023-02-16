provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg_exist" {
    for_each = var.storageaccount
    name     = each.value.resource_group_name

}

resource "azurerm_storage_account" "example" {
  for_each                 = var.storageaccount
  name                     = each.value.name
  resource_group_name      = data.azurerm_resource_group.rg_exist[each.key].name
  location                 = data.azurerm_resource_group.rg_exist[each.key].location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}