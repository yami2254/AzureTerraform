import_resource_group_name = "ski-common-network-rg"
import_vnet = "common-001-vnet"
subnet_name = ["ski-btss-prod-ap-subnet"]


#UDR TABLE# // MAP형식 For_each
route_table_name = "ski-btss-prod-ap-subnet-udr"   // route_table_name은 string만 가능 array X

udr = {
    ski-btss-AZhubfw01 = {
        route_name = "ski-btss-AZhubfw01"
        address_prefix  = "10.78.130.133/32" //고정 값
        next_hop_in_ip_address = "10.78.130.133" //고정 값
    }
        ski-btss-AZhubfw02 = {
        route_name = "ski-btss-AZhubfw02"
        address_prefix  = "10.78.130.134/32" //고정 값
        next_hop_in_ip_address = "10.78.130.134" //고정 값
    }
        ski-btss-hub = {
        route_name = "ski-btss-hub"
        address_prefix  = "10.78.128.0/21" //고정 값
        next_hop_in_ip_address = "10.78.130.132" //고정 값
    }
        ski-btss-ingresslb = {
        route_name = "ski-btss-ingresslb"
        address_prefix  = "0.0.0.0/0" //고정 값
        next_hop_in_ip_address = "10.78.130.132" //고정 값
    }
}
tags = {
    cz-org         = "Hybrid Cloud1그룹"
    cz-owner           = "홍승현"
    cz-appl      = "UDR"
    cz-createdby        = "IaC"
    cz-ext2 = "SKC&C"
    cz-ext3 = "IaaS"
}
#-----"수정하지 말 것"
subnet_count = 1
vnet_name = "ski-btss-vnet-01"