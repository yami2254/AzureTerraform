resource_group_name = "example-resources"
virtual_network_name = "example-network"
public_ip = {
  name = "fw-pip"
  allocation_method = "Static"
  sku = "Standard"
}

firewall-policy = "example-policy"
isZones = false
firewall = {
    name = "fw-koo-2"
    sku_name = "AZFW_VNet"
    sku_tier = "Standard"
    zones = ["1","2","3"]
    ip_configuration = {
      name = "configuration"
    }
}