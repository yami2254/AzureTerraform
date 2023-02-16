variable "islinuxwebapp" {
  type = bool
  default = true
}
variable "iswindowswebapp" {
  type = bool
  default = true
}

variable "linux_sku_name" {
  type = string
}

variable "windows_sku_name" {
  type = string
}


variable "windowswebapp" {
  type = list(object({
    name = string
  }))
}

variable "linuxwebapp" {
  type = list(object({
    name = string
  }))
}