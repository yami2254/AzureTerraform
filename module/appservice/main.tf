provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "Korea Central"
}

resource "azurerm_service_plan" "linux-service-plan" {
  count = var.islinuxwebapp ? 1:0  
  name                = "example"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  os_type             = "Linux"
  sku_name            = var.sku_name
}

resource "azurerm_linux_web_app" "linux-web-app" {
  for_each            = (var.islinuxwebapp == true ? {for each in var.linuxwebapp : each.name => each} : {})
  name                = each.value.name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_service_plan.linux-service-plan[0].location
  service_plan_id     = azurerm_service_plan.linux-service-plan[0].id


  site_config {
    
  }
}

resource "azurerm_service_plan" "windows-service-plan" {
  count = var.iswindowswebapp ? 1:0  
  name                = "examplekoo2"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  os_type             = "Windows"
  sku_name            = var.sku_name
}

resource "azurerm_windows_web_app" "windows-web-app" {
  for_each            = (var.iswindowswebapp == true ? {for each in var.windowswebapp : each.name => each} : {})
  name                = each.value.name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_service_plan.windows-service-plan[0].location
  service_plan_id     = azurerm_service_plan.windows-service-plan[0].id

  site_config {}
}
