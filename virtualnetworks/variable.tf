# variable "resource_group_name" {
#     type = string
  
# }

# variable "virtualnetwork" {
#   type = map(string)
# }

# variable "subnet" {
#   type = map(object({

#   }))
# }

variable "set" {
  type = map(object({
    resource_group_name = string
    virtualnetwork = any
    subnet = map(object({
            name = string
    address_prefixes = string
    }))
  }))
}