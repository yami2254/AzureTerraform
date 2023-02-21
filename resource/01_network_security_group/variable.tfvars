# tags = {
#     cz-org          = "Hybrid Cloud2그룹"
#     cz-owner        = "OOO"
#     cz-appl         = "NSG"
#     cz-region       = "한국중부"
#     cz-createdby    = "IaC"
#     cz-ext2         = "SKC&C"
#     cz-ext3         = "IaaS"
# }


is_portal_vnet = true
is_portal_subnet = true

# storage_account_name = "skiiacmvptprodtfstate1"
# resource_group_name = "ski-iacmvpt-prod-rg"
# container_name = "iacmvptprod-1"

# import_vnet = "ski-iacmvpt-001-vnet"
# import_resource_group_name = "ski-iacmvpt-network-rg"

vnet_name = "ski-iacmvpt-vnet-01"

#security_group_name = ["ski-iacmvpt-prod-db1-nic-nsg","ski-iacmvpt-prod-db2-nic-nsg"]
subnet_name     = ["ski-iacmvpt-prod-db-subnet"]
subnet_count    = 0
