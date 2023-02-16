terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.1.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id=var.subid #"8b5a97da-b5ce-4edb-b1f6-26301f0214af"
  tenant_id="a291953b-a95f-4c1e-8127-00ffdb5b7f6c"
  client_id="22a038d8-2667-4882-8088-870d397b172d"
  client_secret="irX8Q~RnXizegveUEzs6Rh8T4L7aF-3zzP-aJagX"
}