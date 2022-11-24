output "subscription_billing_scope" {
  value = data.azurerm_billing_mca_account_scope.mca.id
}

output "account_id" {
  value = data.azurerm_client_config.current.client_id
}