locals {
  billing_account_name = var.billing_account_name
  billing_profile_name = var.billing_profile_name
  invoice_section_name = var.invoice_section_name // pulled out of browser url from invoices section view
}

data "azurerm_billing_mca_account_scope" "mca" {
  billing_account_name = local.billing_account_name
  billing_profile_name = local.billing_profile_name
  invoice_section_name = local.invoice_section_name
}

data "azurerm_client_config" "current" {}

module "alz-connectivity-subscription-001" {
  source   = "Azure/lz-vending/azurerm"
  version  = "2.1.0"
  location = "uksouth"

  subscription_alias_enabled = true
  subscription_billing_scope = data.azurerm_billing_mca_account_scope.mca.id
  subscription_display_name  = "alz-connectivity-subscription-001"
  subscription_alias_name    = "connectivity-001"
  subscription_workload      = "Production"

  // assuming mg hierarchy exists individual subscirptions can be moved to the appropriate mg
  #   # management group association variables
  #   subscription_management_group_association_enabled = true
  #   subscription_management_group_id                  = "Connectivity"

  virtual_network_enabled = false
  role_assignment_enabled = false

  providers = {
    azurerm = azurerm
  }

}

