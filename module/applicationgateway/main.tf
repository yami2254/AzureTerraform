provider "azurerm" {
  features {}
  subscription_id = "536e0b63-b5a1-46b2-8908-eccc0a9c27c9"
  client_id       = "310dfeff-2227-4c22-833a-18e1170a5796"
  client_secret   = ""
  tenant_id       = "7d49e97a-1b9b-4907-81aa-24ff1ddf0bda"   
}
# resource group, vnet, subnet은 이미 배포된 것을 가정하고, data로 불러온다.

data "azurerm_resource_group" "example" {
  name     = var.resource_group_name
}

data "azurerm_virtual_network" "example" {
  name                = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_subnet" "frontend" {
  name                 = var.appgw_subnet_name
  resource_group_name  = data.azurerm_resource_group.example.name
  virtual_network_name = data.azurerm_virtual_network.example.name
}

data "azurerm_subnet" "backend" {
  name                 = var.appgw_subnet_name2
  resource_group_name  = data.azurerm_resource_group.example.name
  virtual_network_name = data.azurerm_virtual_network.example.name
}

resource "azurerm_public_ip" "example" {
  name                = var.public_ip.name
  resource_group_name = data.azurerm_resource_group.example.name
  location            = data.azurerm_resource_group.example.location
  allocation_method   = var.public_ip.allocation_method
  sku                 = var.public_ip.sku
}

# since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name      = "${data.azurerm_virtual_network.example.name}-beap"
  frontend_port_name             = "${data.azurerm_virtual_network.example.name}-feport"
  frontend_ip_configuration_name = "${data.azurerm_virtual_network.example.name}-feip"
  http_setting_name              = "${data.azurerm_virtual_network.example.name}-be-htst"
  listener_name                  = "${data.azurerm_virtual_network.example.name}-httplstn"
  request_routing_rule_name      = "${data.azurerm_virtual_network.example.name}-rqrt"
  redirect_configuration_name    = "${data.azurerm_virtual_network.example.name}-rdrcfg"
}

resource "azurerm_web_application_firewall_policy" "network" {
  name                = var.web_policy.name
  resource_group_name = data.azurerm_resource_group.example.name
  location            = data.azurerm_resource_group.example.location
  managed_rules {
    managed_rule_set {
      version = var.web_policy.version
    }
  }
}

resource "azurerm_application_gateway" "network" {
  name                = var.appgw
  resource_group_name = data.azurerm_resource_group.example.name
  location            = data.azurerm_resource_group.example.location

  firewall_policy_id = azurerm_web_application_firewall_policy.network.id


#고정값
  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = var.appgw_config.gateway_ip_configuration
    subnet_id = data.azurerm_subnet.frontend.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = var.appgw_config.frontend_port
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.example.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = var.appgw_config.backend_http_settings.cookie_based_affinity
    path                  = var.appgw_config.backend_http_settings.path
    port                  = var.appgw_config.backend_http_settings.port
    protocol              = var.appgw_config.backend_http_settings.protocol
    request_timeout       = var.appgw_config.backend_http_settings.request_timeout
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = var.appgw_config.http_listener
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = var.appgw_config.request_routing_rule.rule_type
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    priority                   = var.appgw_config.request_routing_rule.priority
  }
}