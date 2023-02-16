#############################################################################
# These values are placeholders. You should set and use the values of '../project.tfvars'
variable "location" {
    default = "koreacentral"
}
variable "project_name" {
    default = "ski-btss"
}
variable "key" {}
variable "resource_group_name" {}
variable "container_name" {}

variable "storage_account_name"{}
variable "tags" {}
variable "import_resource_group_name" {
  default = ""
}

variable "vnet_name" {}
variable "import_vnet" {}
variable "subnet_name" {}
variable "subnet_count" {}

variable  "route_table_name" {}
# variable  "route_name" {}               
# variable  "address_prefixes" {}      
# variable  "next_hop_in_ip_address" {} 

variable "udr" {}

#############################################################################



