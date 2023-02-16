variable "resource_group_name" {
  description = "The name of an existing resource group to be imported"
  type        = string
}

# variable "network_security_group_name"{
#  type        = string
#    default     = ""
# }

## About VM Instatnce
variable "vm_hostname" {
  description = "local name of the Virtual Machine."
  type        = list(string)
  default     = ["ski-iac-vm"]
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  type        = string
  default     = "Standard_D2s_v3"
}

variable "number_instances" {
  description = "Specify the number of vm instances."
  type        = number
  default     = 1
}

variable "vm_os_defined" {
  description = "Specify UbuntuServer, WindowsServer, RHEL, openSUSE-Leap, CentOS, Debian, CoreOS and SLES to get the latest image version of the specified os. "
  type        = string
  default     = ""
}

variable "vm_os_custom" {
  description = "The resource ID of the image that you want to deploy if you are using a custom image.Note, need to provide is_windows_image = true for windows custom images."
  type        = string
  default     = ""
}

variable "vm_os_publisher" {
  description = "The name of the publisher of the image that you want to deploy. This is ignored when vm_os_id or vm_os_defined are provided."
  type        = string
  default     = ""
}

variable "vm_os_offer" {
  description = "The name of the offer of the image that you want to deploy. This is ignored when vm_os_id or vm_os_defined are provided."
  type        = string
  default     = ""
}

variable "vm_os_sku" {
  description = "The sku of the image that you want to deploy. This is ignored when vm_os_id or vm_os_defined are provided."
  type        = string
  default     = ""
}

variable "vm_os_version" {
  description = "The version of the image that you want to deploy. This is ignored when vm_os_id or vm_os_defined are provided."
  type        = string
  default     = "latest"
}

variable "is_windows_image" {
  description = "Boolean flag to notify when the custom image is windows based."
  type        = bool
  default     = false
}


variable "data_sa_type" {
  description = "Data Disk Storage Account type."
  type        = string
  default     = "Standard_LRS"
}

variable "data_disk_size_gb" {
  description = "Storage data disk size size."
  type        = list(number)
  default     = [30]
}

variable "number_data_disk" {
  description = "(Optional) Number of the data disks attached to each virtual machine."
  type        = number
  default     = 0
}

variable "delete_os_disk_on_termination" {
  type        = bool
  description = "Delete datadisk when machine is terminated."
  default     = false
}

variable "delete_data_disks_on_termination" {
  type        = bool
  description = "Delete data disks when machine is terminated."
  default     = false
}


# About Network
variable "allocation_method" {
  description = "Defines how an IP address is assigned. Options are Static or Dynamic."
  type        = string
  default     = "Dynamic"
}

variable "public_ip_sku" {
  description = "Defines the SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic."
  type        = string
  default     = "Basic"
}

variable "remote_port" {
  description = "Remote tcp port to be used for access to the vms created via the nsg applied to the nics."
  type        = string
  default     = ""
}

variable "source_address_prefixes" {
  description = "(Optional) List of source address prefixes allowed to access var.remote_port."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# About Secret

variable "enable_ssh_key" {
  type        = bool
  description = "(Optional) Enable ssh key authentication in Linux virtual Machine."
  default     = true
}

variable "ssh_key" {
  description = "Path to the public key to be used for ssh access to the VM. e.g. c:/home/id_rsa.pub."
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_key_values" {
  description = "List of Public SSH Keys values to be used for ssh access to the VMs."
  type        = list(string)
  default     = []
}

variable "admin_username" {
  description = "The admin username of the VM that will be deployed."
  type        = string
  #default     = "skiadmin"
}

variable "admin_password" {
  description = "The admin password to be used on the VMSS that will be deployed. The password must meet the complexity requirements of Azure."
  type        = string
  #default     = "Cloud2022!@#$"
}

# BYOL 
variable "license_type" {
  description = "Specifies the BYOL Type for this Virtual Machine. This is only applicable to Windows Virtual Machines. Possible values are Windows_Client and Windows_Server"
  type        = string
  default     = null
}

# Cloud-Init Script
variable "custom_data" {
  description = "The custom data to supply to the machine. This can be used as a cloud-init for Linux systems."
  type        = string
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "A map of the tags to use on the resources that are deployed"

  # default = {
  #   environment = "prod"
  # }
}

variable "subnet_name" {}
variable "img_id" {}

variable "vnet_name" {}
variable "is_portal_vnet" {
  type = bool
  default = true
}
variable "is_portal_subnet" {
  type = bool
  default = true
}
variable "import_resource_group_name" {}

variable "import_vnet" {}
variable "subnet_count" {}

variable "storage_account_uri" {}

variable "max_shares" {
  default = null
}

variable "ppg_name" {
  type        = string
  default     = ""
}

variable "is_server_HA" {
  description = "is_server_HA=true"
  type        = bool
  default     = false
}

variable "vms" {
  type = map(object({
    vm_name = string
    #private_ip_addresses = string //불필요
    os_disk_name = string
    disk_size_gb = number
    avs_name = string // 추가
    nsg_name = string // 추가
  }))
}

variable "disk" {
  type = map(object({
    vm_index_name = string
    data_disk_name = string
    disk_size_gb = number
    lun = number
  }))
}