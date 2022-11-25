terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.19.0"
    }
    azapi = {
      source = "azure/azapi"
    }
  }
  backend "azurerm" {}
}

// sub_id created outside of this module
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

// should get data from env
provider "azapi" {
  subscription_id = var.subscription_id
}