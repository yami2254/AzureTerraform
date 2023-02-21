variable "resource_group_name" {
  description = "The name of an existing resource group to be imported."
  type        = string
}

variable "security_group_name" {
  description = "Name of the nsg to create."
  default     = ["nsg"]
}

variable "tags" {
  description = "The tags to associate with your network security group"
  type        = map(string)
}

variable "location"{
  default = "koreacentral"
}

variable "inbound_rules" {
   type = list(object({
    security_group_name = string
    name = string
    priority = string
    access = string
    protocol = string
    #source_address_prefix  = string
    source_address_prefixes = list(string)
    #source_port_range = string // ??
    source_port_ranges = list(string) // ??
    #destination_address_prefix = string
    destination_address_prefixes = list(string)
    #destination_port_range = string //??
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
    #source_address_prefix  = string
    source_address_prefixes = list(string)
    #source_port_range = string // ??
    source_port_ranges = list(string) // ??
    #destination_address_prefix = string
    destination_address_prefixes = list(string)
    #destination_port_range = string //??
    destination_port_ranges = list(string) // ??
    description = string
    division  = number //??
  }))
}

variable "subnet_name" {}
variable "subnet_count" {}
variable "is_portal_vnet" {
  type = bool
  default = true
}
variable "is_portal_subnet" {
  type = bool
  default = true
}
variable "vnet_name" {}
variable "import_resource_group_name" {}
variable "import_vnet" {}
