provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "example" {
  name                 = var.resource_group_name
  
}


resource "azurerm_eventhub_namespace" "example" {
  name                = var.eventhub_namespace.name
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name
  sku                 = var.eventhub_namespace.sku
  capacity            = var.eventhub_namespace.capacity

}



resource "azurerm_eventhub" "example" {
  for_each            = var.eventhub
  name                = each.value.name
  namespace_name      = azurerm_eventhub_namespace.example.name
  resource_group_name = data.azurerm_resource_group.example.name
  partition_count     = each.value.partition_count
  message_retention   = each.value.message_retention

}