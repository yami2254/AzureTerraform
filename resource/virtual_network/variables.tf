#############################################################################
variable "subid" {type=string }
variable "location" {
    default = "koreacentral"
}
#############################################################################
variable "tags" {
  type        = map(string)
} 
variable "key" {}
variable "container_name" {}
variable "storage_account_name" {}
variable "resource_group_name" {}
variable "vnet_name" {}
variable "cidr" {
  type = list(string)
}
variable "subnet" {
  type = list(string)
}

variable "is_portal_vnet" {}
variable "is_portal_subnet" {}

variable "import_resource_group_name" {}
variable "import_vnet" {}

variable "subnet_name" {
  type = list(string)
}

#############################################################################
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







