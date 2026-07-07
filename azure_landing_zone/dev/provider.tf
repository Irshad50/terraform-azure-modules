terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.78.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg_eri5"
    storage_account_name = "eric5storage"
    container_name       = "state1u"
    key                  = "iq-terraform.tfstate"
  }
}
provider "azurerm" {
  features {}
}