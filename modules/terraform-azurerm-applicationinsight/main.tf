resource "azurerm_application_insights" "main" {
  name                = var.appinsights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = var.application_insights_type
  retention_in_days   = var.retention_in_days
  disable_ip_masking  = var.disable_ip_masking
  tags                = var.tags
}