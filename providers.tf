// sub_id created outside of this module
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

provider "azurerm" {
  alias = "sandbox"
  features {}
  subscription_id = var.sandbox_subscription_id
  tenant_id       = var.tenant_id
}

provider "azurerm" {
  alias = "connectivity"
  features {}
  subscription_id = var.connectivity_subscription_id
  tenant_id       = var.tenant_id
}

// should get data from env
provider "azapi" {
  subscription_id = var.subscription_id
}