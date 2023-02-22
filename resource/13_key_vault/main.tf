module "keyvault" {
  source = "../../module/13_key_vault"

  resource_group_name = var.resource_group_name
  keyvault            = var.keyvault
}