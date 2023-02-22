terraform {
    required_providers {
      azurerm = {
        version = "3.43.0"
      }
    }
}
provider "azurerm" {
  features {}
    subscription_id        = "536e0b63-b5a1-46b2-8908-eccc0a9c27c9"
    client_id              = "310dfeff-2227-4c22-833a-18e1170a5796"
    client_secret          = ""
    tenant_id              = "7d49e97a-1b9b-4907-81aa-24ff1ddf0bda"   
  }

# resource group, vnet, subnet은 이미 배포된 것을 가정하고, data로 불러온다.

data "azurerm_resource_group" "rg" {
  name                   = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                   = var.virtual_network_name
  resource_group_name    = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "AzureBastionSubnet" {
  name                   = "AzureBastionSubnet"
  resource_group_name    = data.azurerm_resource_group.rg.name
  virtual_network_name   = data.azurerm_virtual_network.vnet.name
}

resource "azurerm_public_ip" "pip" {
  name                   = var.public_ip.name
  resource_group_name    = data.azurerm_resource_group.rg.name
  location               = data.azurerm_resource_group.rg.location
  allocation_method      = var.public_ip.allocation_method
  sku                    = var.public_ip.sku
  zones                  = var.isZones? ["1","2","3"] : null
}

resource "azurerm_bastion_host" "bastion" {
  name                   = var.bastion.name
  location               = data.azurerm_resource_group.rg.location
  resource_group_name    = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                 = var.bastion.ip_configuration.name
    subnet_id            = data.azurerm_subnet.AzureBastionSubnet.id
    public_ip_address_id = azurerm_public_ip.pip.id
  }
} 