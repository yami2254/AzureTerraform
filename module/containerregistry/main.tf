provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg_exist" {
    name     = "a-rg"
}


resource "azurerm_container_registry" "acr" {
  name                = "containerRegistry1"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard"
  admin_enabled       = false

}