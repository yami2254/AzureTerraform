provider "azurerm" {
  features {
    
  }
  subscription_id = "536e0b63-b5a1-46b2-8908-eccc0a9c27c9"
  client_id       = "310dfeff-2227-4c22-833a-18e1170a5796"
  client_secret   = "8On8Q~21i_5OX.xaIRQ5rpxIaBPJHQaWcirf4cI8"
  tenant_id       = "7d49e97a-1b9b-4907-81aa-24ff1ddf0bda"   
}

resource "azurerm_resource_group" "resourcegroup" {
    for_each            = var.resourcegroup
    name                = each.value.name
    location            = "Korea Central"
}