#############################################################################
variable "subid" {type=string }
variable "location" {
    default = "koreacentral"
}
variable "project_name" {
    default = "ski-btss"
}
variable "tags" {
  type        = map(string)
}
variable "resource_group_name" {}
variable "security_group_name" {
  type = list(string)
}
variable "key" {}
variable "container_name" {}
variable "storage_account_name" {}
variable "subnet_name" {}
variable "subnet_count" {}
variable "vnet_name" {}

variable "is_portal_vnet" {}
variable "is_portal_subnet" {}

variable "import_vnet" {}
variable "import_resource_group_name" {}

variable "region_list" {
  type        = map(string)
  
  default     = {
    eastasia            = "asea",
    southeastasia       = "assw",
    centralus           = "usce",
    eastus              = "usea",
    eastus2             = "use2",
    westus              = "uswe",
    westus2             = "usw2",
    northcentralus      = "usnc",
    southcentralus      = "ussc",
    westcentralus       = "uswc",
    northeurope         = "euno",
    westeurop           = "euwe",
    japanwest           = "jawe",
    japaneast           = "jaea",
    brazilsouth         = "brso",
    australiaeast       = "auea",
    australiasoutheast  = "ause",
    southindia          = "inso",
    centralindia        = "ince",
    westindia           = "inwe",
    canadacentral       = "cace",
    canadaeast          = "caea",
    uksouth             = "ukso",
    ukwest              = "ukwe",
    koreacentral        = "koce",
    koreasouth          = "koso",
    francecentral       = "frce",
    francesouth         = "frso",
    australiacentral    = "auce",
    australiacentral2   = "auc2",
    southafricanorth    = "sano",
    southafricawest     = "sawe"
  }
}

variable "inbound_rules" {
    type = list(object({
    security_group_name = string
    name = string
    priority = string
    access = string
    protocol = string
    source_address_prefixes = list(string)
    #source_port_range = string
    source_port_ranges = list(string)
    destination_address_prefixes = list(string)
    #destination_port_range = string
    destination_port_ranges = list(string)
    description = string
    division  = number //추가
  }))
  
  description = "List of objects that represent the configuration of each inbound rule."
   default = [

   ]
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




