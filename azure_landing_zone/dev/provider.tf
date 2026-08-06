terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "Backend_Rg"
    storage_account_name = "eric5storage09"
    container_name       = "devesource"
    key                  = "preprod_terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}