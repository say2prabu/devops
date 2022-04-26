data "azurerm_application_insights" "main" {
  count               = var.application_insights_enabled && var.application_insights_id != null ? 1 : 0
  name                = split("/", var.application_insights_id)[8]
  resource_group_name = split("/", var.application_insights_id)[4]
}