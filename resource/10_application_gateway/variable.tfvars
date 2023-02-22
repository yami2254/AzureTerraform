resource_group_name = "example-resources"
virtual_network_name = "example-network"
appgw_subnet_name = "frontend"

public_ip = {
  allocation_method = "Static"
  name = "example-pip"
  sku = "Standard"
}

isWAF = true

web_policy = {
  name = "example-webpolicy"
  version = "3.2"
}

isZones = true

appgw_config = {
    name = "example-appgw-test"
    gateway_ip_configuration = "my-gateway-ip-configuration"
    frontend_port = {
        name = "frontend"
        port = 80
    }
    frontend_ip_configuration = "frontend-ipconfig"
    backend_address_pool = "backend-pool"
    backend_http_settings = {
        name = "backend-settings"
        cookie_based_affinity = "Disabled"
        path = "/path1"
        port = 80
        protocol = "Http"
        request_timeout = 60
    }
    
    http_listener = {
        name = "http-listener"
        protocol = "Http"
    }
    request_routing_rule = {
        name = "route-rule"
        priority = 10
        rule_type = "Basic"
    }
    zones = ["1","2","3"]
}