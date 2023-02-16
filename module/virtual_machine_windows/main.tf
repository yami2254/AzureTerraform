data "azurerm_resource_group" "rg" {
  name = var.resource_group_name    
}


data "azurerm_resource_group" "import-rg" {
  count = var.is_portal_vnet == false ? 0 : 1
  name = var.import_resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name = var.is_portal_vnet == false ? var.vnet_name : var.import_vnet
  resource_group_name = var.is_portal_vnet == false ? var.resource_group_name : var.import_resource_group_name
}

data "azurerm_subnet" "subnet"{
  count = var.is_portal_subnet == false ? var.number_instances : 0
  
  name = var.subnet_name[count.index]
  resource_group_name = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}

data "azurerm_subnet" "subnet-exist"{
  count = var.is_portal_subnet == false ? 0 : var.subnet_count
  
  name = var.subnet_name[count.index]
  resource_group_name = var.is_portal_vnet == false ? var.resource_group_name : var.import_resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}


locals {
  ssh_keys = compact([var.ssh_key])
}

resource "azurerm_network_interface" "nic" {
  for_each                      = var.vms
  name                          = "${each.value.vm_name}-nic"
  resource_group_name           = data.azurerm_resource_group.rg.name
  location                      = data.azurerm_resource_group.rg.location


  ip_configuration {
    name                          = "${each.value.vm_name}-ip"
    subnet_id                     =  var.is_portal_subnet == true ? data.azurerm_subnet.subnet-exist[0].id : data.azurerm_subnet.subnet[0].id
    private_ip_address_allocation = "Dynamic"
    #private_ip_address =  each.value.private_ip_addresses //불필요
    #public_ip_address_id        = azurerm_public_ip.vm[each.key].id //불필요
  }

  tags = var.tags
}
/*
data "azurerm_network_security_group" "nsg" {
  name                      = var.network_security_group_name
  resource_group_name       = var.resource_group_name
}
*/

#PPG
/*
resource "azurerm_proximity_placement_group" "ppg" {
  name                         = var.ppg_name
  resource_group_name          = data.azurerm_resource_group.rg.name
  location                     = data.azurerm_resource_group.rg.location
  tags                         = var.tags
}
*/
data "azurerm_proximity_placement_group" "ppg" {
  count                        = var.is_server_HA == false ? 0:1
  name                         = var.ppg_name
  resource_group_name          = data.azurerm_resource_group.rg.name
}

#AVset 요구사항 반영
resource "azurerm_availability_set" "vm" {
  for_each                      = var.vms
  name                          = "${each.value.avs_name}-avs" // vm_name -> avs_name으로 변경
  resource_group_name          = data.azurerm_resource_group.rg.name
  location                     = data.azurerm_resource_group.rg.location
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed                      = true
  proximity_placement_group_id  = var.is_server_HA == false ? null:data.azurerm_proximity_placement_group.ppg[0].id
  tags                         = var.tags
  depends_on          = [data.azurerm_proximity_placement_group.ppg]

}

resource "azurerm_windows_virtual_machine" "vm-windows" {
  for_each                      = var.vms
  name                          = each.value.vm_name
  resource_group_name           = data.azurerm_resource_group.rg.name
  location                      = data.azurerm_resource_group.rg.location
  availability_set_id           = azurerm_availability_set.vm[each.key].id
  proximity_placement_group_id  = var.is_server_HA == false ? null:data.azurerm_proximity_placement_group.ppg[0].id
  size                          = var.vm_size
  network_interface_ids         = [azurerm_network_interface.nic[each.key].id]
  license_type                  = var.license_type
  admin_username                = var.admin_username
  admin_password                = var.admin_password
  provision_vm_agent = "true"
  enable_automatic_updates =   "false"
  patch_mode    = "Manual"
    os_disk {
    name              = "${each.value.os_disk_name}"
    disk_size_gb      = each.value.disk_size_gb
    caching           = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
}
   /* boot_diagnostics {
      storage_account_uri = var.storage_account_uri
    }*/
 
  source_image_id              = var.img_id
  tags = var.tags
  depends_on          = [data.azurerm_proximity_placement_group.ppg]
}


resource "azurerm_managed_disk" "data-disk" {
  for_each          = var.disk
  disk_size_gb      = each.value.disk_size_gb
  name          = "${each.value.data_disk_name}"
  create_option       = "Empty" 
  resource_group_name = data.azurerm_resource_group.rg.name
  location =  data.azurerm_resource_group.rg.location
  storage_account_type = "StandardSSD_LRS"
  tags = var.tags
  max_shares        = var.max_shares
}


resource "azurerm_virtual_machine_data_disk_attachment" "disk-attach" {
  for_each          = var.disk
  create_option      = "Attach"
  managed_disk_id    = azurerm_managed_disk.data-disk[each.key].id
  virtual_machine_id = azurerm_windows_virtual_machine.vm-windows[each.value.vm_index_name].id
  lun                = each.value.lun 
  caching            = "None" //공유 디스크 사용 시, None // AS-IS : ReadWrite
}

/*
resource "azurerm_public_ip" "vm" {
  for_each                      = var.vms
  name                          = each.key
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = var.allocation_method
  sku                 = var.public_ip_sku
  tags                = var.tags
}


// Dynamic public ip address will be got after it's assigned to a vm
data "azurerm_public_ip" "vm" {
  for_each                      = var.vms
  name                          = each.key
  resource_group_name = data.azurerm_resource_group.rg.name
  depends_on          = [azurerm_windows_virtual_machine.vm-windows]
}
*/
