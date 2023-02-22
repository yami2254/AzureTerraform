resource_group_name = "example-resources"
virtual_network_name = "example-network"
public_ip = {
    allocation_method = "Static"
    name = "bastion-pip"
    sku = "Standard"
}

isZones = false
bastion = {
    name = "bastion-koo"
    ip_configuration = {
        name = "configuration"
    }
}