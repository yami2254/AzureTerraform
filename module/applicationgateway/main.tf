provider "azurerm" {
  features {}
}
variable "resource_group_name" {
  type = string
  default = "example-resources"
}
data "azurerm_resource_group" "example" {
  name     = "example-resources"

}

data "azurerm_virtual_network" "example" {
  name                = "example-network"
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_subnet" "frontend" {
  name                 = "frontend"
  resource_group_name  = data.azurerm_resource_group.example.name
  virtual_network_name = data.azurerm_virtual_network.example.name
}

data "azurerm_subnet" "backend" {
  name                 = "backend"
  resource_group_name  = data.azurerm_resource_group.example.name
  virtual_network_name = data.azurerm_virtual_network.example.name
}

resource "azurerm_public_ip" "example" {
  name                = "example-pip"
  resource_group_name = data.azurerm_resource_group.example.name
  location            = data.azurerm_resource_group.example.location
  allocation_method   = "Static"
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

resource "azurerm_application_gateway" "network" {
  name                = "example-appgateway"
  resource_group_name = data.azurerm_resource_group.example.name
  location            = data.azurerm_resource_group.example.location

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = data.azurerm_subnet.frontend.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
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
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    priority = 10
  }
}