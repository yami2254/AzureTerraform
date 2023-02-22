resource_group_name = "example-resources"
virtual_network_name = "example-network"
public_ip = {
  name = "fw-pip"
  allocation_method = "Static"
  sku = "Standard"
}

firewall-policy = "example-policy"
isZones = true
firewall = {
    name = "fw-koo-3"
    sku_name = "AZFW_VNet"
    sku_tier = "Standard"
    zones = ["1"]
    ip_configuration = {
      name = "configuration"
    }
}