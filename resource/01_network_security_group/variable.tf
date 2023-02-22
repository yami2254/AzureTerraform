variable "tenant_id" {
  type = string
}
variable "subscription_id" {
  type = string
}
variable "client_id" {
  type = string
}
variable "client_secret" {
  type = string
}
variable "location" {
    default = "koreacentral"
}
variable "tags" {
  type = map(string)
}
variable "resource_group_name" {
  type = string
}
variable "security_group_name" {
  type = list(string)
}
variable "subnet_name" {
  type = list(string)
  default = []
}
variable "vnet_name" {
  type = string
  default = "default_vnet"
}
variable "vnet_resource_group_name" {
  type = string
  default = "default_vnet_rg"
}
variable "inbound_rules" {
   type = list(object({
    security_group_name = string
    name = string
    priority = string
    access = string
    protocol = string
    source_address_prefixes = list(string)
    source_port_ranges = list(string) //수정
    destination_address_prefixes = list(string)
    destination_port_ranges = list(string) //수정
    description = string
    division  = number //추가
  }))
  default = []
}

variable "outbound_rules" {
  type = list(object({
    security_group_name = string
    name = string
    priority = string
    access = string
    protocol = string
    source_address_prefixes = list(string)
    source_port_ranges = list(string) //수정
    destination_address_prefixes = list(string)
    destination_port_ranges = list(string) //수정
    description = string
    division  = number //추가
  }))
  default = []
}

#Rule 입력 예시
  /*
  description = "List of objects that represent the configuration of each outbound rule."
   default = [
     {
       security_group_name        = "ski-vdss-prod-ap1-nic-nsg"
       name                       = "AllowAllTCPOutbound"
       priority                   = "300"
       access                     = "Allow"
       protocol                   = "Tcp"
       source_address_prefixes  = ["11.11.22.0/24","22.22.33.0/24"]
       source_port_ranges          = ["1-65535"]
       destination_address_prefixes = ["11.11.11.0/24","22.22.22.0/24"]
       destination_port_ranges     = ["1-65535"]
       description                = "~~HTTP 웹 서비스를 위함"
       division                   = 1
     },
     {
       security_group_name        = "ski-vdss-prod-db1-nic-nsg"
       name                       = "DenyAllUDPOutbound"
       priority                   = "301"
       access                     = "Deny"
       protocol                   = "Udp"
       source_address_prefixes  = ["0.0.0.0/0"]
       source_port_ranges          = ["1-65535"]
       destination_address_prefixes = ["0.0.0.0/0"]
       destination_port_ranges     = ["1-65535"]
       description                = ""
       division                   = 2
     }
   ]
   */




