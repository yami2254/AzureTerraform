terraform {
    required_providers {
      azurerm = {
        version = "3.43.0"
      }
    }
}
provider "azurerm" {
  features {}   
}
# resource group, vnet, subnet은 이미 배포된 것을 가정하고, data로 불러온다.

data "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "frontend" {
  name                 = var.appgw_subnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}

resource "azurerm_public_ip" "pip" {
  name                = var.public_ip.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = var.public_ip.allocation_method
  sku                 = var.public_ip.sku
  zones               = var.isZones? var.appgw_config.zones : null
}



resource "azurerm_web_application_firewall_policy" "network" {
  count = var.isWAF ? 1:0  
  name                = var.web_policy.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  managed_rules {
    managed_rule_set {
      version = var.web_policy.version
    }
  }
}

resource "azurerm_application_gateway" "network" {
  name                = var.appgw_config.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  firewall_policy_id = var.isWAF? azurerm_web_application_firewall_policy.network[0].id : null
  zones               = var.isZones? var.appgw_config.zones : null
#고정값
  sku {
    name     = var.isWAF? "WAF_v2" : "Standard_v2"
    tier     = var.isWAF? "WAF_v2" : "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = var.appgw_config.gateway_ip_configuration
    subnet_id = data.azurerm_subnet.frontend.id
  }

  frontend_port {
    name = var.appgw_config.frontend_port.name
    port = var.appgw_config.frontend_port.port
  }

  frontend_ip_configuration {
    name                 = var.appgw_config.frontend_ip_configuration
    public_ip_address_id = azurerm_public_ip.pip.id
  }

  backend_address_pool {
    name = var.appgw_config.backend_address_pool
  }

  backend_http_settings {
    name                  = var.appgw_config.backend_http_settings.name
    cookie_based_affinity = var.appgw_config.backend_http_settings.cookie_based_affinity
    path                  = var.appgw_config.backend_http_settings.path
    port                  = var.appgw_config.backend_http_settings.port
    protocol              = var.appgw_config.backend_http_settings.protocol
    request_timeout       = var.appgw_config.backend_http_settings.request_timeout
  }

  http_listener {
    name                           = var.appgw_config.http_listener.name
    frontend_ip_configuration_name = var.appgw_config.frontend_ip_configuration
    frontend_port_name             = var.appgw_config.frontend_port.name
    protocol                       = var.appgw_config.http_listener.protocol
  }

  request_routing_rule {
    name                       = var.appgw_config.request_routing_rule.name
    rule_type                  = var.appgw_config.request_routing_rule.rule_type
    http_listener_name         = var.appgw_config.http_listener.name
    backend_address_pool_name  = var.appgw_config.backend_address_pool
    backend_http_settings_name = var.appgw_config.backend_http_settings.name
    priority                   = var.appgw_config.request_routing_rule.priority
  }
}