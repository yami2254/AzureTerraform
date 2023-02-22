terraform {
    required_providers {
      azurerm = {
        version = "3.43.0"
      }
    }
}
provider "azurerm" {
  features {}
  subscription_id = "536e0b63-b5a1-46b2-8908-eccc0a9c27c9"
  client_id       = "310dfeff-2227-4c22-833a-18e1170a5796"
  client_secret   = ""
  tenant_id       = "7d49e97a-1b9b-4907-81aa-24ff1ddf0bda"   
}


# private endpoint로 구축할 때, 지정된 이름 몇개 설정해 둠. blob, file, vault
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_private_dns_zone" "example" {
  for_each            = var.private_dns_zone
  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.rg.name
}