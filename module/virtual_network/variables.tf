variable "vnet_name" {
  description = "(Required) Name of the vnet to create"
  type        = string
  default     = "vnet"
}

variable "resource_group_name" {
  description = "(Required) The name of an existing resource group to be imported"
  type        = string
  default	= ""
}

variable "address_space" {
  description = "(Required) The address space that is used by the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "address_spaces" {
  description = "The list of the address spaces that is used by the virtual network"
  type        = list(string)
  default     = []
}

# If no values specified, this defaults to Azure DNS 
variable "dns_servers" {
  description = "The DNS servers to be used with vNet"
  type        = list(string)
  default     = []
}

variable "subnet_prefixes" {
  description = "(Required) The address prefix to use for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "subnet_name" {
  description = "(Required) A list of public subnets inside the vNet"
  type        = list(string)
  default     = ["subnet1"]
}

variable "tags" {
  description = "The tags to associate with your network and subnets"
  type        = map(string)
}

variable "location"{
  default = "koreacentral"
}
variable "is_portal_vnet" {
  type = bool
  default = true
}
variable "is_portal_subnet" {
  type = bool
  default = true
}
variable "import_vnet" {}
variable "import_resource_group_name" {}


