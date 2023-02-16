variable "publicipaddress" {
    type = map(object({
        name = string
        resource_group_name = string
        sku = string
    }))
  
}