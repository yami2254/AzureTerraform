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
# resource group, vnet, subnet은 이미 배포된 것을 가정하고, data로 불러온다.

data "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "AzureFirewallSubnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}

resource "azurerm_public_ip" "pip" {
  name                = var.public_ip.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = var.public_ip.allocation_method
  sku                 = var.public_ip.sku
  zones               = var.isZones? var.firewall.zones : null
}

resource "azurerm_firewall_policy" "firewall-policy" {
  name                = var.firewall-policy
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
}

resource "azurerm_firewall" "firewall" {
  name                = var.firewall.name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku_name            = var.firewall.sku_name
  sku_tier            = var.firewall.sku_tier
  zones               = var.isZones? var.firewall.zones : null
  firewall_policy_id = azurerm_firewall_policy.firewall-policy.id

  ip_configuration {
    name                 = var.firewall.ip_configuration.name
    subnet_id            = data.azurerm_subnet.AzureFirewallSubnet.id
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}