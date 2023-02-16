provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resourcegroup" {
    for_each            = var.resourcegroup
    name                = each.value.name
    location            = "Korea Central"
}