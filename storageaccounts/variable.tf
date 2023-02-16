variable "storageaccount" {
    type = map(object({
        name = string
        account_tier = string
        account_replication_type = string
        resource_group_name = string
    }))
    
}