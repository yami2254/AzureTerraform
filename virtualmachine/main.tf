provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg_exist" {
    name     = "a-rg"
}

resource "azurerm_service_plan" "example" {
    name                = "${var.appservice_plan.name}"
    resource_group_name = data.azurerm_resource_group.rg_exist.name
    location            = data.azurerm_resource_group.rg_exist.location
    os_type             = "${var.appservice_plan.os_type}"
    sku_name            = "${var.appservice_plan.sku_name}"
}

resource "azurerm_linux_web_app" "linux_webapp" {
    for_each            = var.appservice
    name                = each.value.name
    resource_group_name = data.azurerm_resource_group.rg_exist.name
    location            = data.azurerm_resource_group.rg_exist.location
    service_plan_id     = azurerm_service_plan.example.id

    site_config {}
}
