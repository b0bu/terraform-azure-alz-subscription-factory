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

data azure_management_group "connectivity" {
  display_name = "Connectivity"
}
data azure_management_group "identity" {
  display_name = "Identity"
}
data azure_management_group "management" {
  display_name = "Management"
}
data azure_management_group "sandboxes" {
  display_name = "Sandboxes"
}
data azure_management_group "corp" {
  display_name = "Corp"
}


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
  #   subscription_management_group_association_enabled = true
  #   subscription_management_group_id                  = data.azure_management_group.connectivity.name

  virtual_network_enabled = false
  role_assignment_enabled = false
  disable_telemetry       = true

  subscription_tags = {
    terraform_managed = "true"
    source            = "Azure/lz-vending/azurerm"
    source_version    = "2.1.0"
  }

  providers = {
    azurerm = azurerm
  }
}

module "alz-identity-subscription-001" {
  source   = "Azure/lz-vending/azurerm"
  version  = "2.1.0"
  location = "uksouth"

  subscription_alias_enabled = true
  subscription_billing_scope = data.azurerm_billing_mca_account_scope.mca.id
  subscription_display_name  = "alz-identity-subscription-001"
  subscription_alias_name    = "identity-001"
  subscription_workload      = "Production"

  // assuming mg hierarchy exists individual subscirptions can be moved to the appropriate mg
  #   subscription_management_group_association_enabled = true
  #   subscription_management_group_id                  = data.azure_management_group.connectivity.name

  virtual_network_enabled = false
  role_assignment_enabled = false
  disable_telemetry       = true

  subscription_tags = {
    terraform_managed = "true"
    source            = "Azure/lz-vending/azurerm"
    source_version    = "2.1.0"
  }

  providers = {
    azurerm = azurerm
    azapi   = azapi
  }
}

module "alz-management-subscription-001" {
  source   = "Azure/lz-vending/azurerm"
  version  = "2.1.0"
  location = "uksouth"

  subscription_alias_enabled = true
  subscription_billing_scope = data.azurerm_billing_mca_account_scope.mca.id
  subscription_display_name  = "alz-management-subscription-001"
  subscription_alias_name    = "management-001"
  subscription_workload      = "Production"

  // assuming mg hierarchy exists individual subscirptions can be moved to the appropriate mg
  #  subscription_management_group_association_enabled = true
  #  subscription_management_group_id                  = data.azure_management_group.management.name

  virtual_network_enabled = false
  role_assignment_enabled = false
  disable_telemetry       = true

  subscription_tags = {
    terraform_managed = "true"
    source            = "Azure/lz-vending/azurerm"
    source_version    = "2.1.0"
  }

  providers = {
    azurerm = azurerm
    azapi   = azapi
  }
}

module "alz-sandbox-subscription-001" {
  source   = "Azure/lz-vending/azurerm"
  version  = "2.1.0"
  location = "uksouth"

  subscription_alias_enabled = true
  subscription_billing_scope = data.azurerm_billing_mca_account_scope.mca.id
  subscription_display_name  = "alz-sandbox-subscription-001"
  subscription_alias_name    = "sandbox-001"
  subscription_workload      = "Production"

  // assuming mg hierarchy exists individual subscirptions can be moved to the appropriate mg
  #  subscription_management_group_association_enabled = true
  #  subscription_management_group_id                  = data.azure_management_group.sandboxes.name

  virtual_network_enabled = false
  role_assignment_enabled = false
  disable_telemetry       = true

  subscription_tags = {
    terraform_managed = "true"
    source            = "Azure/lz-vending/azurerm"
    source_version    = "2.1.0"
  }

  providers = {
    azurerm = azurerm
    azapi   = azapi
  }
}

module "alz-corp-subscription-001" {
  source   = "Azure/lz-vending/azurerm"
  version  = "2.1.0"
  location = "uksouth"

  subscription_alias_enabled = true
  subscription_billing_scope = data.azurerm_billing_mca_account_scope.mca.id
  subscription_display_name  = "alz-corp-subscription-001"
  subscription_alias_name    = "corp-001"
  subscription_workload      = "DevTest"

  // assuming mg hierarchy exists individual subscirptions can be moved to the appropriate mg
  #   subscription_management_group_association_enabled = true
  #   subscription_management_group_id                  = data.azure_management_group.corp.name

  virtual_network_enabled = false
  role_assignment_enabled = false
  disable_telemetry       = true

  subscription_tags = {
    terraform_managed = "true"
    source            = "Azure/lz-vending/azurerm"
    source_version    = "2.1.0"
  }

  providers = {
    azurerm = azurerm
    azapi   = azapi
  }
}


module "alz-corp-subscription-002" {
  source   = "Azure/lz-vending/azurerm"
  version  = "2.1.0"
  location = "ukwest"

  subscription_alias_enabled = true
  subscription_billing_scope = data.azurerm_billing_mca_account_scope.mca.id
  subscription_display_name  = "alz-corp-subscription-002"
  subscription_alias_name    = "corp-002"
  subscription_workload      = "DevTest"

  // assuming mg hierarchy exists individual subscirptions can be moved to the appropriate mg
  #   subscription_management_group_association_enabled = true
  #   subscription_management_group_id                  = data.azure_management_group.corp.name

  virtual_network_enabled = false
  role_assignment_enabled = false
  disable_telemetry       = true

  subscription_tags = {
    terraform_managed = "true"
    source            = "Azure/lz-vending/azurerm"
    source_version    = "2.1.0"
  }

  providers = {
    azurerm = azurerm
    azapi   = azapi
  }
}