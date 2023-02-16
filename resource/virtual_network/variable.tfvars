#----Azure DevOps Variable에서 처리되는 부분으로 주석
# resource_group_name = "ski-cims-dev-rg"
# vnet_name = "ski-cims-vnet-01"
# cidr = ["10.4.0.0/16"]
# subnet = ["10.4.1.0/24","10.4.2.0/24"]
# subnet_name = ["ski-cims-dev-ap-subnet", "ski-cims-dev-db-subnet"]

# tags = {
#    cz-corp         = "SK이노베이션"
#    cz-oc           = "SK이노베이션"
#    cz-project      = "전화정보시스템"
#    cz-org          = "Hybrid Cloud2그룹"
#    cz-owner        = "XXX"
#    cz-appl         = "Network"
#    cz-stage        = "개발"
#    cz-created      = "2022-05-XX"
#    cz-createdby    = "XXX"
# }

#-----"수정하지 말 것"
is_portal_vnet = false
is_portal_subnet = false
import_vnet = "import-vnet"
import_resource_group_name = "import-rg"
location            = "koreacentral"