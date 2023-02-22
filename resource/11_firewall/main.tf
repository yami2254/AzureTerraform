module "firewall" {
  source = "../../module/11_firewall"

  resource_group_name = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  public_ip = var.public_ip

  firewall-policy = var.firewall-policy
  isZones = var.isZones
  firewall = var.firewall

  
}