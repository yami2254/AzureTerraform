variable "tenant_id" {
  type = string
}
variable "subscription_id" {
  type = string
}
variable "client_id" {
  type = string
}
variable "client_secret" {
  type = string
}
variable "resource_group_name" {
  type=string
}
variable "location" {
    default = "koreacentral"
}
variable "vnet_name" {
  type = string
}
variable "cidr" {
  type = list(string)
}
variable "subnet_name" {
  type = list(string)
}
variable "subnet" {
  type = list(string)
}
variable "tags" {
  type = map(string)
}