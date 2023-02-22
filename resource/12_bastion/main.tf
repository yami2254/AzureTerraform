module "bastion" {
  source               = "../../module/12_bastion"

  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  public_ip            = var.public_ip
  isZones              = var.isZones
  bastion              = var.bastion
}