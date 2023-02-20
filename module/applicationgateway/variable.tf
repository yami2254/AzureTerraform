variable "resource_group_name" {
  type = string
  default = "example-resources"
}
variable "virtual_network_name" {
  type = string
  default = "example-network"
}

variable "appgw_subnet_name" {
  type = string
  default = "frontend"
}


variable "public_ip" {
  type = object({
    name = string
    allocation_method = string
    sku = string
  })
  default = {
    name = "example-pip"
    allocation_method = "Static"
    sku = "Standard"
  }
}

# WAF 사용하면 true
variable "isWAF" {
  type = bool
  default = true
}

# isWAF가 true일 때 배포됨.
variable "web_policy" {
  type = object({
    name = string
    version = string
  })
  default = {
    name = "example-webpolicy"
    version = "3.2"
  }
  }

variable "isZones" {
  type = bool
  default = true
}

#appgw_config 쪽에 variable 모두 합치기 필요
variable "appgw_config" {
  type = object({
    name = string
    gateway_ip_configuration = string
    frontend_port = object({
        name = string
        port = number
    })
    frontend_ip_configuration = string
    backend_address_pool = string
    backend_http_settings = object({
        name = string
        cookie_based_affinity = string
        path = string
        port = number
        protocol = string
        request_timeout = number       
    })
    http_listener = object({
        name = string
        protocol = string
    })
    request_routing_rule = object({
        name = string
        rule_type = string
        priority = number        
    })
    zones = list(string)

  })
  default = {
    name = "example-appgw"
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
}