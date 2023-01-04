locals {
  prefix = "MyOrg"
  default_tags = {
    Project  = ""
    Solution = ""
  }
  billing_account_name = var.billing_account_name
  billing_profile_name = var.billing_profile_name
  invoice_section_name = var.invoice_section_name // pulled out of browser url from invoices section view
  //enrollment_account_name = var.enrollment_account_name // only needed for ea accounts
}

data "azurerm_billing_mca_account_scope" "mca" {
  billing_account_name = local.billing_account_name
  billing_profile_name = local.billing_profile_name
  invoice_section_name = local.invoice_section_name
}

# data azurerm_billing_enrollment_account_scope "ea" {
#   billing_account_name = local.billing_account_name
#   enrollment_account_name = local.enrollment_account_name
# }

data "azurerm_client_config" "current" {}


data "azurerm_management_group" "connectivity" {
  display_name = "Connectivity"
}
data "azurerm_management_group" "identity" {
  display_name = "Identity"
}
data "azurerm_management_group" "management" {
  display_name = "Management"
}
# data azurerm_management_group "sandboxes" {
#   display_name = "Sandboxes"
# }
data "azurerm_management_group" "corp" {
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
  subscription_management_group_association_enabled = true
  subscription_management_group_id                  = data.azurerm_management_group.connectivity.name

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

# module "sandbox_connectivity_uks_rg" {
#   source   = "../terraform-azure-alz-resource-group"
#   name     = "connectivity-uks"
#   location = "uksouth"
#   tags     = local.default_tags
#   providers = {
#     azurerm = azurerm.sandbox
#   }
# }

# module "sandbox_connectivity_ukw_rg" {
#   source   = "../terraform-azure-alz-resource-group"
#   name     = "connectivity-ukw"
#   location = "ukwest"
#   tags     = local.default_tags
#   providers = {
#     azurerm = azurerm.sandbox
#   }
# }

# data "azurerm_virtual_hub" "uksouth" {
#   provider            = azurerm.connectivity
#   name                = "vhub-uksouth"
#   resource_group_name = "${local.prefix}-Connectivity"
# }

# data "azurerm_virtual_hub" "ukwest" {
#   provider            = azurerm.connectivity
#   name                = "vhub-ukwest"
#   resource_group_name = "${local.prefix}-Connectivity"
# }


# module "sub" {
#   subscription_display_name        = "alz-sandbox-subscription-001"
#   subscription_alias_name          = "sandbox-001"
#   subscription_management_group_id = data.azurerm_management_group.management.name
#   location = "uksouth"

#   virtual_networks = {
#     vnet1 = {
#       name          = "vnet_testing_uks"
#       address_space = ["10.120.0.0/24"]
#       location      = "uksouth"
#       //dns_servers       = []
#       vwan_connection_enabled         = true
#       vwan_hub_resource_id            = data.azurerm_virtual_hub.uksouth.id
#       resource_group_name             = module.sandbox_connectivity_uks_rg.name
#       tags                            = local.default_tags
#       resource_group_creation_enabled = false
#     },
#     vnet2 = {
#       name          = "vnet_testing_ukw"
#       address_space = ["10.120.1.0/24"]
#       location      = "ukwest"
#       //dns_servers       = []
#       vwan_connection_enabled         = true
#       vwan_hub_resource_id            = data.azurerm_virtual_hub.ukwest.id
#       resource_group_name             = module.sandbox_connectivity_ukw_rg.name
#       tags                            = local.default_tags
#       resource_group_creation_enabled = false
#     }
#   }
#   subnets = {
#     subnet1 = {
#       name                 = "public-uks"
#       resource_group_name  = module.sandbox_connectivity_uks_rg.name
#       virtual_network_name = basename(module.alz-sandbox-subscription-001.virtual_network_resource_ids.vnet1)
#       address_prefixes     = ["10.120.0.0/26"]
#     }
#     subnet2 = {
#       name                 = "private-uks"
#       resource_group_name  = module.sandbox_connectivity_uks_rg.name
#       virtual_network_name = basename(module.alz-sandbox-subscription-001.virtual_network_resource_ids.vnet1)
#       address_prefixes     = ["10.120.0.64/26"]
#     }
#     subnet3 = {
#       name                 = "public-ukw"
#       resource_group_name  = module.sandbox_connectivity_ukw_rg.name
#       virtual_network_name = basename(module.alz-sandbox-subscription-001.virtual_network_resource_ids.vnet2)
#       address_prefixes     = ["10.120.1.0/26"]
#     }
#     subnet4 = {
#       name                 = "private-ukw"
#       resource_group_name  = module.sandbox_connectivity_ukw_rg.name
#       virtual_network_name = basename(module.alz-sandbox-subscription-001.virtual_network_resource_ids.vnet2)
#       address_prefixes     = ["10.120.1.64/26"]
#     }
#   }
# }


module "alz-sandbox-subscription-001" {
  source   = "Azure/lz-vending/azurerm"
  version  = "2.1.0"
  location = "uksouth"

  subscription_alias_enabled = true
  subscription_billing_scope = data.azurerm_billing_mca_account_scope.mca.id
  subscription_display_name  = "alz-sandbox-subscription-001"
  subscription_alias_name    = "sandbox-001"
  subscription_workload      = "Production"

  subscription_management_group_association_enabled = true
  subscription_management_group_id                  = data.azurerm_management_group.management.name

  virtual_network_enabled = false

  virtual_networks = {
    vnet1 = {
      name          = "vnet_testing_uks"
      address_space = ["10.120.0.0/24"]
      location      = "uksouth"
      //dns_servers       = []
      vwan_connection_enabled         = true
      vwan_hub_resource_id            = data.azurerm_virtual_hub.uksouth.id
      resource_group_name             = module.sandbox_connectivity_uks_rg.name
      tags                            = local.default_tags
      resource_group_creation_enabled = false
    },
    vnet2 = {
      name          = "vnet_testing_ukw"
      address_space = ["10.120.1.0/24"]
      location      = "ukwest"
      //dns_servers       = []
      vwan_connection_enabled         = true
      vwan_hub_resource_id            = data.azurerm_virtual_hub.ukwest.id
      resource_group_name             = module.sandbox_connectivity_ukw_rg.name
      tags                            = local.default_tags
      resource_group_creation_enabled = false
    }
  }

  role_assignment_enabled = false
  disable_telemetry       = true

  subscription_tags = {
    terraform_managed = "true"
    source            = "Azure/lz-vending/azurerm"
    source_version    = "2.1.0"
  }

  depends_on = [
    module.sandbox_connectivity_uks_rg,
    module.sandbox_connectivity_ukw_rg
  ]

  providers = {
    azurerm = azurerm
    azapi   = azapi
  }
}

// add -spoke to the name
# module "alz-sandbox-subscription-001-subnets" {
#   source = "../terraform-azure-alz-subnet"
#   subnets = {
#     subnet1 = {
#       name                 = "public"
#       resource_group_name  = module.sandbox_connectivity_uks_rg.name
#       virtual_network_name = basename(module.alz-sandbox-subscription-001.virtual_network_resource_ids.vnet1)
#       address_prefixes     = ["10.120.0.0/26"]
#     }
#     subnet2 = {
#       name                 = "private"
#       resource_group_name  = module.sandbox_connectivity_uks_rg.name
#       virtual_network_name = basename(module.alz-sandbox-subscription-001.virtual_network_resource_ids.vnet1)
#       address_prefixes     = ["10.120.0.64/26"]
#     }
#     subnet3 = {
#       name                 = "public"
#       resource_group_name  = module.sandbox_connectivity_ukw_rg.name
#       virtual_network_name = basename(module.alz-sandbox-subscription-001.virtual_network_resource_ids.vnet2)
#       address_prefixes     = ["10.120.1.0/26"]
#     }
#     subnet4 = {
#       name                 = "private"
#       resource_group_name  = module.sandbox_connectivity_ukw_rg.name
#       virtual_network_name = basename(module.alz-sandbox-subscription-001.virtual_network_resource_ids.vnet2)
#       address_prefixes     = ["10.120.1.64/26"]
#     }
#   }
#   providers = {
#     azurerm = azurerm.sandbox
#   }
# }


# module "vm" {
#   for_each            = module.alz-sandbox-subscription-001-subnets.subnets
#   source              = "../terraform-azure-alz-vm"
#   name                = each.value.name
#   location            = each.value.resource_group_name == module.sandbox_connectivity_ukw_rg.name ? module.sandbox_connectivity_ukw_rg.location : module.sandbox_connectivity_uks_rg.location
#   resource_group_name = each.value.resource_group_name == module.sandbox_connectivity_ukw_rg.name ? module.sandbox_connectivity_ukw_rg.name : module.sandbox_connectivity_uks_rg.name
#   size                = "Standard_D2as_v4"
#   subnet_id           = each.value.id
#   tags                = local.default_tags

#   providers = {
#     azurerm = azurerm.sandbox
#   }
# }
