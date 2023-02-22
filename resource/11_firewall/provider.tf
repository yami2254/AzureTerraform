terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.43.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = "536e0b63-b5a1-46b2-8908-eccc0a9c27c9"
  client_id       = "310dfeff-2227-4c22-833a-18e1170a5796"
  client_secret   = "	Sgm8Q~JCrbC-V4HNVTPBr_3X2l9YfNU6fETsMdlS"
  tenant_id       = "7d49e97a-1b9b-4907-81aa-24ff1ddf0bda"   
}