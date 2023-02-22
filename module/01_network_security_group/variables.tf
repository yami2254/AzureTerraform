variable "resource_group_name" {
  type        = string
}
variable "security_group_name" {
  type = list(string)
}
variable "tags" {
  type        = map(string)
}
variable "location"{
  default = "koreacentral"
}
variable "subnet_name" {
  type = list(string)
}
variable "vnet_name" {
  type = string
}
variable "vnet_resource_group_name" {
  type = string
}
variable "inbound_rules" {
   type = list(object({
    security_group_name = string
    name = string
    priority = string
    access = string
    protocol = string
    source_address_prefixes = list(string)
    source_port_ranges = list(string) // ??
    destination_address_prefixes = list(string)
    destination_port_ranges = list(string) // ??
    description = string
    division  = number //??
  }))
}

variable "outbound_rules" {
   type = list(object({
    security_group_name = string
    name = string
    priority = string
    access = string
    protocol = string
    source_address_prefixes = list(string)
    source_port_ranges = list(string) // ??
    destination_address_prefixes = list(string)
    destination_port_ranges = list(string) // ??
    description = string
    division  = number //??
  }))
}