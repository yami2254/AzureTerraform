data "azurerm_resource_group" "rg" {
  name                        = var.resource_group_name
}
data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "keyvault" {
  name                        = var.keyvault.name
  location                    = data.azurerm_resource_group.rg.location
  resource_group_name         = data.azurerm_resource_group.rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id

  sku_name                    = var.keyvault.sku_name

  soft_delete_retention_days  = var.keyvault.soft_delete_retention_days
  purge_protection_enabled    = var.keyvault.purge_protection_enabled


}