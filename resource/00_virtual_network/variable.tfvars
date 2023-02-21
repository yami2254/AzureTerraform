#예시
resource_group_name = "testrg"
vnet_name = "az-test-vnet-001"
cidr = ["10.4.0.0/16"]
subnet = ["10.4.1.0/24","10.4.2.0/24"]
subnet_name = ["az-test-dev-ap-subnet", "az-test-dev-db-subnet"]
tags = {
    key1 = "Value3"
    key2 = "Value2"
}
location            = "koreacentral"