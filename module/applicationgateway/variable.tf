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

variable "appgw_subnet_name2" {
  type = string
  default = "backend"
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

variable "appgw" {
  type = string
  default = "example-appgateway"
}

/* variable "sku" {
  type = object({
    name = string
    tier = string
    capacity = number
  })
  default = {
    name = "WAF_v2"
    tier = "WAF_v2"
    capacity = 1
  }
}    */

#appgw_config 쪽에 variable 모두 합치기 필요
variable "appgw_config" {
  type = object({
    gateway_ip_configuration = string
    frontend_port = number
    backend_http_settings = object({
        cookie_based_affinity = string
        path = string
        port = number
        protocol = string
        request_timeout = number       
    })
    http_listener = string
    request_routing_rule = object({
        rule_type = string
        priority = number        
    })

  })
  default = {
    backend_http_settings = {
      cookie_based_affinity = "Disabled"
      path = "/path1"
      port = 80
      protocol = "Http"
      request_timeout = 60
    }
    frontend_port = 80
    gateway_ip_configuration = "my-gateway-ip-configuration"
    http_listener = "Http"
    request_routing_rule = {
      priority = 10
      rule_type = "Basic"
    }
  }
}
/* 

variable "gateway_ip_configuration" {
  type = string
  default = "my-gateway-ip-configuration"
}

variable "frontend_port" {
  type = number
  default = 80
}

variable "backend_http_settings" {
  type = object({
    cookie_based_affinity = string
    path = string
    port = number
    protocol = string
    request_timeout = number
  })
  default = {
    cookie_based_affinity = "Disabled"
    path = "/path1"
    port = 80
    protocol = "Http"
    request_timeout = 60
  }
}

variable "http_listener" {
  type = string
  default = "Http"
}

variable "request_routing_rule" {
  type = object({
    rule_type = string
    priority = number
  })
  default = {
    priority = 10
    rule_type = "Basic"
  }
} */