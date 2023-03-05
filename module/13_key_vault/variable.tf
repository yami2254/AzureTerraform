variable "resource_group_name" {
  type = string
  default = "example-resources"
}

variable "keyvault" {
  type = object({
    name = string
    sku_name = string
    soft_delete_retention_days = number
    purge_protection_enabled = bool

  })

}

#hi