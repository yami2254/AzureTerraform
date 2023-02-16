set = {
    set1 = {
        resource_group_name = "koo-adt-dev-kc-onm-rg"
        virtualnetwork = {
        name = "koo-adt-dev-engine-test"
        address_space = "10.0.0.0/16"
        }

    subnet = {
        subnet1 = {
            name = "default"
            address_prefixes = "10.0.0.0/24"
        }
    }
    }

    set2 = {
        resource_group_name = "koo-adt-engine-dev"
        virtualnetwork = {
        name = "koo-adt-engine-dev-vnet"
        address_space = "10.1.0.0/16"
        }

    subnet = {
        subnet1 = {
            name = "default"
            address_prefixes = "10.1.0.0/24"
        }
    }
    }
}


