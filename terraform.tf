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

# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = ">= 3.36.0"
#     }
#     azapi = {
#       source = "azure/azapi"
#     }
#   }
#   backend "azurerm" {
#     resoure_group_name   = var.resource_group_name
#     storage_account_name = var.storage_account_name
#     container_name       = var.container_name
#     key                  = var.key
#   }
# }