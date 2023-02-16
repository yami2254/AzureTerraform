variable "resource_group_name" {
    type = string
}
variable "eventhub_namespace" {
    type = map(string)
  
}

variable "eventhub" {
    type = map(object({
        name = string
        namespace_name = string
        partition_count = number
        message_retention = number
    }))
  
}