module "application_gateway" {
  source = "../../module/applicationgateway"

  resource_group_name = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  appgw_subnet_name = var.appgw_subnet_name
  public_ip = var.public_ip

  isWAF = var.isWAF
  isZones = var.isZones
  
  appgw_config = var.appgw_config

  
}