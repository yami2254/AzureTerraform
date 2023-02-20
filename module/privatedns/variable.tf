variable "resource_group_name" {
  type = string
  default = "example-resources"
}

variable "private_dns_zone" {
    type = map(object({
        name = string
    }))

    default = {
      "blob" = {
        name = "privatelink.blob.core.windows.net"
      }
      "file" = {
        name = "privatelink.file.core.windows.net"
      }
      "keyvault" = {
        name = "privatelink.vaultcore.azure.net"
      }
    }
}