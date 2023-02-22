tags = {
    key1 = "Value3"
    key2 = "Value2"
}
security_group_name = ["az-test-dev-subnet-nsg","az-test-prod-subnet-nsg"]
#Subnet에 할당 할때만 사용되는 변수 값
# subnet_name     = ["az-test-db-subnet","az-test-iaas-subnet"]
# vnet_resource_group_name = "az-test-network-rg"
# vnet_name = "az-test-vnet-001"

#삭제 예정
subscription_id= "54923c86-6e79-4849-b293-ca83bcb3a69a"
tenant_id="1377b5c9-052d-44cc-84ed-6cf503d266df"
client_id="08f3c36c-ae0f-4c55-a932-906373aade01"
client_secret="hTa8Q~Nbc4yhj8uj6S.dsuhvgTkwAjumrFabya0E"
resource_group_name = "testrg"

inbound_rules = [["rule1","300","Allow","Tcp",]]

network_security_group_name = each.value.security_group_name
  name                        = each.value.name
  priority                    = each.value.priority
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_address_prefixes     = lookup(each.value, "source_address_prefixes", "*")
  source_port_ranges           = lookup(each.value, "source_port_ranges", "*")
  destination_address_prefixes  = lookup(each.value, "destination_address_prefixes", "*")
  destination_port_ranges      = lookup(each.value, "destination_port_ranges", "*")
  description                 = lookup(each.value, "description", null)

inbound_rules = [ {
       security_group_name        = "az-test-dev-subnet-nsg"
       ,name                       = "AllowAllTCPOutbound"
       ,priority                   = "300"
       ,access                     = "Allow"
       ,protocol                   = "Tcp"
       ,source_address_prefixes  = ["11.11.22.0/24","22.22.33.0/24"]
       ,source_port_ranges          = ["1-65535"]
       ,destination_address_prefixes = ["11.11.11.0/24","22.22.22.0/24"]
       ,destination_port_ranges     = ["1-65535"]
       ,description                = "~~HTTP 웹 서비스를 위함"
       #division                   = 1
     },
     {
       security_group_name        = "az-test-dev-subnet-nsg"
       ,name                       = "DenyAllUDPOutbound"
       ,priority                   = "301"
       ,access                     = "Deny"
       ,protocol                   = "Udp"
       ,source_address_prefixes  = ["0.0.0.0/0"]
       ,source_port_ranges          = ["1-65535"]
       ,destination_address_prefixes = ["0.0.0.0/0"]
       ,destination_port_ranges     = ["1-65535"]
       ,description                = ""
       #division                   = 2
     } ]