provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg_exist" {
    name     = var.resource_group_name
}

resource "azurerm_iothub" "example" {
  name                = var.iothub.name
  resource_group_name = data.azurerm_resource_group.rg_exist.name
  location            = data.azurerm_resource_group.rg_exist.location

  sku {
    name     = var.iothub.sku_name
    capacity = var.iothub.sku_capacity
  }


  }
